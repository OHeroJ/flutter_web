import 'package:loveli_core/loveli_core.dart';
import 'base.dart';

class Token implements Base {
  String accessToken;
  double expiresAt;
  String refreshToken;

  Token.fromMap(Map json) {
    accessToken = ValueUtil.toStr(json['accessToken']);
    expiresAt = ValueUtil.toDouble(json['expiresAt']);
    refreshToken = ValueUtil.toStr(json['refreshToken']);
  }

  Map toMap() {
    return {
      "accessToken": accessToken,
      "expiresAt": expiresAt,
      "refreshToken": refreshToken
    };
  }
}
