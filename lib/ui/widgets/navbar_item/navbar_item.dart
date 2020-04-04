import 'package:flutter/material.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/services/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../items/items.dart';
import 'navbar_item_desktop.dart';
import 'navbar_item_mobile.dart';

class NavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  final IconData icon;

  NavBarItem({this.title, this.navigationPath, this.icon});
  @override
  Widget build(BuildContext context) {
    var model = ModelNavBarItem(
        title: title, navigationPath: navigationPath, iconData: icon);

    return GestureDetector(
      onTap: () {
        locator<ServiceNavigation>().navigateTo(navigationPath);
      },
      child: Provider.value(
        value: model,
        child: ScreenTypeLayout(
          tablet: NavBarItemTabletDesktop(),
          mobile: NavBarItemMobile(),
        ),
      ),
    );
  }
}
