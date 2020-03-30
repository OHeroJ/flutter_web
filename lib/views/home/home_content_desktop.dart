import 'package:flutter/material.dart';
import 'package:flutter_web/widgets/widgets.dart';

class HomeContentDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ArticleDetails(),
        ),
        Container(
          margin: EdgeInsets.only(left: 100, right: 100),
          child: Center(
            child: CallToAction(
              title: '进入阅读',
            ),
          ),
        )
      ],
    );
  }
}
