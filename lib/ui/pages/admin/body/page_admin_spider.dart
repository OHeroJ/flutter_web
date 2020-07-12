import 'package:flutter/material.dart';
import 'package:flutter_web/states/states.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:provider/provider.dart';
import '../table/table.dart';
import 'package:oktoast/oktoast.dart';

class PageAdminSpider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ProviderWidget(
        model: StateAdminSpider(globalUser: Provider.of(context)),
        onModelReady: (StateAdminSpider state) => state.loadTopics(),
        builder: (BuildContext context, StateAdminSpider state, Widget child) {
          if (state.viewState == ViewState.busy) {
            return ViewStateBusyWidget();
          }

          List topics = state.topics.map((e) => e.toMap()).toList();
          return ResponsiveDatable(
            headers: [
              DatableHeader(
                text: '标题',
                value: 'title',
                show: true,
                textAlign: TextAlign.center,
              ),
              DatableHeader(
                text: '来源',
                value: 'source',
                show: true,
                textAlign: TextAlign.center,
              ),
              DatableHeader(
                  text: '操作',
                  textAlign: TextAlign.center,
                  sourceBuilder: (value, raw) {
                    int index = topics.indexOf(raw);
                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      children: [],
                    );
                  })
            ],
            source: topics,
            showSelect: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      OutlineButton(
                        child: Text('重新抓取'),
                        onPressed: () async {
                          showToastWidget(
                            Center(
                              child: Container(
                                width: 200,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black45,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        '加载中...',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            context: context,
                            duration: Duration(seconds: 60),
                          );
                          Map result = await state.refreshSpider();
                          dismissAllToast();
                          state.loadTopics();
                        },
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
                    '更新数据',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
