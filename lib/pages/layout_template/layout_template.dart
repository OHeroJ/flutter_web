import 'package:flutter/material.dart';
import 'package:flutter_web/services/services.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_web/widgets/widgets.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/routing/routing.dart';

class LayoutTemplate extends StatelessWidget {
  final Widget child;

  LayoutTemplate({Key key, this.child}) : super(key: key);

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
                    child: child,
                  )
                ],
              ),
            ));
      },
    );
  }
}
