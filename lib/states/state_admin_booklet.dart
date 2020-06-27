import 'package:flutter/cupertino.dart';
import 'package:flutter_web/states/global_user_state.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/model/model.dart';
import 'package:flutter_web/locator.dart';
import 'package:oktoast/oktoast.dart';

class StateAdminBooklet extends ViewStateModel {
  String _name;
  String _remarks;
  String _cover;

  final GlobalUserState globalUser;
  StateAdminBooklet({@required this.globalUser});

  List<Booklet> _booklets = [];
  List<Booklet> get booklets => _booklets;

  final repository = locator<WebRepository>();

  bool _hasNext;
  bool get hasNext => _hasNext;

  bool _hasPreview;
  bool get hasPreview => _hasPreview;

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

  void setName(String name) {
    _name = name;
  }

  void setCover(String cover) {
    _cover = cover;
  }

  void setRemarks(String remarks) {
    _remarks = remarks;
  }

  void addBooklet(Booklet booklet) {
    _booklets.insert(0, booklet);
    notifyListeners();
  }

  void deleteBooklet(Booklet booklet, context) {
    // todo:
  }

  createBooklet(context) async {
    if (_name == null || _name.length == 0) {
      showToast('请填写小册名称', context: context);
      return;
    }

    try {
      Booklet booklet = await repository.createBooklet(
        name: _name,
        remarks: _remarks,
        token: globalUser.token.accessToken,
        cover: _cover,
      );
      addBooklet(booklet);
      return booklet;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }
}
