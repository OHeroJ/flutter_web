import 'package:flutter/material.dart';
import 'package:flutter_web/widgets/widgets.dart';

class HomeContentMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ArticleDetails(),
        SizedBox(
          height: 50,
        ),
        CallToAction(
          title: '进入阅读',
        )
      ],
    );
  }
}
