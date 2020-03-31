import 'package:flutter_web/core/provider/view_state_refresh_list_model.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/services/web_repository.dart';

class ArticlesViewModel extends ViewStateRefreshListModel {
  WebRepository repository = locator<WebRepository>();

  @override
  Future<List> loadData({int pageNum}) async {
    return await repository.getTopics(page: pageNum);
  }
}
