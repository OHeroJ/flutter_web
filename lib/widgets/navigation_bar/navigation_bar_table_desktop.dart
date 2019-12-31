import 'package:flutter/material.dart';
import 'navbar_log.dart';
import 'navbar_item.dart';

class NavigationBarTableDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavBarItem(title: '文章'),
              SizedBox(width: 50),
              NavBarItem(title: '关于')
            ],
          )
        ],
      ),
    );
  }
}
