import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        var textAlignment =
            sizingInformation.deviceScreenType == DeviceScreenType.Desktop
                ? TextAlign.left
                : TextAlign.left;

        double titleSize =
            sizingInformation.deviceScreenType == DeviceScreenType.Mobile
                ? 50
                : 80;
        double descriptionSize =
            sizingInformation.deviceScreenType == DeviceScreenType.Mobile
                ? 16
                : 21;

        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'OldBird\n共享编程知识',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: titleSize),
                textAlign: textAlignment,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                '以优质编程技术资源共享为核心，以交流学习为目的搭建的在线平台。我们共享一些优质的资源出来，供同行业的同胞交流与学习，让彼此之间在自身的技术上得到提升，本站主要提供程序方面的资源给大家，像 iOS，Flutter，Vapor，设计模式，算法等等方面的资源，本站计划将在后期会不断完善，建设更多类目的资源，希望能得到更多同行的支持！',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: descriptionSize),
                textAlign: textAlignment,
              )
            ],
          ),
        );
      },
    );
  }
}
