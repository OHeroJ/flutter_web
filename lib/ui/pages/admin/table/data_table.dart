import 'package:flutter/material.dart';

import 'datable_header.dart';

class ResponsiveDatable extends StatefulWidget {
  final bool showSelect;
  final List<DatableHeader> headers;
  final List<Map<String, dynamic>> source;
  final List<Map<String, dynamic>> selecteds;
  final Widget title;
  final Widget footer;
  final Function(bool value) onSelectAll;
  final Function(bool value, Map<String, dynamic> data) onSelect;
  final Function(dynamic value) onTabRow;
  final Function(dynamic value) onSort;
  final String sortColumn;
  final bool sortAscending;
  final bool isLoading;
  final bool hideUnderline;

  const ResponsiveDatable({
    Key key,
    this.showSelect: false,
    this.onSelectAll,
    this.onSelect,
    this.onTabRow,
    this.onSort,
    this.headers,
    this.source,
    this.selecteds,
    this.title,
    this.footer,
    this.sortColumn,
    this.sortAscending,
    this.isLoading: false,
    this.hideUnderline: true,
  }) : super(key: key);

  @override
  _ResponsiveDatableState createState() => _ResponsiveDatableState();
}

class _ResponsiveDatableState extends State<ResponsiveDatable> {
  Alignment headerAlignSwitch(TextAlign textAlign) {
    switch (textAlign) {
      case TextAlign.center:
        return Alignment.center;
        break;
      case TextAlign.left:
        return Alignment.centerLeft;
        break;
      case TextAlign.right:
        return Alignment.centerRight;
        break;
      default:
        return Alignment.center;
    }
  }

  Widget desktopHeader() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showSelect && widget.selecteds != null)
            Checkbox(
              value: widget.selecteds.length == widget.source.length &&
                  widget.source != null &&
                  widget.source.length > 0,
              onChanged: (value) {
                if (widget.onSelectAll != null) widget.onSelectAll(value);
              },
            ),
          ...widget.headers
              .where((header) => header.show == true)
              .map(
                (header) => Expanded(
                  flex: header.flex ?? 1,
                  child: InkWell(
                    onTap: () {
                      if (widget.onSort != null && header.sortable)
                        widget.onSort(header.value);
                    },
                    child: header.headerBuilder != null
                        ? header.headerBuilder(header.value)
                        : Container(
                            padding: EdgeInsets.all(11),
                            alignment: headerAlignSwitch(header.textAlign),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  "${header.text}",
                                  textAlign: header.textAlign,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (widget.sortColumn != null &&
                                    widget.sortColumn == header.value)
                                  widget.sortAscending
                                      ? Icon(Icons.arrow_downward, size: 15)
                                      : Icon(Icons.arrow_upward, size: 15)
                              ],
                            ),
                          ),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }

  List<Widget> desktopList() {
    List<Widget> widgets = [];
    for (var index = 0; index < widget.source.length; index++) {
      final data = widget.source[index];
      widgets.add(InkWell(
        onTap: widget.onTabRow != null
            ? () {
                widget.onTabRow(data);
              }
            : null,
        child: Container(
            padding: EdgeInsets.all(widget.showSelect ? 0 : 11),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showSelect && widget.selecteds != null)
                  Checkbox(
                      value: widget.selecteds.indexOf(data) >= 0,
                      onChanged: (value) {
                        if (widget.onSelect != null)
                          widget.onSelect(value, data);
                      }),
                ...widget.headers
                    .where((header) => header.show == true)
                    .map(
                      (header) => Expanded(
                        flex: header.flex ?? 1,
                        child: header.sourceBuilder != null
                            ? header.sourceBuilder(data[header.value], data)
                            : header.editable
                                ? editAbleWidget(
                                    data: data,
                                    header: header,
                                    textAlign: header.textAlign,
                                  )
                                : Container(
                                    child: Text(
                                      "${data[header.value]}",
                                      textAlign: header.textAlign,
                                    ),
                                  ),
                      ),
                    )
                    .toList()
              ],
            )),
      ));
    }
    return widgets;
  }

  Widget editAbleWidget({
    @required Map<String, dynamic> data,
    @required DatableHeader header,
    TextAlign textAlign: TextAlign.center,
  }) {
    return Container(
      constraints: BoxConstraints(maxWidth: 150),
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: this.widget.hideUnderline
              ? InputBorder.none
              : UnderlineInputBorder(borderSide: BorderSide(width: 1)),
          alignLabelWithHint: true,
        ),
        textAlign: textAlign,
        controller: TextEditingController.fromValue(
          TextEditingValue(text: "${data[header.value]}"),
        ),
        onChanged: (newValue) => data[header.value] = newValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) widget.title,
          Expanded(
            child: _buildTable(),
          ),
        ],
      ),
    );
  }

  Container _buildTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300],
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //desktopHeader
          if (widget.headers != null && widget.headers.isNotEmpty)
            desktopHeader(),

          if (widget.isLoading) LinearProgressIndicator(),

          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(children: desktopList()),
                ),
              ],
            ),
          ),
          //footer
          if (widget.footer != null) widget.footer
        ],
      ),
    );
  }
}
