import 'package:flutter/material.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'OldBird\n共享编程知识',
            style: TextStyle(
                fontWeight: FontWeight.w500, height: 1.2, fontSize: 60),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            '以优质编程技术资源共享为核心，以交流学习为目的搭建的在线平台。我们共享一些优质的资源出来，供同行业的同胞交流与学习，让彼此之间在自身的技术上得到提升，本站主要提供程序方面的资源给大家，像 iOS，Flutter，Vapor，设计模式，算法等等方面的资源，本站计划将在后期会不断完善，建设更多类目的资源，希望能得到更多同行的支持！',
            style: TextStyle(fontSize: 20, height: 1.7),
          )
        ],
      ),
    );
  }
}
