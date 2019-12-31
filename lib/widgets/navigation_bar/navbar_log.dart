import 'package:flutter/material.dart';

class NavBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 60,
        width: 60,
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );
  }
}
