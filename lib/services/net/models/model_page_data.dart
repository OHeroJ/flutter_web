import 'package:loveli_core/loveli_core.dart';

class PageInfo {
  final PageInfoData data;
  final PagePosition position;
  PageInfo.fromMap(Map json)
      : position = PagePosition.fromMap(json['position']),
        data = PageInfoData.fromMap(json['data']);
}

class PageInfoData {
  final int per;
  final int total;
  PageInfoData.fromMap(Map json)
      : total = ValueUtil.toInt(json['total']),
        per = ValueUtil.toInt(json['per']);
}

class PagePosition {
  final int next;
  final int max;
  final int current;

  PagePosition.fromMap(Map json)
      : max = ValueUtil.toInt(json['max']),
        current = ValueUtil.toInt(json['current']),
        next = ValueUtil.toInt(json['next']);
}

class ModelPageData {
  final PageInfo page;
  final List data;

  ModelPageData.fromMap(Map json)
      : data = ValueUtil.toList(json['data']),
        page = PageInfo.fromMap(json['page']);
}
