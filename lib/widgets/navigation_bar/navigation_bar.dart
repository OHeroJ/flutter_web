import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 80,
            width: 80,
            child: Image.asset('assets/images/logo.jpg'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _NavigationItem(title: '文章'),
              SizedBox(width: 50),
              _NavigationItem(title: '关于')
            ],
          )
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final String title;
  _NavigationItem({this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 18),
    );
  }
}
