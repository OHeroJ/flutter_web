import 'package:flutter/cupertino.dart';
import 'package:flutter_web/ui/pages/admin/body/page_admin_subject.dart';
import 'package:loveli_core/loveli_core.dart';
import '../ui/pages/admin/body/body.dart';

class MenuItem {
  String title;
  List<MenuItem> child;
  bool isSelect;
  Widget widget;

  MenuItem.fromMap(
    Map json,
  ) {
    title = json['title'];
    isSelect = false;
    List children = ValueUtil.toList(json['child']);
    child = children.map((j) => MenuItem.fromMap(j)).toList();

    if (title == '分类') {
      widget = PageAdminSubject();
    } else if (title == '标签') {
      widget = PageAdminTag();
    } else if (title == '文章') {
      widget = PageAdminArticle();
    } else if (title == '小册') {
      widget = PageAdminBooklet();
    } else if (title == '用户') {
      widget = PageAdminUser();
    } else {
      widget = Center(
        child: Text(title),
      );
    }
  }
}

class StateAdminMenu extends ChangeNotifier {
  List<MenuItem> menus;

  MenuItem _selectItem;

  MenuItem get selectItem => _selectItem;
  StateAdminMenu() {
    menus = [
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
    menus[0].child[0].isSelect = true;
    _selectItem = menus[0].child[0];
  }

  selected(MenuItem item) {
    _selectItem.isSelect = false;
    item.isSelect = true;
    _selectItem = item;
    notifyListeners();
  }
}
