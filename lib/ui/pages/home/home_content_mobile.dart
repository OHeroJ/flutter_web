import 'package:flutter/material.dart';
import 'package:flutter_web/locator.dart';

import '../../../routing/routing.dart';
import '../../../services/services.dart';
import '../../widgets/widgets.dart';

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
          onPressed: () =>
              locator<ServiceNavigation>().navigateTo(RouteArticles),
        )
      ],
    );
  }
}
