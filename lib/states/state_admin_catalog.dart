import 'package:flutter/cupertino.dart';
import 'package:flutter_web/states/global_user_state.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/model/model.dart';
import 'package:flutter_web/locator.dart';
import 'package:oktoast/oktoast.dart';

class StateAdminCatalog extends ViewStateModel {
  final String catalogId;
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

  final repository = locator<WebRepository>();

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
      notifyListeners();
    }
  }

  void addBooklet(Booklet booklet) {}

  void deleteBooklet(Booklet booklet, context) {}

  createBooklet(context) async {}
}
