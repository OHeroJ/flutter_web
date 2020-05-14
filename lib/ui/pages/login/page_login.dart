import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web/states/state_login.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:loveli_core/loveli_core.dart';

class PageLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ProviderWidget<StateLogin>(
      model: StateLogin(),
      builder: (context, state, _) {
        return Scaffold(
          body: ScreenTypeLayout(
            mobile: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.brown[100],
                  margin: EdgeInsets.only(top: 80),
                  width: width * 0.8,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (text) {
                          state.setEmail(text);
                        },
                        decoration: InputDecoration(
                          labelText: '输入邮箱',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: '输入密码',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        onChanged: (text) {
                          state.setPassword(text);
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        onPressed: () {
                          state.login();
                        },
                        child: Text('登录'),
                      )
                    ],
                  ),
                )
              ],
            ),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 80),
                  color: Colors.brown[100],
                  width: width * 0.5,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (text) {
                          state.setEmail(text);
                        },
                        decoration: InputDecoration(
                          labelText: '输入邮箱',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        onChanged: (text) {
                          state.setPassword(text);
                        },
                        decoration: InputDecoration(
                          labelText: '输入密码',
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        onPressed: () {
                          state.login();
                        },
                        child: Text('登录'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
