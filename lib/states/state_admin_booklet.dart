import 'package:flutter/cupertino.dart';
import 'package:flutter_web/states/global_user_state.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/model/model.dart';
import 'package:flutter_web/locator.dart';
import 'package:oktoast/oktoast.dart';

class StateAdminBooklet extends ViewStateModel {
  String _editName;
  String _editRemarks;
  String _editCover;

  String get editName => _editName;
  String get editRemarks => _editRemarks;
  String get editCover => _editCover;

  final GlobalUserState globalUser;
  StateAdminBooklet({@required this.globalUser});

  List<Booklet> _booklets = [];
  List<Booklet> get booklets => _booklets;

  final repository = locator<WebRepository>();

  bool _hasNext;
  bool get hasNext => _hasNext;

  bool _hasPreview;
  bool get hasPreview => _hasPreview;
  Booklet _editBooklet;

  loadBooklets({
    int page = 1,
    int per = 10,
  }) async {
    setBusy();
    try {
      var response = await repository.getBookletList(page: page, per: per);
      _hasPreview = response.metadata.page > 1;
      _hasNext = response.metadata.total >
          response.metadata.page * response.metadata.per;
      _booklets = response.items;
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  setEditState(Booklet booklet) {
    _editBooklet = booklet;
    _editName = booklet.name;
    _editRemarks = booklet.remarks;
    _editCover = booklet.cover;
  }

  setNormalState() {
    _editBooklet = null;
    _editName = null;
    _editRemarks = null;
    _editCover = null;
  }

  void setName(String name) {
    _editName = name;
  }

  void setCover(String cover) {
    _editCover = cover;
  }

  void setRemarks(String remarks) {
    _editRemarks = remarks;
  }

  void addBooklet(Booklet booklet) {
    _booklets.insert(0, booklet);
    notifyListeners();
  }

  void deleteBooklet(Booklet booklet, context) {
    // todo:
  }

  updateBooklet(context) async {
    if (_editBooklet == null) {
      showToast('小册不存在', context: context);
      return;
    }

    if (_editName == null || _editName.length == 0) {
      showToast('请填写小册名称', context: context);
      return;
    }
    try {
      Booklet booklet = await repository.updateBooklet(
        id: _editBooklet.id,
        name: _editName,
        remarks: _editRemarks,
        token: globalUser.token.accessToken,
        cover: _editCover,
      );
      setNormalState();
      loadBooklets();
      return booklet;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }

  createBooklet(context) async {
    if (_editName == null || _editName.length == 0) {
      showToast('请填写小册名称', context: context);
      return;
    }

    try {
      Booklet booklet = await repository.createBooklet(
        name: _editName,
        remarks: _editRemarks,
        token: globalUser.token.accessToken,
        cover: _editCover,
      );
      addBooklet(booklet);
      return booklet;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }
}
