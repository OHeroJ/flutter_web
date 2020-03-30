import 'package:flutter/material.dart';

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
