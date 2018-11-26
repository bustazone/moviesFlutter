import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class TextInputWithLabel extends StatefulWidget {
  final String label;
  final String value;
  final Function(String) setValue;

  TextInputWithLabel(this.label, this.setValue, {Key key, this.value})
      : super(key: key);

  @override
  State createState() => new TextInputWithLabelState();
}

class TextInputWithLabelState extends State<TextInputWithLabel>
    with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();

  initState() {
    super.initState();
    _textController.value =
        new TextEditingValue(text: widget.value == null ? "" : widget.value);
  }

  @override
  dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    widget.setValue(text);
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
          child: new TextField(
            controller: _textController,
            //onSubmitted: _handleSubmitted,
            onChanged: _handleSubmitted,
            decoration: new InputDecoration.collapsed(
              hintText: '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _',
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.display1.copyWith(
                textBaseline: TextBaseline.alphabetic,
                color: new Color(0xFF564C19),
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          decoration: new BoxDecoration(
            color: new Color(0xFFCC9900),
            border: new Border.all(color: new Color(0xFF564C19), width: 2.0),
          ))
    ]);
  }
}
