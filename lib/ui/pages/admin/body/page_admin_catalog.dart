import 'package:flutter/material.dart';
import 'package:flutter_web/states/states.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web/model/model.dart';
import 'package:markdown_widget/markdown_widget.dart';

class PageAdminCatalog extends StatelessWidget {
  final String id;
  final String title;
  final GestureTapCallback closeTap;
  PageAdminCatalog({
    @required this.id,
    @required this.title,
    @required this.closeTap,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderWidget(
      model: StateAdminCatalog(globalUser: Provider.of(context), catalogId: id),
      onModelReady: (StateAdminCatalog state) => state.loadCatalogs(),
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[100],
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
            Container(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: closeTap,
                child: Icon(Icons.close),
              ),
            )
          ],
        ),
      ),
      builder: (context, StateAdminCatalog state, child) {
        if (state.viewState == ViewState.busy) {
          return ViewStateBusyWidget();
        }
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              child,
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: _buildCatalogMenu(context, state),
                      width: 150,
                      color: Colors.grey[100],
                      padding: EdgeInsets.only(
                        left: 1,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 15,
                        ),
                        child: state.currentTopic != null
                            ? state.currentCatalogIsEdit
                                ? _buildCatalogEditShow(state, context)
                                : _buildCatalogNormalShow(state, context)
                            : Center(
                                child: Text('暂无信息'),
                              ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildCatalogEditShow(
    StateAdminCatalog state,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: TextEditingController(text: state.currentTopic.title),
            decoration: InputDecoration(
              labelText: '标题',
            ),
            onChanged: (text) => state.setEditName(text),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: TextEditingController(
                text: state.currentOptCatalog.order.toString()),
            decoration: InputDecoration(
              labelText: '序号',
            ),
            onChanged: (text) => state.setEditOrder(text),
          ),
          TextField(
            controller: TextEditingController(text: state.currentTopic.content),
            decoration: InputDecoration(
              labelText: '内容',
            ),
            maxLines: 15,
            onChanged: (text) => state.setEditContent(text),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: OutlineButton(
              child: Text('提交'),
              onPressed: () async {
                state.updateSelectCatalog(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCatalogNormalShow(
    StateAdminCatalog state,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 15),
            child: Text(
              state.currentTopic.title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ...MarkdownGenerator(data: state.currentTopic.content).widgets
        ],
      ),
    );
  }

  Widget _buildCatalogMenu(BuildContext context, StateAdminCatalog state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ...state.catalogs.map((Catalog e) {
            return _buildCatalogSubMenu(e, state, context);
          }),
          GestureDetector(
            onTap: () => _addRootCatalog(),
            child: Container(
              color: Colors.green,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              child: Text(
                '添加文章',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _addRootCatalog() {}

  Widget _buildCatalogSubMenu(
    Catalog catalog,
    StateAdminCatalog state,
    BuildContext context,
  ) {
    bool isSelect = state.currentOptCatalog.id == catalog.id;
    bool noChild = catalog.child == null || catalog.child.length == 0;
    var titleContent = Text(
      catalog.title,
      style: TextStyle(color: Color(0xff333333)),
    );

    var titleWidget = GestureDetector(
      child: Container(
        width: 160,
        padding: EdgeInsets.only(
          left: catalog.level.toDouble() * 5 + 5,
          top: 5,
          bottom: 5,
        ),
        color: isSelect ? Colors.white : null,
        child: isSelect
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [titleContent, _createCatalogMenu(state, noChild)],
              )
            : titleContent,
      ),
      onTap: () {
        state.selectCurrentCatalog(catalog);
      },
    );

    return Container(
      child: noChild
          ? titleWidget
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleWidget,
                ...catalog.child
                    .map((e) => _buildCatalogSubMenu(e, state, context))
              ],
            ),
    );
  }

  PopupMenuButton<String> _createCatalogMenu(
    StateAdminCatalog state,
    bool noChild,
  ) {
    return PopupMenuButton<String>(
      tooltip: '编辑',
      onSelected: (String value) {
        if (value == '编辑') {
          state.editSelectCatalog();
        } else if (value == '删除') {
          state.removeSelectCatalog();
        } else if (value == '添加') {
          /// 添加
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon(
          Icons.edit,
          size: 14,
          color: Color(0xff333333),
        ),
      ),
      itemBuilder: (context) {
        List<PopupMenuEntry<String>> actions = <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: '编辑',
            child: Text('编辑'),
          ),
          PopupMenuItem<String>(
            value: '添加',
            child: Text('添加'),
          ),
        ];
        if (noChild) {
          actions.add(PopupMenuItem<String>(
            value: '删除',
            child: Text('删除'),
          ));
        }
        return actions;
      },
    );
  }
}
