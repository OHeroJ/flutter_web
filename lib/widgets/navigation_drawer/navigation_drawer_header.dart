import 'package:flutter/material.dart';
import 'package:flutter_web/consts/consts.dart';

class NavigationDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: primaryColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '专业技能',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          Text(
            '点击这里',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
