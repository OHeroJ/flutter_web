import 'package:dio/dio.dart';
import 'package:flutter_web/states/global_user_state.dart';
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

  /// Tag 管理
  Future<List<Tag>> getAllTags() async {
    var response = await http.get('/tag/all');
    List data = response.data;
    return data.map((e) => Tag.fromMap(e)).toList();
  }

  Future createTag({
    String name,
    String remarks,
    String token,
  }) async {
    var response = await http.post(
      '/tag/add',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: FormData.fromMap({"name": name, "remarks": remarks}),
    );
    Map data = response.data;
    return Tag.fromMap(data);
  }

  Future deleteTag({String id, String token}) async {
    return await http.post(
      '/tag/delete/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  // Subject 管理
  Future<List<Subject>> subjectAll() async {
    var response = await http.get("/subject/all");
    List data = ValueUtil.toList(response.data);
    return data.map((item) => Subject.fromMap(item)).toList();
  }

  Future createSubject({
    String name,
    String remarks,
    String cover,
    String token,
  }) async {
    var response = await http.post(
      '/subject/add',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: FormData.fromMap({
        "name": name,
        "remarks": remarks,
        "cover": cover,
      }),
    );
    Map data = response.data;
    return Subject.fromMap(data);
  }

  Future deleteSubject({String id, String token}) async {
    return await http.post(
      '/subject/delete/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
