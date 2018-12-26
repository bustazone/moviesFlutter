import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final Function(BuildContext) body;
  final Function(BuildContext) buttons;

  const DialogWidget({this.title, this.body, this.buttons, Key key})
      : super(key: key);

  _getTitle(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          24.0, 24.0, 24.0, 0.0),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.title,
        child: Semantics(child: new Text(title), namesRoute: true),
      ),
    );
  }

  _getChildren(context) {
    List<Widget> widgets = <Widget>[];
    if (title != null && title.isNotEmpty) widgets.add(_getTitle(context));
    if (body != null) widgets.add(body(context));
    if (buttons != null) widgets.add(buttons(context));
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return new Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(new Radius.circular(8.0))),
      child: new Container(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _getChildren(context))),
    );
  }
}
