import 'package:flutter/cupertino.dart';
import 'package:flutter_web/states/global_user_state.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/model/model.dart';
import 'package:flutter_web/locator.dart';
import 'package:oktoast/oktoast.dart';

enum CatalogState {
  normal,
  edit,
  add,
}

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

  CatalogState _currentCatalogState = CatalogState.normal;
  CatalogState get currentCatalogState => _currentCatalogState;

  final repository = locator<WebRepository>();

  /// 编辑属性
  String _editName;
  String _editContent;
  String _editOrder;

  String get editName => _editName;
  String get editContent => _editContent;
  String get editOrder => _editOrder;

  bool _rootChildAdd = false;

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
      _setNormalState();
      notifyListeners();
    }
  }

  void _setNormalState() {
    _currentCatalogState = CatalogState.normal;
    _rootChildAdd = false;
    _editName = null;
    _editContent = null;
    _editOrder = null;
  }

  void setEditCatalogState() {
    _currentCatalogState = CatalogState.edit;
    _rootChildAdd = false;
    _editName = _currentTopic.title;
    _editContent = _currentTopic.content;
    _editOrder = _currentOptCatalog.order.toString();
    notifyListeners();
  }

  void setAddChildCatalogState() {
    _currentCatalogState = CatalogState.add;
    _rootChildAdd = false;
    int order = currentOptCatalog.noChild
        ? currentOptCatalog.order
        : currentOptCatalog.child.last.order;
    _editOrder = (order + 1).toString();
    notifyListeners();
  }

  void setAddRootChildCatalogState() {
    _currentCatalogState = CatalogState.add;
    _rootChildAdd = true;
    int order = catalogs.last?.order ?? 0;
    _editOrder = (order + 1).toString();
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

  addCatalog(BuildContext context) async {
    try {
      String pid = _currentOptCatalog.id;
      int level = _currentOptCatalog.level + 1;
      List paths = _currentOptCatalog.path.split(",")..add(pid);

      if (_rootChildAdd) {
        pid = catalogId;
        level = 1;
        paths = [pid];
      }

      var response = await repository.createCatalog(
        pid: pid,
        title: _editName,
        content: _editContent,
        order: int.parse(_editOrder),
        path: paths.join(','),
        level: level,
        token: globalUser.token.accessToken,
      );
      if (response != null) {
        showToast('完成添加', context: context);
        _setNormalState();
        loadCatalogs();
      } else {
        showToast('添加失败', context: context);
      }
      return response;
    } catch (e, s) {
      showToast('添加错误$e-$s', context: context);
    }
  }

  /// 当前的目录处于编辑状态
  void deleteSelectCatalog(BuildContext context) async {
    try {
      var response = await repository.deleteCatalog(
        catalogId: _currentOptCatalog.id,
        token: globalUser.token.accessToken,
      );
      if (response != null) {
        showToast('删除成功', context: context);
        loadCatalogs();
      } else {
        showToast('删除失败', context: context);
      }
    } catch (e, s) {
      showToast('更新错误$e-$s', context: context);
    }
  }

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
        _setNormalState();
        loadCatalogs();
      } else {
        showToast('更新失败', context: context);
      }
      return response;
    } catch (e, s) {
      showToast('更新错误$e-$s', context: context);
    }
  }
}
