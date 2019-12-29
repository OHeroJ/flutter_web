import 'package:flutter/material.dart';
import 'package:flutter_web/widgets/call_to_action/call_to_action.dart';
import 'package:flutter_web/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CenteredView(
          child: Column(
            children: <Widget>[
              NavigationBar(),
              Expanded(
                child: Row(
                  children: <Widget>[
                    ArticleDetails(),
                    Expanded(
                      child: Center(
                        child: CallToAction(
                          title: '进入阅读',
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
