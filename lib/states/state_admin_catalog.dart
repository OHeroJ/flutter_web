import 'package:flutter/cupertino.dart';
import 'package:flutter_web/states/global_user_state.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/model/model.dart';
import 'package:flutter_web/locator.dart';
import 'package:oktoast/oktoast.dart';

class StateAdminCatalog extends ViewStateModel {
  final String catalogId; // 最上层的 catalogId
  final GlobalUserState globalUser;

  StateAdminCatalog({
    @required this.globalUser,
    @required this.catalogId,
  });

  List<Catalog> _catalogs = [];
  List<Catalog> get catalogs => _catalogs;

  Catalog _currentOptCatalog;
  Catalog get currentOptCatalog => _currentOptCatalog;

  Topic _currentTopic;
  Topic get currentTopic => _currentTopic;

  bool _currentCatalogIsEdit = false;
  bool get currentCatalogIsEdit => _currentCatalogIsEdit;

  final repository = locator<WebRepository>();

  /// 编辑属性
  String _editName;
  String _editContent;
  String _editOrder;

  loadCatalogs() async {
    setBusy();
    try {
      _catalogs = await repository.getCatalogs(catalogId: catalogId);
      if (_catalogs != null && _catalogs.length > 0) {
        _currentOptCatalog = _catalogs.first;
        _currentTopic =
            await repository.topicDetail(_currentOptCatalog.topicId);
      }
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  void selectCurrentCatalog(Catalog catalog) async {
    if (catalog.id != _currentOptCatalog.id) {
      _currentOptCatalog = catalog;
      _currentTopic = await repository.topicDetail(_currentOptCatalog.topicId);
      _resetEditData();
      notifyListeners();
    }
  }

  void _resetEditData() {
    _currentCatalogIsEdit = false;
    _editName = null;
    _editContent = null;
    _editOrder = null;
  }

  void _refreshEditData() {
    _currentCatalogIsEdit = true;
    _editName = _currentTopic.title;
    _editContent = _currentTopic.content;
    _editOrder = _currentOptCatalog.order.toString();
  }

  void editSelectCatalog() {
    _refreshEditData();
    notifyListeners();
  }

  void setEditName(String name) {
    _editName = name;
  }

  void setEditContent(String content) {
    _editContent = content;
  }

  void setEditOrder(String order) {
    _editOrder = order;
  }

  /// 当前的目录处于编辑状态
  void removeSelectCatalog() {}

  updateSelectCatalog(BuildContext context) async {
    //todo: valid
    try {
      var response = await repository.updateCatalog(
        id: _currentOptCatalog.id,
        pid: _currentOptCatalog.pid,
        title: _editName,
        content: _editContent,
        order: int.parse(_editOrder),
        level: _currentOptCatalog.level,
        path: _currentOptCatalog.path,
        remarks: _currentOptCatalog.remarks,
        topicId: _currentOptCatalog.topicId,
        token: globalUser.token.accessToken,
      );
      if (response != null) {
        showToast('完成更新', context: context);
        _resetEditData();
        loadCatalogs();
      } else {
        showToast('更新失败', context: context);
      }
      return response;
    } catch (e, s) {
      showToast('更新错误$e-$s', context: context);
    }
  }

  void addBooklet(Booklet booklet) {}

  void deleteBooklet(Booklet booklet, context) {}

  createBooklet(context) async {}
}
