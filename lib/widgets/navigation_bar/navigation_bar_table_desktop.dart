import 'package:flutter/material.dart';
import 'package:flutter_web/routing/route_names.dart';
import 'package:provider/provider.dart';

import '../../states/theme_state.dart';
import '../navbar_item/navbar_item.dart';
import 'navbar_logo.dart';

class NavigationBarTableDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NavBarLogo(
            navigationPath: HomeRoute,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavBarItem(
                title: '文章',
                navigationPath: ArticlesRoute,
              ),
              SizedBox(width: 50),
              NavBarItem(
                title: '关于',
                navigationPath: AboutRoute,
              ),
              SizedBox(width: 50),
              Consumer<ThemeState>(
                builder: (context, state, _) {
                  return GestureDetector(
                    onTap: () => state.toggle(),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 10),
                      child: Image(
                        image: AssetImage(
                          state.isDark
                              ? 'assets/images/theme_light.png'
                              : 'assets/images/theme_dark.png',
                        ),
                        color: state.isDark ? Colors.white : Colors.black,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
