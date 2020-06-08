import 'package:loveli_core/loveli_core.dart';
import 'base.dart';

class Metadata implements Base {
  int per;
  int total;
  int page;

  Metadata.fromMap(Map json) {
    per = ValueUtil.toInt(json['per']);
    total = ValueUtil.toInt(json['total']);
    page = ValueUtil.toInt(json['page']);
  }
}
