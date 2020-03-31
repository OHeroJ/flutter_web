import 'package:flutter/material.dart';
import 'package:flutter_web/models/model_topic.dart';

class ArticleItemWidget extends StatelessWidget {
  final ModelTopic item;
  ArticleItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.title,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
