import 'package:flutter/services.dart';
import 'package:loveli_core/loveli_core.dart';

import 'base.dart';

class Catalog extends Base {
  String id;
  String pid;
  String title;
  String path;

  int level;
  int order;

  String topicId;
  List<Catalog> child;

  Catalog.fromMap(Map json) : super.fromMap(json) {
    this.id = ValueUtil.toStr(json['id']);
    this.pid = ValueUtil.toStr(json['pid']);
    this.title = ValueUtil.toStr(json['title']);
    this.path = ValueUtil.toStr(json['path']);
    this.level = ValueUtil.toInt(json['level']);
    this.order = ValueUtil.toInt(json['order']);
    this.topicId = ValueUtil.toStr(json['topicId']);
    this.child =
        ValueUtil.toList(json['child']).map((e) => Catalog.fromMap(e)).toList();
  }
}
