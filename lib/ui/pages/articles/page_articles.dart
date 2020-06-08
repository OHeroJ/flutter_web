import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/routing/route_names.dart';
import 'package:flutter_web/ui/widgets/article_details/article_item_widget.dart';
import 'package:flutter_web/states/states.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_web/model/model.dart';

class PageArticles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<StateArticles>(
      model: StateArticles('D482DDC3-D723-4F7A-8F31-6A0D399F3A27'),
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
          enablePullUp: model.list.isNotEmpty,
          enablePullDown: model.list.isNotEmpty,
          child: ListView.builder(
              itemCount: model.list.length,
              itemBuilder: (context, index) {
                Topic item = model.list[index];
                return ArticleItemWidget(
                  item,
                  onTap: () {
                    locator<ServiceNavigation>().navigateTo(RouteArticleDetail,
                        queryParams: {'topicId': item.id});
                  },
                );
              }),
        );
      },
    );
  }
}
