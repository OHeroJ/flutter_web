import 'package:flutter/cupertino.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/model/model.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/states/global_user_state.dart';
import 'package:loveli_core/loveli_core.dart';

class StateAdminSpider extends ViewStateModel {
  final GlobalUserState globalUser;
  StateAdminSpider({@required this.globalUser});

  List<SpiderTopic> _topics = [];

  List<SpiderTopic> get topics => _topics;

  final repository = locator<SpiderRepository>();

  loadTopics() async {
    setBusy();
    try {
      _topics = await repository.getNewsList();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  refreshSpider() async {
    Map result = await repository.refreshSpider();
    return result;
  }
}
