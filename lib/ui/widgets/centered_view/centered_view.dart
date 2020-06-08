import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CenteredView extends StatelessWidget {
  final Widget child;
  const CenteredView({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeInfo) {
        final double horizontal = 0;
        return Container(
            padding: EdgeInsets.symmetric(horizontal: horizontal),
            alignment: Alignment.topCenter,
            child: child);
      },
    );
  }
}
