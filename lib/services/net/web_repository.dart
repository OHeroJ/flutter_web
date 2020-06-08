import 'package:dio/dio.dart';
import 'api.dart';
import 'models.dart';
import 'package:flutter_web/model/model.dart';
import 'package:loveli_core/loveli_core.dart';

class WebRepository {
  // Auth
  Future<ModelLogin> login({String email, String pwd}) async {
    var response = await http.post("/auth/login",
        data: FormData.fromMap({"email": email, "password": pwd}));
    Map data = response.data;
    return ModelLogin.fromMap(data);
  }

  // Subject
  Future<List<Subject>> subjectAll() async {
    var response = await http.get("/subject/all");
    List data = ValueUtil.toList(response.data);
    return data.map((item) => Subject.fromMap(item)).toList();
  }

  Future<ModelPage<Topic>> subjectTopics(String subjectId,
      {int page, int per = 10}) async {
    var response = await http.get("/subject/$subjectId/topics",
        queryParameters: {"per": per, "page": page});
    Map data = response.data;
    return ModelPage<Topic>.fromMap(data, transform: (json) {
      return Topic.fromMap(json);
    });
  }

  Future<Topic> topicDetail(String topicId) async {
    var response = await http.get("/topic/$topicId");
    Map data = response.data;
    return Topic.fromMap(data);
  }

  Future<ModelPage<Booklet>> booklets({int page, int per = 10}) async {
    var response = await http.get('/booklet/list');
    Map data = response.data;
    return ModelPage<Booklet>.fromMap(data, transform: (json) {
      return Booklet.fromMap(json);
    });
  }

  Future<Booklet> bookletDetail(String bookletId) async {
    var response = await http.get("/booklet/$bookletId");
    Map data = response.data;
    return Booklet.fromMap(data);
  }

  Future<List<Catalog>> bookletCatalogs(String catalogId) async {
    var response = await http.get("/booklet/catalog/$catalogId");
    List data = response.data;
    return data.map((e) => Catalog.fromMap(e)).toList();
  }
}
