import 'package:flutter/material.dart';
import 'locator.dart';
import 'views/layout_template/layout_template.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OldBird',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.blue,
            textTheme:
                Theme.of(context).textTheme.apply(fontFamily: 'Open Sans')),
        home: LayoutTemplate());
  }
}
