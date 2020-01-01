import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'call_to_action_mobile.dart';
import 'call_to_action_table_desktop.dart';

class CallToAction extends StatelessWidget {
  final String title;
  const CallToAction({this.title});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CallToActionMobile(
        title: title,
      ),
      tablet: CallToActionTabletDesktop(
        title: title,
      ),
    );
  }
}
