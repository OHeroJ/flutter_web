import 'package:loveli_core/loveli_core.dart';
import 'base.dart';
import 'user.dart';

class Booklet extends Base {
  String name;
  String cover;
  String remarks;
  User author;
  String catalogId;
  String id;

  Booklet.fromMap(Map json) : super.fromMap(json) {
    this.name = ValueUtil.toStr(json['name']);
    this.cover = ValueUtil.toStr(json['cover']);
    this.remarks = ValueUtil.toStr(json['remarks']);
    this.author = User.fromMap(ValueUtil.toMap(json['author']));
    this.catalogId = ValueUtil.toStr(json['catalogId']);
    this.id = ValueUtil.toStr(json['id']);
  }
}
