import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web/model/model.dart';
import 'package:loveli_core/loveli_core.dart';

import 'api.dart';
import 'models.dart';

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
  Future<List<Subject>> getAllSubject() async {
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

  // Topic
  Future createTopic({
    String title,
    String content,
    String subjectId,
    String contentType,
    List<String> tagIds,
    String remarks,
    String token,
    String coverUrl,
  }) async {
    var response = await http.post(
      '/topic/add',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: FormData.fromMap({
        "title": title,
        "content": content,
        "subjectId": subjectId,
        "contentType": contentType,
        "tagIds": tagIds.join(','),
        "remarks": remarks,
        "cover": coverUrl,
        "weight": 1,
      }),
    );
    Map data = response.data;
    return Topic.fromMap(data);
  }

  Future<ModelPage<Topic>> getTopicList({int per, int page}) async {
    var response = await http
        .get("/topic/all", queryParameters: {"per": per, "page": page});
    Map data = response.data;
    return ModelPage<Topic>.fromMap(data, transform: (json) {
      return Topic.fromMap(json);
    });
  }

  Future deleteTopic({String id, String token}) async {
    return await http.post(
      '/topic/delete/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  /// booklet
  Future<ModelPage<Booklet>> getBookletList({int per, int page}) async {
    var response = await http
        .get("/booklet/list", queryParameters: {"per": per, "page": page});
    Map data = response.data;
    return ModelPage<Booklet>.fromMap(data, transform: (json) {
      return Booklet.fromMap(json);
    });
  }

  Future<Booklet> createBooklet(
      {String name, String remarks, String cover, String token}) async {
    var response = await http.post(
      '/booklet/add',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: FormData.fromMap({
        'name': name,
        'remarks': remarks,
        'cover': cover,
      }),
    );
    Map data = response.data;
    return Booklet.fromMap(data);
  }

  Future<List<Catalog>> getCatalogs({String catalogId}) async {
    var response = await http.get('/booklet/catalog/$catalogId');
    List data = ValueUtil.toList(response.data);
    return data.map((item) => Catalog.fromMap(item)).toList();
  }

  Future<Catalog> createCatalog({
    String title,
    String pid,
    String path,
    String content,
    int level,
    int order,
    String remarks,
    String token,
  }) async {
    var response = await http.post(
      '/booklet/catalog/add',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: FormData.fromMap({
        'title': title,
        'remarks': remarks,
        'pid': pid,
        'path': path,
        'content': content,
        'level': level,
        'order': order,
      }),
    );
    Map data = response.data;
    return Catalog.fromMap(data);
  }

  Future<Catalog> updateCatalog({
    @required String id,
    String title,
    String pid,
    String path,
    String content,
    int level,
    int order,
    String remarks,
    String topicId,
    String token,
  }) async {
    var response = await http.post(
      '/booklet/catalog/update',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: FormData.fromMap({
        'id': id,
        'title': title,
        'remarks': remarks,
        'pid': pid,
        'path': path,
        'content': content,
        'level': level,
        'order': order,
        'topicId': topicId,
      }),
    );
    Map data = response.data;
    return Catalog.fromMap(data);
  }

  Future<String> deleteCatalog({String catalogId, String token}) async {
    var response = await http.post(
      '/booklet/catalog/delete/$catalogId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    String data = response.data;
    return data;
  }
}
