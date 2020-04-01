import 'package:flutter_web/core/provider/view_state_model.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/models/model_topic.dart';
import 'package:flutter_web/services/web_repository.dart';

class ArticleDetailViewModel extends ViewStateModel {
  ModelTopic get topic => _topic;
  ModelTopic _topic;

  Future<ModelTopic> getTopic(int topicId) async {
    setBusy();
    _topic = await locator<WebRepository>().getTopicDetail(topicId);
    setIdle();
    return _topic;
  }
}
