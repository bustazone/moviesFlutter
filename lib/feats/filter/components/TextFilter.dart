import 'package:flutter/material.dart';
import 'package:pelis_busta/support/constants/DesignConstants.dart';
import 'package:pelis_busta/support/custom_widgets/IconGestureDetector.dart';

class TextFilter extends StatefulWidget {
  final String title;
  final double gearWidth;
  final String value;
  final setText;
  final resetText;

  TextFilter(
      this.gearWidth, this.title, this.value, this.setText, this.resetText,
      {Key key})
      : super(key: key);

  @override
  State createState() => new TextFilterState();
}

class TextFilterState extends State<TextFilter> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();

  void _handleSubmitted(String text) {
    widget.setText(text);
  }

  void _initTextController() {
    _textController.value = new TextEditingValue(text: widget.value == null ? "" : widget.value);
  }

  void _resetFilter() {
    widget.resetText();
  }

  initState() {
    super.initState();
    _initTextController();
  }

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      child: new Container(
        width: 220.0 * (widget.gearWidth / DesignConstants.gearWidth),
        //height: 30.0 * (gearWidth / DesignConstants.gearWidth),
        margin: null,
        child: new Column(children: <Widget>[
          new Container(
              width: 137.0 * (widget.gearWidth / DesignConstants.gearWidth),
              height: 24.0 * (widget.gearWidth / DesignConstants.gearWidth),
              child: new Center(
                  child: new Text(
                widget.title,
                style: Theme.of(context).textTheme.display1.copyWith(
                    textBaseline: TextBaseline.alphabetic,
                    color: new Color(0xFF564C19),
                    fontSize:
                        16.0 * (widget.gearWidth / DesignConstants.gearWidth),
                    fontWeight: FontWeight.bold),
              )),
              decoration: new BoxDecoration(
                color: new Color(0xFFCC9900),
                border:
                    new Border.all(color: new Color(0xFF564C19), width: 2.0),
              )),
          new Container(
              margin: new EdgeInsets.only(
                  top: 41.0 * (widget.gearWidth / DesignConstants.gearWidth)),
              padding: new EdgeInsets.only(
                  top: 3.0 * (widget.gearWidth / DesignConstants.gearWidth)),
              constraints: new BoxConstraints.tightFor(
                width: 220.0 * (widget.gearWidth / DesignConstants.gearWidth),
                height: 30.0 * (widget.gearWidth / DesignConstants.gearWidth),
              ),
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
                    fontSize:
                        16.0 * (widget.gearWidth / DesignConstants.gearWidth),
                    fontWeight: FontWeight.bold),
              ),
              decoration: new BoxDecoration(
                color: new Color(0xFFCC9900),
                border:
                    new Border.all(color: new Color(0xFF564C19), width: 2.0),
              )),
          new Container(
            margin: new EdgeInsets.only(
                top: 118.0 * (widget.gearWidth / DesignConstants.gearWidth)),
            child: new IconGestureDetector(
              false,
              false,
              'assets/filterIcons/reset.png',
              'assets/filterIcons/reset.png',
              DesignConstants.gearHoleWidth,
              widget.gearWidth,
              (selected) {
                _resetFilter();
                _initTextController();
              },
            ),
          ),
        ]),
      ),
      left: (widget.gearWidth -
              ((widget.gearWidth * 220.0) / DesignConstants.gearWidth)) /
          2.0,
      top: (widget.gearWidth * 27.0) / DesignConstants.gearWidth,
    );
  }

  @override
  dispose() {
    _textController.dispose();
    super.dispose();
  }
}
