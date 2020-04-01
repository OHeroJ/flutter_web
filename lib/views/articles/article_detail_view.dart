import 'package:flutter/material.dart';

class ArticleDetailView extends StatelessWidget {
  final int id;
  ArticleDetailView({@required this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$id'),
    );
  }
}
