import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'navigation_bar_table_desktop.dart';
import 'navigation_bar_mobile.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      tablet: NavigationBarTableDesktop(),
      mobile: NavigationBarMobile(),
    );
  }
}
