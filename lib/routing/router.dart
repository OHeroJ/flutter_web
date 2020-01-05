import 'package:flutter/material.dart';
import 'route_names.dart';
import 'package:flutter_web/views/view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(child: HomeView());
    case AboutRoute:
      return _getPageRoute(child: AboutView());
    case ArticlesRoute:
      return _getPageRoute(child: ArticlesView());
    default:
      return _getPageRoute(child: HomeView());
  }
}

PageRoute _getPageRoute({Widget child}) {
//  return MaterialPageRoute(builder: (context) => child);
  return _FadeRoute(child: child);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  _FadeRoute({this.child})
      : super(
            pageBuilder: (ctx, animation, secondaryAnimation) => child,
            transitionsBuilder: (ctx, animation, secondaryAnimation, child) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}
