import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';

class MenuItem {
  String title;
  List<MenuItem> child;

  MenuItem.fromMap(
    Map json,
  ) {
    title = json['title'];
    List children = ValueUtil.toList(json['child']);
    child = children.map((j) => MenuItem.fromMap(j)).toList();
  }
}

class PageAdmin extends StatelessWidget {
  final List menus = [
    {
      "title": "文章",
      "child": [
        {
          "title": "分类",
          "child": [
            {
              "title": "测试",
            }
          ]
        },
        {
          "title": "标签",
        },
        {
          "title": "文章",
        },
      ]
    },
    {"title": "小册", "child": []},
    {"title": "用户", "child": []}
  ].map((e) => MenuItem.fromMap(e)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FE),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 150,
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      MenuItemView(item: menus[index]),
                  itemCount: menus.length,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Text('right'),
                ),
              )
            ],
          )),
    );
  }
}

class MenuItemView extends StatelessWidget {
  final MenuItem item;
  MenuItemView({this.item});

  @override
  Widget build(BuildContext context) {
    return _buildMenus(item);
  }

  Widget _buildMenus(MenuItem root) {
    if (root.child.isEmpty) {
      return ListTile(
        title: Text(root.title),
      );
    } else {
      return ExpansionTile(
        key: PageStorageKey<MenuItem>(root),
        title: Text(root.title),
        children: root.child.map(_buildMenus).toList(),
      );
    }
  }
}
