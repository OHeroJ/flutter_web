import 'package:flutter/cupertino.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/model/model.dart';

class ModelLogin {
  Token token;
  User user;

  ModelLogin.fromMap(Map json) {
    token = Token.fromMap(json['token']);
    user = User.fromMap(json['user']);
  }
}

class ModelPage<T> {
  List<T> items;
  Metadata metadata;

  ModelPage.fromMap(Map json, {@required T Function(Map json) transform}) {
    items = ValueUtil.toList(json['items']).map((j) => transform(j)).toList();
    metadata = Metadata.fromMap(ValueUtil.toMap(json['metadata']));
  }
}
