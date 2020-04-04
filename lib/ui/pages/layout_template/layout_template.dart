import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../widgets/widgets.dart';

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
