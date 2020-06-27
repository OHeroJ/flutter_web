import 'package:flutter/material.dart';
import 'package:flutter_web/states/states.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web/model/model.dart';

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
        ))),
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
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 15),
                                      child: Text(
                                        state.currentTopic.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    Text(state.currentTopic.content)
                                  ],
                                ),
                              )
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

  Widget _buildCatalogMenu(BuildContext context, StateAdminCatalog state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: state.catalogs.map((Catalog e) {
          return _buildCatalogSubMenu(e, state);
        }).toList(),
      ),
    );
  }

  Widget _buildCatalogSubMenu(Catalog catalog, StateAdminCatalog state) {
    var titleWidget = GestureDetector(
      child: Container(
        width: 150,
        padding: EdgeInsets.only(
          left: catalog.level.toDouble() * 5 + 5,
          top: 5,
          bottom: 5,
        ),
        color: state.currentOptCatalog.id == catalog.id ? Colors.white : null,
        child: Text(
          catalog.title,
          style: TextStyle(color: Color(0xff333333)),
        ),
      ),
      onTap: () {
        state.selectCurrentCatalog(catalog);
      },
    );

    return Container(
      child: catalog.child == null || catalog.child.length == 0
          ? titleWidget
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleWidget,
                ...catalog.child.map((e) => _buildCatalogSubMenu(e, state))
              ],
            ),
    );
  }
}
