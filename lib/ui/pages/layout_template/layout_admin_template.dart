import 'package:flutter/material.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/routing/route_names.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/states/global_user_state.dart';
import 'package:provider/provider.dart';

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
            _navBar(context),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navBar(context) {
    return Container(
      color: Colors.white,
      height: 64,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navLogo(),
          RaisedButton(
            child: Text('退出'),
            onPressed: () {
              Provider.of<GlobalUserState>(context, listen: false).logout();
              locator<ServiceNavigation>().navigateTo(RouteHome);
            },
          ),
        ],
      ),
    );
  }

  Widget _navLogo() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            locator<ServiceNavigation>().navigateTo(RouteHome);
          },
          child: Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset('assets/images/logo.jpg'),
                  ),
                ),
                Padding(
                  child: Text('OldBirds'),
                  padding: EdgeInsets.only(left: 8),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
