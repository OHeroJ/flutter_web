import 'package:loveli_core/loveli_core.dart';
import 'base.dart';

class Tag implements Base {
  String id;
  String name;

  String get showName => '#$name';

  Tag.fromMap(Map json) {
    id = ValueUtil.toStr(json['id']);
    name = ValueUtil.toStr(json['name']);
  }
}
