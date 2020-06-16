import 'package:flutter/cupertino.dart';
import 'package:flutter_web/states/global_user_state.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/model/model.dart';
import 'package:flutter_web/locator.dart';
import 'package:oktoast/oktoast.dart';

class StateAdminTag extends ViewStateModel {
  String _tagName;
  String _tagRemarks;

  final GlobalUserState globalUser;
  StateAdminTag({@required this.globalUser});

  List<Tag> _tags = [];
  List<Tag> get tags => _tags;
  final repository = locator<WebRepository>();
  loadTags() async {
    setBusy();
    try {
      _tags = await repository.getAllTags();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  void setTagName(String tagName) {
    _tagName = tagName;
  }

  void setTagRemarks(String remarks) {
    _tagRemarks = remarks;
  }

  void addTag(Tag tag) {
    _tags.add(tag);
    notifyListeners();
  }

  void deleteTag(Tag tag, context) {
    repository
        .deleteTag(
      id: tag.id,
      token: globalUser.token.accessToken,
    )
        .then(
      (value) {
        _tags.remove(tag);
        notifyListeners();
        showToast('删除成功', context: context);
      },
    );
  }

  Future createTag(context) async {
    if (_tagName == null || _tagName.length == 0) {
      showToast('请填写 tag 名称', context: context);
      return;
    }
    bool has = tags.map((e) => e.name).contains(_tagName);
    if (has) {
      showToast('已存在 tag', context: context);
      return;
    }
    try {
      Tag tag = await repository.createTag(
        name: _tagName,
        remarks: _tagRemarks,
        token: globalUser.token.accessToken,
      );
      addTag(tag);
      return tag;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }
}
