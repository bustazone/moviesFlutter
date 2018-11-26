import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filter/components/LanguagesMultiselectionList.dart';
import 'package:pelis_busta/models/LanguageList.dart';

class LanguagesMultiselection extends StatefulWidget {
  final double gearBasedProportion;
  final LanguageList languages;
  final Function(LanguageList) setLanguages;
  final LanguageList allLangs;
  final String icon;

  LanguagesMultiselection(
      this.languages, this.setLanguages, this.allLangs, this.icon,
      {Key key, this.gearBasedProportion = 1})
      : super(key: key);

  @override
  State createState() => new LanguagesMultiselectionState();
}

class LanguagesMultiselectionState extends State<LanguagesMultiselection>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.only(top: 2.0 * widget.gearBasedProportion),
        width: 72.0 * widget.gearBasedProportion,
        height: 207.0 * widget.gearBasedProportion,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Image.asset(
              widget.icon,
              width: 20.0 * widget.gearBasedProportion,
              height: 20.0 * widget.gearBasedProportion,
            ),
            new Expanded(
                child: new Container(
              child: LanguagesMultiselectionList(
                  widget.languages, widget.setLanguages, widget.allLangs),
            )),
          ],
        ),
        decoration: new BoxDecoration(
          color: new Color(0xFFEAEAEA),
          border: new Border.all(color: new Color(0xFF564C19), width: 2.0),
        ));
  }
}
