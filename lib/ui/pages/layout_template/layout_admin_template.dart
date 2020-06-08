import 'package:flutter/material.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/routing/route_names.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/ui/widgets/navigation_bar/navbar_logo.dart';

class LayoutAdminTemplate extends StatelessWidget {
  final Widget child;

  LayoutAdminTemplate({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FE),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 64,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      locator<ServiceNavigation>().navigateTo(RouteHome);
                    },
                    child: Row(
                      children: [
                        NavBarLogo(
                          navigationPath: RouteHome,
                        ),
                        Padding(
                          child: Text('OldBirds'),
                          padding: EdgeInsets.only(left: 16),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
