import 'package:flutter/material.dart';

class CallToActionMobile extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  CallToActionMobile({this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text(
        title,
      ),
    );
  }
}
