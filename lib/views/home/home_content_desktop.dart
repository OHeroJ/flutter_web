import 'package:flutter/material.dart';
import 'package:flutter_web/widgets/widgets.dart';

class HomeContentDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ArticleDetails(),
        Expanded(
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
