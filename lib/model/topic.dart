import 'package:loveli_core/loveli_core.dart';

import 'subject.dart';
import 'user.dart';
import 'tag.dart';
import 'base.dart';

enum TopicContentType { markdown, html }

TopicContentType _topicContentType(String name) {
  if (name == 'markdown') {
    return TopicContentType.markdown;
  } else if (name == 'html') {
    return TopicContentType.html;
  } else {
    return TopicContentType.markdown;
  }
}

class Topic implements Base {
  int weight;
  User author;
  String id;
  TopicContentType contentType; //markdown|html
  String title;
  Subject subject;
  double createdAt;
  String content;

  String get showContent {
    return "# $title\n $content";
  }

  String get showTime {
    int milliseconds = (createdAt * 1000).round();
    int nowMilliseconds = DateUtil.getNowDateMs();
    int delt = nowMilliseconds - milliseconds;

    if (delt < 1000 * 60) {
      // 1 分钟内
      return "刚刚";
    } else if (delt < 1000 * 60 * 60) {
      // 1 小时内
      int minus = (delt / (1000 * 60)).round();
      return "$minus分钟前";
    } else if (delt < 1000 * 60 * 60 * 24) {
      // 1 天前
      int house = (delt / (1000 * 60 * 60)).round();
      return "$house小时前";
    } else if (delt < 1000 * 60 * 60 * 24 * 2) {
      // 昨天
      return "昨天";
    } else {
      return DateUtil.formatDateMs(milliseconds, format: "MM-dd HH:mm");
    }
  }

  List<Tag> tags;
  String cover;
  String remarks;

  Topic.fromMap(Map json) {
    weight = ValueUtil.toInt(json['weight']);
    author = User.fromMap(ValueUtil.toMap(json['author']));
    title = ValueUtil.toStr(json['title']);
    subject = Subject.fromMap(ValueUtil.toMap(json['subject']));
    id = ValueUtil.toStr(json['id']);
    contentType = _topicContentType(ValueUtil.toStr(json['contentType']));
    createdAt = ValueUtil.toDouble(json['createdAt']);
    cover = ValueUtil.toStr(json['cover']);
    remarks = ValueUtil.toStr(json['remarks']);
    tags = ValueUtil.toList(json['tags']).map((j) => Tag.fromMap(j)).toList();
    content = ValueUtil.toStr(json['content']);
  }
}
