import 'package:flutter/material.dart';
import 'package:flutter_web/routing/route_names.dart';
import '../navbar_item/navbar_item.dart';
import 'navigation_drawer_header.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)]),
      child: Column(
        children: <Widget>[
          NavigationDrawerHeader(),
          NavBarItem(
            title: '文章',
            icon: Icons.book,
            navigationPath: ArticlesRoute,
          ),
          NavBarItem(
            title: '关于',
            icon: Icons.help,
            navigationPath: AboutRoute,
          )
        ],
      ),
    );
  }
}
