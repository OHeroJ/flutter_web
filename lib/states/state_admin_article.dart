import 'package:flutter/cupertino.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/model/model.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/states/global_user_state.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oktoast/oktoast.dart';

class StateAdminArticle extends ViewStateModel {
  final GlobalUserState globalUser;
  StateAdminArticle({@required this.globalUser});

  List<Topic> _topics = [];

  List<Topic> get topics => _topics;

  final repository = locator<WebRepository>();

  bool _hasNext;
  bool get hasNext => _hasNext;

  bool _hasPreview;
  bool get hasPreview => _hasPreview;

  loadTopics({
    int page = 1,
    int per = 10,
  }) async {
    setBusy();
    try {
      var response = await repository.getTopicList(page: page, per: per);
      _hasPreview = response.metadata.page > 1;
      _hasNext = response.metadata.total >
          response.metadata.page * response.metadata.per;
      _topics = response.items;
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  void addTopic(Topic topic) {
    _topics.add(topic);
    notifyListeners();
  }

  void deleteTopic(Topic topic, context) {
    repository
        .deleteTopic(id: topic.id, token: globalUser.token.accessToken)
        .then((value) {
      _topics.remove(topic);
      notifyListeners();
      showToast('删除成功', context: context);
    });
  }
}
