import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/services/services.dart';

class StateArticleDetail extends ViewStateModel {
  ModelTopic get topic => _topic;
  ModelTopic _topic;

  Future<ModelTopic> getTopic(int topicId) async {
    setBusy();
    _topic = await locator<WebRepository>().getTopicDetail(topicId);
    setIdle();
    return _topic;
  }
}
