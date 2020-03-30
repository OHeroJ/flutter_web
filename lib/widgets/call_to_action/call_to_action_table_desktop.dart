import 'package:flutter/material.dart';

class CallToActionTabletDesktop extends StatelessWidget {
  final String title;

  const CallToActionTabletDesktop({this.title});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: Text(
        title,
      ),
    );
  }
}
