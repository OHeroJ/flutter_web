import 'package:flutter_web/models/model_page_data.dart';
import 'package:flutter_web/models/model_topic.dart';

import 'api.dart';

class WebRepository {
  Future<List<ModelTopic>> getTopics({int page = 1, int per = 10}) async {
    var response = await http
        .get('/topic/list', queryParameters: {"page": page, "per": per});
    Map data = response.data;
    return ModelPageData.fromMap(data).data.map<ModelTopic>((item) {
      return ModelTopic.fromMap(item['topic']);
    }).toList();
  }
}
