import 'package:flutter/material.dart';
import 'package:flutter_web/ui/ui.dart';

import 'route_names.dart';
import 'routing_data.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData;

  switch (routingData.route) {
    case RouteHome:
      return _getPageRoute(child: PageHome(), settings: settings);
    case RouteAbout:
      return _getPageRoute(child: PageAbout(), settings: settings);
    case RouteArticles:
      return _getPageRoute(child: PageArticles(), settings: settings);
    case RouteArticleDetail:
      var id = int.tryParse(routingData['id']);
      return _getPageRoute(
          child: PageArticleDetail(
            id: id,
          ),
          settings: settings);
    case RouteLogin:
      return _getPageRoute(child: PageLogin(), settings: settings);
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
