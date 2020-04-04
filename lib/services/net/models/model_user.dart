import 'package:loveli_core/loveli_core.dart';

class ModelUser {
  final String avatar;
  final int id;
  final String name;
  final String email;

  ModelUser.fromMap(Map json)
      : id = ValueUtil.toInt(json['id']),
        name = ValueUtil.toStr(json['name']),
        email = ValueUtil.toStr(json['email']),
        avatar = ValueUtil.toStr(json['avator']);

  Map toJson() {
    return {};
  }
}
