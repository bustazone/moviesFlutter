import 'package:flutter/material.dart';
import 'package:pelis_busta/CustomCheckbox.dart';
import 'package:pelis_busta/DesignConstants.dart';
import 'package:pelis_busta/FilmModel.dart';
import 'package:pelis_busta/GearInnerIcon.dart';
import 'package:pelis_busta/LanguageMultiselection.dart';
import 'package:pelis_busta/MainFilter.dart';
import 'package:pelis_busta/PressingButton.dart';
import 'package:pelis_busta/Services.dart';
import 'package:pelis_busta/SubtitleMultiselection.dart';
import 'package:pelis_busta/Utils.dart';

class LanguagesFilter extends StatefulWidget {
  final String title;
  final double gearWidth;

  LanguagesFilter(this.gearWidth, this.title, {Key key}) : super(key: key);

  @override
  State createState() => new LanguagesFilterState();
}

class LanguagesFilterState extends State<LanguagesFilter>
    with TickerProviderStateMixin {
  _reset() {
//    for (LanguageListItemData l in itemsLangSelected) {
//      new MainFilter()
//          .filter
//          .idiomas
//          .removeByValues(new Language(codigo: l.codigo));
//    }
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
                        new LanguagesMultiselection(widget.gearWidth),
                        new Expanded(child: new Container()),
                        new SubtitleMultiselection(widget.gearWidth),
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
                widget.gearWidth,
                (selected) {
//                _resetFilter();
//                _initTextController();
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListDivisor extends StatelessWidget {
  final double gearWidth;

  ListDivisor(this.gearWidth);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(2.0 * (gearWidth / DesignConstants.gearWidth)),
      height: 2.0 * (gearWidth / DesignConstants.gearWidth),
      color: new Color(0xFF564C19),
    );
  }
}

class LanguageListItem extends StatefulWidget {
  final double gearWidth;
  final LanguageListItemData item;
  final onTap;

  LanguageListItem(this.item, this.gearWidth, this.onTap, {Key key})
      : super(key: key);

  @override
  State createState() => new LanguageListItemState();
}

class LanguageListItemState extends State<LanguageListItem>
    with TickerProviderStateMixin {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget image;
    try {
      //image = new Image(image: new ImageProvider<AssetImage>())
      image = new Image.asset(
        'assets/languages/' + widget.item.codigo + '.png',
        height: 30.0,
        width: 30.0,
      );
    } catch (Exception) {
      image = new Image.asset(
        'assets/languages/fake.png',
        height: 30.0,
        width: 30.0,
      );
    }
    return new Row(
      children: <Widget>[
        new Container(
            padding: new EdgeInsets.all(5.0),
            child: new CustomCheckbox(
                widget.item.selected,
                20.0 * (widget.gearWidth / DesignConstants.gearWidth),
                20.0 * (widget.gearWidth / DesignConstants.gearWidth),
                (selected) {
              widget.onTap(selected);
            })),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: image,
            ),
      ],
    );
  }
}

class LanguageListItemData extends Language {
  bool selected = false;

  LanguageListItemData(this.selected, Language genre)
      : super(codigo: genre.codigo, nombre: genre.nombre);
}
