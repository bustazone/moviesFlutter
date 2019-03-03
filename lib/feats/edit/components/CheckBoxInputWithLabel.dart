import 'package:flutter/material.dart';
import 'package:pelis_busta/support/custom_widgets/CustomCheckbox.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class CheckBoxInputWithLabel extends StatefulWidget {
  final String label;
  final bool value;
  final Function(bool) setValue;

  CheckBoxInputWithLabel(this.label, this.setValue, this.value, {Key key})
      : super(key: key);

  @override
  State createState() => new CheckBoxInputWithLabelState();
}

class CheckBoxInputWithLabelState extends State<CheckBoxInputWithLabel>
    with TickerProviderStateMixin {
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  void _handleSubmitted(bool value) {
    widget.setValue(value);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new Container(
        margin: new EdgeInsets.symmetric(vertical: 8),
        child: new Center(
            child: new Text(
          widget.label,
          style: Theme.of(context).textTheme.display1.copyWith(
              textBaseline: TextBaseline.alphabetic,
              color: new Color(0xFF564C19),
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        )),
      ),
      new Container(
          padding: new EdgeInsets.all(5.0),
          child: new CustomCheckbox(widget.value, (selected) {
            _handleSubmitted(selected);
          }))
    ]);
  }
}
