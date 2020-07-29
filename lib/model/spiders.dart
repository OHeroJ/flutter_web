import 'base.dart';
import 'package:loveli_core/loveli_core.dart';

class SpiderTopic implements Base {
  String id;
  String title;
  String url;
  String desc;
  String time;
  String detail;
  String tag; // 去重标识
  String source; // 来源
  int createTime;
  bool isUpload;

  SpiderTopic.fromMap(Map json) {
    Map idMap = ValueUtil.toMap(json['_id']);
    id = ValueUtil.toStr(idMap['\$oid']);
    title = ValueUtil.toStr(json['title']);
    url = ValueUtil.toStr(json['url']);
    desc = ValueUtil.toStr(json['desc']);
    time = ValueUtil.toStr(json['time']);
    detail = ValueUtil.toStr(json['detail']);
    tag = ValueUtil.toStr(json['tag']);
    source = ValueUtil.toStr(json['source']);
    createTime = ValueUtil.toInt(json['create_time']);
    isUpload = ValueUtil.toInt(json['is_upload']) > 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'desc': desc,
      'time': time,
      'detail': detail,
      'tag': tag,
      'source': source,
    };
  }
}
