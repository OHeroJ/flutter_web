import 'package:flutter/material.dart';

class NavigationDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '专业技能',
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            '点击这里',
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }
}
