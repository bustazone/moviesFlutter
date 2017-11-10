import 'package:flutter/material.dart';
import 'package:pelis_busta/DesignConstants.dart';
import 'package:pelis_busta/FilterScreen.dart';
import 'package:pelis_busta/GearInnerIcon.dart';
import 'package:pelis_busta/MainFilter.dart';
import 'package:pelis_busta/Utils.dart';

class TextFilter extends StatefulWidget {
  final String title;
  final FilterStates currentState;
  final double gearWidth;

  TextFilter(this.gearWidth, {Key key, this.title, this.currentState})
      : super(key: key);

  @override
  State createState() => new TextFilterState();
}

class TextFilterState extends State<TextFilter> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();

  void _handleSubmitted(String text) {
    switch (widget.currentState) {
      case FilterStates.TitleFilter:
        new MainFilter().filter.tituloFilter = text;
        break;
      case FilterStates.CastFilter:
        new MainFilter().filter.casts = text;
        break;
      case FilterStates.DirectorFilter:
        new MainFilter().filter.director = text;
        break;
      case FilterStates.LocationFilter:
        new MainFilter().filter.location = text;
        break;
      default:
      //do Nothing
    }
  }

  void _initTextController() {
    switch (widget.currentState) {
      case FilterStates.TitleFilter:
        if (!isNullOrEmpty(new MainFilter().filter.tituloFilter)) {
          _textController.value =
              new TextEditingValue(text: new MainFilter().filter.tituloFilter);
          return;
        }
        break;
      case FilterStates.CastFilter:
        if (!isNullOrEmpty(new MainFilter().filter.casts)) {
          _textController.value =
              new TextEditingValue(text: new MainFilter().filter.casts);
          return;
        }
        break;
      case FilterStates.DirectorFilter:
        if (!isNullOrEmpty(new MainFilter().filter.director)) {
          _textController.value =
              new TextEditingValue(text: new MainFilter().filter.director);
          return;
        }
        break;
      case FilterStates.LocationFilter:
        if (!isNullOrEmpty(new MainFilter().filter.location)) {
          _textController.value =
              new TextEditingValue(text: new MainFilter().filter.location);
          return;
        }
        break;
      default:
        //do Nothing
        return;
    }
    _textController.value = new TextEditingValue(text: "");
  }

  void _resetFilter() {
    switch (widget.currentState) {
      case FilterStates.TitleFilter:
        new MainFilter().filter.tituloFilter = null;
        break;
      case FilterStates.CastFilter:
        new MainFilter().filter.casts = null;
        break;
      case FilterStates.DirectorFilter:
        new MainFilter().filter.director = null;
        break;
      case FilterStates.LocationFilter:
        new MainFilter().filter.location = null;
        break;
      default:
      //do Nothing
    }
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
              widget.gearWidth,
              (selected) {
                _resetFilter();
                _initTextController();
                setState(() {});
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
