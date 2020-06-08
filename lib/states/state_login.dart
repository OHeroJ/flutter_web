import 'package:flutter/material.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/macro.dart';
import 'package:flutter_web/services/services.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oktoast/oktoast.dart';

import 'global_user_state.dart';

class StateLogin extends ViewStateModel {
  final GlobalUserState globalUserState;

  StateLogin({@required this.globalUserState});

  final repository = locator<WebRepository>();

  String _email;
  String get email => _email;

  String _password;
  String get password => _password;

  bool _enableLogin = false;
  bool get enableLogin => _enableLogin;

  bool get sending => viewState == ViewState.busy;

  void setEmail(String email) {
    _email = email;
    changeEnableLogin();
  }

  void setPassword(String password) {
    _password = password;
    changeEnableLogin();
  }

  void changeEnableLogin() {
    if (_email != null &&
        _email.isNotEmpty &&
        _password != null &&
        _password.isNotEmpty) {
      _enableLogin = true;
    } else {
      _enableLogin = false;
    }
    notifyListeners();
  }

  /// 登录
  Future<ModelLogin> login({BuildContext context}) async {
    if (sending) {
      return null;
    }
    if (!RegexUtil.isEmail(email)) {
      showToast("请输入正确的邮箱");
      return null;
    }
    if (password.length < 6) {
      showToast("请输入 6 位以上密码");
      return null;
    }
    setBusy();
    try {
      final result = await repository.login(email: email, pwd: password);
      globalUserState.login(user: result.user, token: result.token);
      setIdle();
      return result;
    } catch (e, s) {
      setError(e, s);
      showErrorMessage(context, message: viewStateError.message);
      return null;
    }
  }
}
