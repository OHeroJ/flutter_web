import 'package:flutter_web/locator.dart';
import 'package:flutter_web/macro.dart';
import 'package:flutter_web/services/services.dart';
import 'package:loveli_core/loveli_core.dart';

class StateLogin extends ViewStateModel {
  String _email;
  String _password;

  String get email => _email;
  String get password => _password;

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  Future login() async {
    setBusy();
    try {
      var token = await locator<WebRepository>().login(email, password);
      setIdle();
      SpUtil.putObject(Macro.spKeyToken, token.toMap());
    } catch (e, s) {
      setError(e, s);
    }
  }
}
