import 'package:flutter/material.dart';
import 'package:flutter_web/ui/pages/layout_template/layout_admin_template.dart';
import 'package:flutter_web/ui/ui.dart';
import 'package:loveli_core/loveli_core.dart';

import 'route_names.dart';
import 'routing_data.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData;

  switch (routingData.route) {
    case RouteHome:
      return _getPageRoute(
        child: PageHome(),
        settings: settings,
      );
    case RouteAbout:
      return _getPageRoute(
        child: PageAbout(),
        settings: settings,
      );
    case RouteArticles:
      return _getPageRoute(
        child: PageArticles(),
        settings: settings,
      );
    case RouteArticleDetail:
      var id = ValueUtil.toStr(routingData['topicId']);
      return _getPageRoute(
        child: PageArticleDetail(
          topicId: id,
        ),
        settings: settings,
      );
    case RouteLogin:
      return _getPageRoute(
        child: PageLogin(),
        settings: settings,
      );
    case RouteAdmin:
      return _getAdminPageRoute(
        child: PageAdmin(),
        settings: settings,
      );
    default:
      return _getPageRoute(
        child: PageHome(),
        settings: settings,
      );
  }
}

PageRoute _getAdminPageRoute(
    {@required Widget child, @required RouteSettings settings}) {
  return _FadeRoute(
      child: LayoutAdminTemplate(
        child: child,
      ),
      routeName: settings.name);
}

PageRoute _getPageRoute(
    {@required Widget child, @required RouteSettings settings}) {
  return _FadeRoute(
      child: LayoutTemplate(
        child: child,
      ),
      routeName: settings.name);
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
