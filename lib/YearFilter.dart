import 'package:flutter/material.dart';
import 'package:pelis_busta/DesignConstants.dart';
import 'package:pelis_busta/FilterScreen.dart';
import 'package:pelis_busta/GearInnerIcon.dart';
import 'package:pelis_busta/MainFilter.dart';
import 'package:pelis_busta/YearPickerCustom.dart';

enum YearFilterMode { year, range }

class YearFilter extends StatefulWidget {
  final FilterStates currentState;
  final double gearWidth;

  YearFilter(this.gearWidth, {Key key, this.currentState}) : super(key: key);

  @override
  State createState() => new YearFilterState();
}

class YearFilterState extends State<YearFilter> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();

  YearFilterMode mode = YearFilterMode.year;

  void _initFilter() {
    if (new MainFilter().filter.year != null) {
      mode = YearFilterMode.year;
      return;
    } else if (new MainFilter().filter.minYear != null &&
        new MainFilter().filter.maxYear != null) {
      mode = YearFilterMode.range;
      return;
    }
    mode = YearFilterMode.year;
  }

  void _resetFilter() {
    new MainFilter().filter.year = null;
    new MainFilter().filter.minYear = null;
    new MainFilter().filter.maxYear = null;
  }

  initState() {
    super.initState();
    _initFilter();
  }

  @override
  Widget build(BuildContext context) {
    var modeContainer;
    if (mode == YearFilterMode.year) {
      modeContainer = new Container(
        margin: new EdgeInsets.only(
            top: 41.0 * (widget.gearWidth / DesignConstants.gearWidth)),
        child: new YearSelectorField(
            widget.gearWidth, 80.0, new MainFilter().filter.year, (year) {
          new MainFilter().filter.year = year;
        }),
      );
    } else {
      modeContainer = new Container(
          margin: new EdgeInsets.only(
              top: 41.0 * (widget.gearWidth / DesignConstants.gearWidth),
              left: 20.0 * (widget.gearWidth / DesignConstants.gearWidth),
              right: 20.0 * (widget.gearWidth / DesignConstants.gearWidth)),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Container(
                child: new YearSelectorField(
                    widget.gearWidth, 80.0, new MainFilter().filter.minYear,
                    (year) {
                  new MainFilter().filter.minYear = year;
                }),
              ),
              new Expanded(
//            color: Colors.amber,
//            width: 80.0 * (widget.gearWidth / DesignConstants.gearWidth),
                child: new Image.asset(
                  "assets/imgs/range_arrow.png",
                  fit: BoxFit.fill,
                ),
              ),
              new Container(
                child: new YearSelectorField(
                    widget.gearWidth, 80.0, new MainFilter().filter.maxYear,
                    (year) {
                  new MainFilter().filter.maxYear = year;
                }),
              ),
            ],
          ));
    }

    return new Positioned(
      child: new Container(
        width: widget.gearWidth,
        //height: 30.0 * (gearWidth / DesignConstants.gearWidth),
        margin: null,
        child: new Column(children: <Widget>[
          new Container(
              width: 137.0 * (widget.gearWidth / DesignConstants.gearWidth),
              height: 24.0 * (widget.gearWidth / DesignConstants.gearWidth),
              child: new Center(
                  child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                      width: 50.0,
                      child: new Text(
                        "YEAR",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.display1.copyWith(
                            textBaseline: TextBaseline.alphabetic,
                            color: new Color(0xFF564C19),
                            fontSize: 13.0 *
                                (widget.gearWidth / DesignConstants.gearWidth),
                            fontWeight: FontWeight.bold),
                      )),
                  new Container(
                    width: 36.0,
                    child: new IconGestureDetector(
                      true,
                      (mode == YearFilterMode.year) ? false : true,
                      'assets/imgs/switch_left.png',
                      'assets/imgs/switch_right.png',
                      DesignConstants.gearHoleWidth,
                      widget.gearWidth,
                      (selected) {
                        setState(() {
                          _resetFilter();
                          mode = selected
                              ? YearFilterMode.range
                              : YearFilterMode.year;
                        });
                      },
                    ),
                  ),
                  new Container(
                      width: 50.0,
                      child: new Text(
                        "RANGE",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.display1.copyWith(
                            textBaseline: TextBaseline.alphabetic,
                            color: new Color(0xFF564C19),
                            fontSize: 13.0 *
                                (widget.gearWidth / DesignConstants.gearWidth),
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )),
              decoration: new BoxDecoration(
                color: new Color(0xFFCC9900),
                border:
                    new Border.all(color: new Color(0xFF564C19), width: 2.0),
              )),
          modeContainer,
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
                setState(() {});
              },
            ),
          ),
        ]),
      ),
      left: 0.0,
      top: (widget.gearWidth * 27.0) / DesignConstants.gearWidth,
    );
  }

  @override
  dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class YearSelectorField extends StatefulWidget {
  final int currentYear;
  final double width;
  final double gearWidth;
  final onChange;

  YearSelectorField(this.gearWidth, this.width, this.currentYear, this.onChange,
      {Key key})
      : super(key: key);

  @override
  State createState() => new YearSelectorFieldState();
}

class YearSelectorFieldState extends State<YearSelectorField>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return new Container(
        constraints: new BoxConstraints.tightFor(
          width: widget.width * (widget.gearWidth / DesignConstants.gearWidth),
          height: 30.0 * (widget.gearWidth / DesignConstants.gearWidth),
        ),
        padding: new EdgeInsets.only(
            top: 3.0 * (widget.gearWidth / DesignConstants.gearWidth)),
        child: new GestureDetector(
            onTap: () async {
              DateTime newYear = await showDatePickerCustom(
                  context: context,
                  initialDate: (widget.currentYear == null)
                      ? new DateTime.now()
                      : new DateTime.utc(widget.currentYear, new DateTime.now().month,
                          new DateTime.now().day),
                  firstDate: new DateTime.utc(1900, 1, 1),
                  lastDate: new DateTime.now());
              widget.onChange(newYear.year);
              setState(() {
                widget.onChange(newYear.year);
              });
            },
            child: new Center(
                child: new Text(
              (widget.currentYear == null) ? "_ _ _ _" : widget.currentYear.toString(),
              style: Theme.of(context).textTheme.display1.copyWith(
                  textBaseline: TextBaseline.alphabetic,
                  color: new Color(0xFF564C19),
                  fontSize:
                      16.0 * (widget.gearWidth / DesignConstants.gearWidth),
                  fontWeight: FontWeight.bold),
            ))),
        decoration: new BoxDecoration(
          color: new Color(0xFFCC9900),
          border: new Border.all(color: new Color(0xFF564C19), width: 2.0),
        ));
  }
}
