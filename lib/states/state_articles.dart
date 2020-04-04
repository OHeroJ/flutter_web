import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/services/net/web_repository.dart';

class StateArticles extends ViewStateRefreshListModel {
  WebRepository repository = locator<WebRepository>();

  @override
  Future<List> loadData({int pageNum}) async {
    return await repository.getTopics(page: pageNum);
  }
}
