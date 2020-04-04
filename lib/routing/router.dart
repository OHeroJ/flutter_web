import 'package:flutter/material.dart';
import 'package:flutter_web/pages/view.dart';

import 'route_names.dart';
import 'routing_data.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData;

  switch (routingData.route) {
    case HomeRoute:
      return _getPageRoute(child: PageHome(), settings: settings);
    case AboutRoute:
      return _getPageRoute(child: PageAbout(), settings: settings);
    case ArticlesRoute:
      return _getPageRoute(child: PageArticles(), settings: settings);
    case ArticleDetailRoute:
      var id = int.tryParse(routingData['id']);
      return _getPageRoute(
          child: PageArticleDetail(
            id: id,
          ),
          settings: settings);
    default:
      return _getPageRoute(child: PageHome(), settings: settings);
  }
}

PageRoute _getPageRoute(
    {@required Widget child, @required RouteSettings settings}) {
//  return MaterialPageRoute(builder: (context) => child);
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;

  _FadeRoute({this.child, this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (ctx, animation, secondaryAnimation) => child,
            transitionsBuilder: (ctx, animation, secondaryAnimation, child) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}
