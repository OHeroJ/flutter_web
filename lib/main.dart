import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'locator.dart';
import 'routing/routing.dart';
import 'services/services.dart';
import 'states/states.dart';

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
    return OKToast(
      dismissOtherOnShow: true,
      textPadding: EdgeInsets.all(20),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => StateTheme(),
          ),
          ChangeNotifierProvider(create: (_) => GlobalUserState()),
        ],
        child: child,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true,
      child: Consumer<StateTheme>(
        builder: (ctx, themeState, child) {
          return MaterialApp(
            title: 'OldBird',
            debugShowCheckedModeBanner: false,
            theme: themeState.theme,
            navigatorKey: locator<ServiceNavigation>().navigatorKey,
            onGenerateRoute: generateRoute,
            initialRoute: RouteHome,
          );
        },
      ),
    );
  }
}
