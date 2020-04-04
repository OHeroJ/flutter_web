import 'package:flutter/material.dart';
import 'package:flutter_web/core/provider/provider_widget.dart';
import 'package:flutter_web/core/provider/view_state.dart';
import 'package:flutter_web/core/provider/view_state_widget.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/models/model_topic.dart';
import 'package:flutter_web/routing/route_names.dart';
import 'package:flutter_web/viewmodels/articles_view_model.dart';
import 'package:flutter_web/widgets/article_details/article_item_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../services/navigation_service.dart';

class PageArticles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ArticlesViewModel>(
      model: ArticlesViewModel(),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.viewState == ViewState.busy) {
          return ViewStateBusyWidget();
        } else if (model.viewState == ViewState.error && model.list.isEmpty) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        } else if (model.viewState == ViewState.empty) {
          return ViewStateEmptyWidget(
            onPressed: model.initData,
          );
        }

        return SmartRefresher(
            controller: model.refreshController,
            header: WaterDropHeader(),
            footer: ClassicFooter(),
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            enablePullDown: true,
            child: ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (context, index) {
                  ModelTopic item = model.list[index];
                  return ArticleItemWidget(
                    item,
                    onTap: () {
                      locator<NavigationService>().navigateTo(
                          ArticleDetailRoute,
                          queryParams: {'id': item.id.toString()});
                    },
                  );
                }));
      },
    );
  }
}
