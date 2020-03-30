import 'package:flutter/material.dart';
import 'package:flutter_web/services/services.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_web/widgets/widgets.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/routing/routing.dart';

class LayoutTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return Scaffold(
            drawer: sizingInfo.deviceScreenType == DeviceScreenType.Mobile
                ? NavigationDrawer()
                : null,
            body: CenteredView(
              child: Column(
                children: <Widget>[
                  NavigationBar(),
                  Expanded(
                    child: Navigator(
                      key: locator<NavigationService>().navigatorKey,
                      onGenerateRoute: generateRoute,
                      initialRoute: HomeRoute,
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
