import 'package:loveli_core/loveli_core.dart';

class ModelTopic {
  final int id;
  final String title;
  final int subjectId;
  final int userId;
  final String content;
  final int textType; // 1. markdown 2.html
  final int createdAt;

  ModelTopic.fromMap(Map json)
      : id = ValueUtil.toInt(json['id']),
        subjectId = ValueUtil.toInt(json['subjectId']),
        userId = ValueUtil.toInt(json['userId']),
        content = ValueUtil.toStr(json['content']),
        textType = ValueUtil.toInt(json['textType']),
        createdAt = ValueUtil.toInt(json['createdAt']),
        title = ValueUtil.toStr(json['title']);
  Map toJson() {
    return {};
  }
}
