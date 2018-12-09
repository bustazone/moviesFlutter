import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filter/components/YearSelectorField.dart';
import 'package:pelis_busta/support/constants/DesignConstants.dart';
import 'package:pelis_busta/support/custom_widgets/IconGestureDetector.dart';

enum YearFilterMode { year, range }

class YearFilter extends StatefulWidget {
  final double gearWidth;
  final year;
  final minYear;
  final maxYear;
  final setYear;
  final setMinYear;
  final setMaxYear;
  final resetYear;

  YearFilter(this.gearWidth, this.year, this.minYear, this.maxYear,
      this.setYear, this.setMinYear, this.setMaxYear, this.resetYear,
      {Key key})
      : super(key: key);

  @override
  State createState() => new YearFilterState();
}

class YearFilterState extends State<YearFilter> with TickerProviderStateMixin {
  YearFilterMode mode = YearFilterMode.year;

  void _initFilter() {
    if (widget.year != null) {
      mode = YearFilterMode.year;
      return;
    } else if (widget.minYear != null && widget.maxYear != null) {
      mode = YearFilterMode.range;
      return;
    }
    mode = YearFilterMode.year;
  }

  void _resetFilter() {
    widget.resetYear();
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
        child:
            new YearSelectorField(widget.gearWidth, 80.0, widget.year, (year) {
          setState(() {
            widget.setYear(year);
          });
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
                    widget.gearWidth, 80.0, widget.minYear, (year) {
                  setState(() {
                    widget.setMinYear(year);
                  });
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
                    widget.gearWidth, 80.0, widget.maxYear, (year) {
                  setState(() {
                    widget.setMaxYear(year);
                  });
                }),
              ),
            ],
          ));
    }

    return new Positioned(
      child: new Container(
        width: widget.gearWidth,
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
                            fontSize: 12.0 *
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
                            fontSize: 12.0 *
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
              },
            ),
          ),
        ]),
      ),
      left: 0.0,
      top: (widget.gearWidth * 27.0) / DesignConstants.gearWidth,
    );
  }
}
