import 'package:flutter/material.dart';
import 'package:flutter_web/routing/routing.dart';
import 'package:flutter_web/services/navigation_service.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'states/theme_state.dart';
import 'views/layout_template/layout_template.dart';

void main() {
  setupLocator();
  runApp(Wrapper(
    child: MyApp(),
  ));
}

class Wrapper extends StatelessWidget {
  final Widget child;

  Wrapper({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeState(),
      )
    ], child: child);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder: (ctx, themeState, child) {
        return MaterialApp(
          title: 'OldBird',
          debugShowCheckedModeBanner: false,
          theme: themeState.theme,
          home: LayoutTemplate(),
          builder: (context, child) => LayoutTemplate(
            child: child,
          ),
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: generateRoute,
          initialRoute: HomeRoute,
        );
      },
    );
  }
}
