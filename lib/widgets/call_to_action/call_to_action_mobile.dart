import 'package:flutter/material.dart';
import 'package:flutter_web/consts/consts.dart';

class CallToActionMobile extends StatelessWidget {
  final String title;
  CallToActionMobile({this.title});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      child: Text(
        title,
      ),
    );
  }
}
