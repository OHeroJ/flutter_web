import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getflutter/getflutter.dart';

import '../table/table.dart';

class PageAdminTag extends StatelessWidget {
  final List<Map<String, dynamic>> _source = [
    {
      "id": '49308430808d',
      "title": 'test1',
    },
    {
      "id": '493084d3008d',
      "title": 'test2',
    },
    {
      "id": '49508430808d',
      "title": 'test3',
    },
    {
      "id": '49308430808d',
      "title": 'test4',
    },
    {
      "id": '493084d3008d',
      "title": 'test5',
    },
    {
      "id": '49508430808d',
      "title": 'test6',
    },
    {
      "id": '49308430808d',
      "title": 'test7',
    },
    {
      "id": '493084d3008d',
      "title": 'test8',
    },
    {
      "id": '49508430808d',
      "title": 'test9',
    },
    {
      "id": '49308430808d',
      "title": 'test10',
    },
    {
      "id": '493084d3008d',
      "title": 'test11',
    },
    {
      "id": '49508430808d',
      "title": 'test12',
    },
    {
      "id": '49308430808d',
      "title": 'test1',
    },
    {
      "id": '493084d3008d',
      "title": 'test2',
    },
    {
      "id": '49508430808d',
      "title": 'test3',
    },
    {
      "id": '49308430808d',
      "title": 'test4',
    },
    {
      "id": '493084d3008d',
      "title": 'test5',
    },
    {
      "id": '49508430808d',
      "title": 'test6',
    },
    {
      "id": '49308430808d',
      "title": 'test7',
    },
    {
      "id": '493084d3008d',
      "title": 'test8',
    },
    {
      "id": '49508430808d',
      "title": 'test9',
    },
    {
      "id": '49308430808d',
      "title": 'test10',
    },
    {
      "id": '493084d3008d',
      "title": 'test11',
    },
    {
      "id": '49508430808d',
      "title": 'test12',
    }
  ];
  final List<DatableHeader> _headers = [
    DatableHeader(
      text: 'ID',
      value: 'id',
      show: true,
      textAlign: TextAlign.center,
    ),
    DatableHeader(
      text: '标题',
      value: 'title',
      show: true,
      textAlign: TextAlign.center,
    ),
    DatableHeader(
        text: '操作',
        textAlign: TextAlign.center,
        sourceBuilder: (value, raw) {
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: [
              GFButton(
                text: '删除',
                onPressed: () {},
                shape: GFButtonShape.pills,
                size: GFSize.SMALL,
              ),
              GFButton(
                text: '编辑',
                onPressed: () {},
                shape: GFButtonShape.pills,
                size: GFSize.SMALL,
              )
            ],
          );
        })
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ResponsiveDatable(
        headers: _headers,
        source: _source,
        showSelect: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  OutlineButton(
                    child: Text('+ 添加分类'),
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: Text(
                '标签列表',
                style: Theme.of(context).textTheme.headline6,
              ),
            )
          ],
        ),
        footer: Container(
          padding: EdgeInsets.only(right: 20, top: 5, bottom: 15),
          alignment: Alignment.centerRight,
          child: Wrap(
            spacing: 10,
            children: [
              OutlineButton(
                child: Text('上一页'),
                onPressed: () {},
              ),
              OutlineButton(
                child: Text('下一页'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
