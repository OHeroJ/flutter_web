import 'package:flutter/cupertino.dart';
import 'package:flutter_web/states/global_user_state.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/model/model.dart';
import 'package:flutter_web/locator.dart';
import 'package:oktoast/oktoast.dart';

class StateAdminSubject extends ViewStateModel {
  String _name;
  String _remarks;

  final GlobalUserState globalUser;
  StateAdminSubject({@required this.globalUser});

  List<Subject> _subjects = [];
  List<Subject> get subjects => _subjects;
  final repository = locator<WebRepository>();
  loadSubjects() async {
    setBusy();
    try {
      _subjects = await repository.subjectAll();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  void setName(String tagName) {
    _name = tagName;
  }

  void setRemarks(String remarks) {
    _remarks = remarks;
  }

  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  void deleteSubject(Subject subject, context) {
    repository
        .deleteSubject(id: subject.id, token: globalUser.token.accessToken)
        .then((value) {
      _subjects.remove(subject);
      notifyListeners();
      showToast('删除成功', context: context);
    });
  }

  Future createSubject(context) async {
    if (_name == null || _name.length == 0) {
      showToast('请填写 Subject 名称', context: context);
      return;
    }
    bool has = subjects.map((e) => e.name).contains(_name);
    if (has) {
      showToast('已存在 Subject', context: context);
      return;
    }
    try {
      Subject subject = await repository.createSubject(
        name: _name,
        remarks: _remarks,
        token: globalUser.token.accessToken,
      );
      addSubject(subject);
      return subject;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }
}
