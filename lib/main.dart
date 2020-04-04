import 'package:flutter/material.dart';
import 'package:flutter_web/routing/routing.dart';
import 'package:flutter_web/services/services.dart';
import 'package:provider/provider.dart';
import 'locator.dart';
import 'states/states.dart';
import 'ui/ui.dart';

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
        create: (_) => StateTheme(),
      )
    ], child: child);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateTheme>(
      builder: (ctx, themeState, child) {
        return MaterialApp(
          title: 'OldBird',
          debugShowCheckedModeBanner: false,
          theme: themeState.theme,
          home: LayoutTemplate(),
          builder: (context, child) => LayoutTemplate(
            child: child,
          ),
          navigatorKey: locator<ServiceNavigation>().navigatorKey,
          onGenerateRoute: generateRoute,
          initialRoute: HomeRoute,
        );
      },
    );
  }
}
