import 'package:flutter/material.dart';

class CallToActionTabletDesktop extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CallToActionTabletDesktop({this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: Text(
        title,
      ),
    );
  }
}
