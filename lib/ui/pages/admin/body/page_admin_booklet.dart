import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web/model/booklet.dart';
import 'package:flutter_web/states/states.dart';
import 'package:getflutter/getflutter.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import '../table/table.dart';
import 'page_admin_catalog.dart';

class PageAdminBooklet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ProviderWidget(
        model: StateAdminBooklet(globalUser: Provider.of(context)),
        onModelReady: (StateAdminBooklet model) => model.loadBooklets(),
        builder: (context, StateAdminBooklet state, child) {
          if (state.viewState == ViewState.busy || state.booklets.length == 0) {
            return ViewStateBusyWidget();
          }
          List booklets = state.booklets.map((e) => e.toMap()).toList();
          return ResponsiveDatable(
            headers: [
              DatableHeader(
                  text: 'ID',
                  value: 'id',
                  show: true,
                  sourceBuilder: (value, raw) {
                    return GestureDetector(
                      onTap: () {
                        int index = booklets.indexOf(raw);
                        Booklet booklet = state.booklets[index];
                        _showCatalog(context, booklet.catalogId, booklet.name);
                      },
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    );
                  }),
              DatableHeader(
                text: '标题',
                value: 'name',
                show: true,
                textAlign: TextAlign.center,
              ),
              DatableHeader(
                text: '作者',
                value: 'author',
                show: true,
                textAlign: TextAlign.center,
              ),
              DatableHeader(
                  text: '操作',
                  textAlign: TextAlign.center,
                  sourceBuilder: (value, raw) {
                    int index = booklets.indexOf(raw);
                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      children: [
                        GFButton(
                          text: '删除',
                          onPressed: () {
                            state.deleteBooklet(state.booklets[index], context);
                          },
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
            ],
            source: booklets,
            showSelect: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      OutlineButton(
                        child: Text('+ 添加小册'),
                        onPressed: () {
                          _showAddForm(context, state);
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
                    '小册列表',
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
                    onPressed: () {
                      // todo:
                    },
                  ),
                  OutlineButton(
                    child: Text('下一页'),
                    onPressed: () {
                      // todo:
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _showCatalog(BuildContext context, String catalogId, String bookletTitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child: PageAdminCatalog(
                id: catalogId,
                title: bookletTitle,
                closeTap: () => Navigator.of(context).pop(),
              )),
        );
      },
    );
  }

  _showAddForm(
    BuildContext context,
    StateAdminBooklet bookletState,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
              width: MediaQuery.of(context).size.width - 120,
              height: MediaQuery.of(context).size.height - 160,
              padding: EdgeInsets.all(20),
              child: _buildAddForm(context, bookletState)),
        );
      },
    );
  }

  Widget _buildAddForm(
    BuildContext context,
    StateAdminBooklet addState,
  ) {
    return Column(children: [
      Container(
        child: Text(
          '添加小册',
          style: TextStyle(fontSize: 20),
        ),
        margin: EdgeInsets.only(bottom: 20),
      ),
      _buildTitleRow(addState),
      _buildCoverUrlRow(addState),
      _buildRemarksRow(addState),
      _buildSubmitRow(addState, context),
    ]);
  }

  Container _buildSubmitRow(StateAdminBooklet addState, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: OutlineButton(
        child: Text('提交'),
        onPressed: () async {
          var response = await addState.createBooklet(context);
          if (response != null) {
            showToast('创建成功', context: context);
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  TextField _buildTitleRow(StateAdminBooklet addState) {
    return TextField(
      onChanged: (text) {
        addState.setName(text);
      },
      decoration: InputDecoration(
        labelText: '输入小册名称',
      ),
    );
  }

  TextField _buildRemarksRow(StateAdminBooklet addState) {
    return TextField(
      onChanged: (text) {
        addState.setRemarks(text);
      },
      decoration: InputDecoration(
        labelText: '输入小册简介',
      ),
    );
  }

  TextField _buildCoverUrlRow(StateAdminBooklet addState) {
    return TextField(
      keyboardType: TextInputType.url,
      onChanged: (text) {
        addState.setCover(text);
      },
      decoration: InputDecoration(
        labelText: '输入封面url',
      ),
    );
  }
}
