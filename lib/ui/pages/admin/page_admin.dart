import 'package:flutter/material.dart';
import 'package:flutter_web/states/states.dart';
import 'package:provider/provider.dart';

class PageAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateAdminMenu(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Color(0xffF5F7FE),
          body: Container(
              padding: EdgeInsets.only(top: 16, right: 16, bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 150,
                    child: Consumer<StateAdminMenu>(
                      builder: (context, state, child) {
                        return ListView.builder(
                          itemBuilder: (context, index) => MenuItemView(
                            item: state.menus[index],
                            onTap: (item) {
                              state.selected(item);
                            },
                          ),
                          itemCount: state.menus.length,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height - 64 - 32,
                      child: Consumer<StateAdminMenu>(
                        builder: (context, state, child) {
                          return state.selectItem.widget;
                        },
                      ),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}

class MenuItemView extends StatelessWidget {
  final MenuItem item;
  final void Function(MenuItem item) onTap;
  MenuItemView({this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return _buildMenus(
      item,
    );
  }

  Widget _buildMenus(MenuItem root, {int level = 0}) {
    if (root.child == null || root.child.isEmpty) {
      return Container(
        color: root.isSelect ? Colors.white : null,
        child: ListTile(
          onTap: () {
            onTap(root);
          },
          title: Padding(
            padding: EdgeInsets.only(left: 10.0 * level),
            child: Text(
              root.title,
              style: TextStyle(
                  color: root.isSelect ? Colors.red : Color(0xff333333)),
            ),
          ),
        ),
      );
    } else {
      return ExpansionTile(
        key: PageStorageKey<MenuItem>(root),
        title: Text(root.title),
        children:
            root.child.map((e) => _buildMenus(e, level: level + 1)).toList(),
      );
    }
  }
}
