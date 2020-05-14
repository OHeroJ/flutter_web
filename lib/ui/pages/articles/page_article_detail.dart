import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:flutter_web/states/states.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PageArticleDetail extends StatelessWidget {
  final int id;
  PageArticleDetail({@required this.id});
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<StateArticleDetail>(
      model: StateArticleDetail(),
      onModelReady: (model) => model.getTopic(id),
      builder: (context, model, child) {
        if (model.viewState == ViewState.busy) {
          return ViewStateBusyWidget();
        }

        String content = '# ${model.topic.title}\n' + model.topic.content;
        return Container(
          padding: EdgeInsets.all(20),
          child: MarkdownWidget(
            data: content,
            childMargin: EdgeInsets.only(top: 16),
            styleConfig: StyleConfig(
                ulConfig: UlConfig(
                    textStyle: TextStyle(fontSize: 16, height: 1.5),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    dotSize: 8,
                    dotMargin: EdgeInsets.only(top: 9, right: 8)),
                pConfig: PConfig(
                    linkStyle: TextStyle(
                        fontSize: 16, height: 1.5, color: Color(0xffEF543C)),
                    textStyle: TextStyle(fontSize: 16, height: 1.5),
                    onLinkTap: (url) {
                      launch(url);
                    })),
          ),
        );
      },
    );
  }
}
