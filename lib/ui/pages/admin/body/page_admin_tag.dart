import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../table/table.dart';

class PageAdminTag extends StatelessWidget {
  List<DatableHeader> _headers = [
    DatableHeader(
      text: 'ID',
      value: 'id',
      show: false,
      sortable: true,
      textAlign: TextAlign.right,
    ),
    DatableHeader(
      text: 'TITLE',
      value: 'title',
      show: true,
      flex: 2,
      sortable: true,
      textAlign: TextAlign.left,
    ),
    DatableHeader(
      text: 'ACTIONS',
      textAlign: TextAlign.center,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('标签'),
    );
  }
}
