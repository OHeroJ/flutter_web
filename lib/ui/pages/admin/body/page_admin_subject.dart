import 'package:flutter/material.dart';

class PageAdminSubject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              child: Row(
                children: [
                  OutlineButton(
                    child: Text('+ 添加分类'),
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
