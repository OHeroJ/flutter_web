import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '../../items/items.dart';

class NavBarItemMobile extends ProviderWidget<ModelNavBarItem> {
  @override
  Widget build(BuildContext context, ModelNavBarItem model) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: Row(
        children: <Widget>[
          Icon(model.iconData),
          SizedBox(
            width: 30,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
