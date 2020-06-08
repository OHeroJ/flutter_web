import 'package:loveli_core/loveli_core.dart';
import 'base.dart';

class Subject implements Base {
  String id;
  String name;

  Subject.fromMap(Map json) {
    id = ValueUtil.toStr(json["id"]);
    name = ValueUtil.toStr(json["name"]);
  }
}
