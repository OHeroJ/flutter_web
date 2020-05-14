import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loveli_core/loveli_core.dart';
import 'locator.dart';
import 'routing/routing.dart';
import 'services/services.dart';
import 'states/states.dart';
import 'ui/ui.dart';

void main() async {
  setupLocator();
  // 初始化
  await SpUtil.getInstance();
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
          builder: (context, child) => LayoutTemplate(
            child: child,
          ),
          navigatorKey: locator<ServiceNavigation>().navigatorKey,
          onGenerateRoute: generateRoute,
          initialRoute: RouteHome,
        );
      },
    );
  }
}
