import 'package:flutter/material.dart';
import 'package:pelis_busta/support/constants/DesignConstants.dart';
import 'package:pelis_busta/support/custom_widgets/YearPickerCustom.dart';

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
                      : new DateTime.utc(widget.currentYear,
                          new DateTime.now().month, new DateTime.now().day),
                  firstDate: new DateTime.utc(1900, 1, 1),
                  lastDate: new DateTime.now());
              widget.onChange(newYear.year);
            },
            child: new Center(
                child: new Text(
              (widget.currentYear == null)
                  ? "_ _ _ _"
                  : widget.currentYear.toString(),
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
