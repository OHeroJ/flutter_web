import 'package:flutter/material.dart';
import 'package:flutter_web/core/provider/provider_widget.dart';
import 'package:flutter_web/core/provider/view_state.dart';
import 'package:flutter_web/core/provider/view_state_widget.dart';
import 'package:flutter_web/viewmodels/article_detail_view_model.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class PageArticleDetail extends StatelessWidget {
  final int id;
  PageArticleDetail({@required this.id});
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ArticleDetailViewModel>(
      model: ArticleDetailViewModel(),
      onModelReady: (model) => model.getTopic(id),
      builder: (context, model, child) {
        if (model.viewState == ViewState.busy) {
          return ViewStateBusyWidget();
        }

        String content = '# ${model.topic.title}\n' + model.topic.content;
        return Container(
          padding: EdgeInsets.all(20),
          child: Markdown(
            data: content,
            padding: EdgeInsets.fromLTRB(0, 50, 0, 100),
            onTapLink: (url) {
              launch(url);
            },
          ),
        );
      },
    );
  }
}
