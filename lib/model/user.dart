import 'package:loveli_core/loveli_core.dart';
import 'base.dart';

class User implements Base {
  String id;
  String name;
  String email;
  String avatar;

  User.fromMap(Map json) {
    id = ValueUtil.toStr(json['id']);
    name = ValueUtil.toStr(json['name']);
    email = ValueUtil.toStr(json['email']);
    avatar = ValueUtil.toStr(json['avatar']);
  }

  Map toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "avatar": avatar,
    };
  }
}
