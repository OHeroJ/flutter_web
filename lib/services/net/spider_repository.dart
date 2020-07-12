import 'package:flutter_web/model/model.dart';

import 'api.dart';

class SpiderRepository {
  Future<List<SpiderTopic>> getNewsList() async {
    var response = await http.get(
      "http://127.0.0.1:5000/spider/list",
    );
    List data = response.data;
    return data.map((e) => SpiderTopic.fromMap(e)).toList();
  }

  Future<Map> refreshSpider() async {
    var response = await http.get(
      'http://127.0.0.1:5000/spider/start',
    );
    Map data = response.data;
    return data;
  }
}
