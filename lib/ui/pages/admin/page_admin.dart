import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';

class MenuItem {
  String title;
  List<MenuItem> child;

  MenuItem.fromMap(Map json) {
    title = json['title'];
    child = ValueUtil.toList(json['child'])
        .map((j) => MenuItem.fromMap(j))
        .toList();
  }
}

class PageAdmin extends StatelessWidget {
  final List menus = [
    {
      "title": "文章",
      "child": [
        {
          "title": "分类",
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
                padding: EdgeInsets.only(left: 10),
                width: 150,
                child: _buildMenu(menus),
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

  Widget _buildMenu(List<MenuItem> items, {int level = 0}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) => _buildMenuItem(item, level)).toList());
  }

  Widget _buildMenuItem(MenuItem item, int level) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(item.title),
            margin: EdgeInsets.only(left: 16 * level.toDouble(), top: 10),
          ),
          item.child.length > 0
              ? _buildMenu(item.child, level: level + 1)
              : Container()
        ],
      ),
    );
  }
}
