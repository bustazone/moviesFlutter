import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filter/components/LanguageMultiselection.dart';
import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/models/LanguageList.dart';
import 'package:pelis_busta/support/constants/DesignConstants.dart';
import 'package:pelis_busta/support/custom_widgets/IconGestureDetector.dart';

class LanguagesFilter extends StatefulWidget {
  final String title;
  final double gearWidth;
  final LanguageList languages;
  final setLanguages;
  final resetLanguages;
  final List<Language> allLangs;
  final LanguageList subtitles;
  final setSubtitles;
  final resetSubtitles;
  final List<Language> allSubs;

  LanguagesFilter(
      this.gearWidth,
      this.title,
      this.languages,
      this.setLanguages,
      this.resetLanguages,
      this.allLangs,
      this.subtitles,
      this.setSubtitles,
      this.resetSubtitles,
      this.allSubs,
      {Key key})
      : super(key: key);

  @override
  State createState() => new LanguagesFilterState();
}

class LanguagesFilterState extends State<LanguagesFilter>
    with TickerProviderStateMixin {
  _reset() {
    widget.resetLanguages();
    widget.resetSubtitles();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: widget.gearWidth,
      height: widget.gearWidth,
      child: new Stack(
        children: <Widget>[
          new Center(
            child: new Container(
              width: 207.0 * (widget.gearWidth / DesignConstants.gearWidth),
              height: 300.0 * (widget.gearWidth / DesignConstants.gearWidth),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      width: 137.0 *
                          (widget.gearWidth / DesignConstants.gearWidth),
                      height:
                          24.0 * (widget.gearWidth / DesignConstants.gearWidth),
                      child: new Center(
                          child: new Text(
                        widget.title,
                        style: Theme.of(context).textTheme.display1.copyWith(
                            textBaseline: TextBaseline.alphabetic,
                            color: new Color(0xFF564C19),
                            fontSize: 16.0 *
                                (widget.gearWidth / DesignConstants.gearWidth),
                            fontWeight: FontWeight.bold),
                      )),
                      decoration: new BoxDecoration(
                        color: new Color(0xFFCC9900),
                        border: new Border.all(
                            color: new Color(0xFF564C19), width: 2.0),
                      )),
                  new Container(
                    margin: new EdgeInsets.only(top: 5.0),
                    child: new Row(
                      children: <Widget>[
                        new LanguagesMultiselection(
                            widget.languages,
                            widget.setLanguages,
                            widget.allLangs,
                            'assets/icons/icon_audio.png',
                            gearBasedProportion:
                                widget.gearWidth / DesignConstants.gearWidth),
                        new Expanded(child: new Container()),
                        new LanguagesMultiselection(
                            widget.subtitles,
                            widget.setSubtitles,
                            widget.allSubs,
                            'assets/icons/icon_subs.png',
                            gearBasedProportion:
                                widget.gearWidth / DesignConstants.gearWidth),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Center(
            child: new Container(
              margin: new EdgeInsets.only(
                  top: 225.0 * (widget.gearWidth / DesignConstants.gearWidth)),
              child: new IconGestureDetector(
                false,
                false,
                'assets/filterIcons/reset.png',
                'assets/filterIcons/reset.png',
                DesignConstants.gearHoleWidth,
                widget.gearWidth,
                (selected) {
                  _reset();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
