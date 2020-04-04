import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'call_to_action_mobile.dart';
import 'call_to_action_table_desktop.dart';

class CallToAction extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const CallToAction({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CallToActionMobile(
        onPressed: onPressed,
        title: title,
      ),
      tablet: CallToActionTabletDesktop(
        onPressed: onPressed,
        title: title,
      ),
    );
  }
}
