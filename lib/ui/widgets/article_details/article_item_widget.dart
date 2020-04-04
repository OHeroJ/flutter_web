import 'package:flutter/material.dart';
import 'package:flutter_web/services/services.dart';

class ArticleItemWidget extends StatelessWidget {
  final ModelTopic item;
  final GestureTapCallback onTap;

  ArticleItemWidget(this.item, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
