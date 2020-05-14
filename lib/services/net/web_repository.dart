import 'package:flutter_web/services/net/models/model_page_data.dart';
import 'package:flutter_web/services/net/models/model_token.dart';
import 'package:flutter_web/services/net/models/model_user.dart';
import 'models/model_topic.dart';
import 'package:dio/dio.dart';
import 'models/api.dart';

class WebRepository {
  Future<List<ModelTopic>> getTopics({int page = 1, int per = 10}) async {
    var response = await http
        .get('/topic/list', queryParameters: {"page": page, "per": per});
    Map data = response.data;
    return ModelPageData.fromMap(data).data.map<ModelTopic>((item) {
      return ModelTopic.fromMap(item['topic']);
    }).toList();
  }

  Future<ModelTopic> getTopicDetail(int topicId) async {
    var response = await http.get('/topic/$topicId');
    Map data = response.data;
    return ModelTopic.fromMap(data['topic']);
  }

  Future<ModelToken> login(String email, String password) async {
    var response = await http.post('/users/login',
        data: FormData.fromMap({'email': email, 'password': password}));
    Map data = response.data;
    return ModelToken.fromMap(data);
  }
}
