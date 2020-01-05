import 'package:flutter/material.dart';
import 'package:flutter_web/routing/route_names.dart';
import 'navbar_logo.dart';
import 'navbar_item.dart';

class NavigationBarTableDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NavBarLogo(
            navigationPath: HomeRoute,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavBarItem(
                title: '文章',
                navigationPath: ArticlesRoute,
              ),
              SizedBox(width: 50),
              NavBarItem(
                title: '关于',
                navigationPath: AboutRoute,
              )
            ],
          )
        ],
      ),
    );
  }
}
