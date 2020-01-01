import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_web/widgets/widgets.dart';
import 'home_content_desktop.dart';
import 'home_content_mobile.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return Scaffold(
            drawer: sizingInfo.deviceScreenType == DeviceScreenType.Mobile
                ? NavigationDrawer()
                : null,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: CenteredView(
                child: Column(
                  children: <Widget>[
                    NavigationBar(),
                    Container(
                      child: ScreenTypeLayout(
                        mobile: HomeContentMobile(),
                        desktop: HomeContentDesktop(),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
