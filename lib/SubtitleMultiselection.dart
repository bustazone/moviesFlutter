import 'package:flutter/material.dart';
import 'package:pelis_busta/DesignConstants.dart';
import 'package:pelis_busta/FilmModel.dart';
import 'package:pelis_busta/LanguagesFilter.dart';
import 'package:pelis_busta/MainFilter.dart';
import 'package:pelis_busta/Services.dart';

class SubtitleMultiselection extends StatefulWidget {
  final double gearWidth;

  SubtitleMultiselection(this.gearWidth, {Key key}) : super(key: key);

  @override
  State createState() => new SubtitleMultiselectionState();
}

class SubtitleMultiselectionState extends State<SubtitleMultiselection>
    with TickerProviderStateMixin {

  List<LanguageListItemData> itemsLangGeneral = new List();
  List<LanguageListItemData> itemsLangSelected = new List();
  List<Language> respLang = new List();

  getItemLang(int index) {
    if (itemsLangSelected.length > 0) {
      if (index < itemsLangSelected.length) {
        return new LanguageListItem(
            itemsLangSelected[index], widget.gearWidth, (selected) {
          changeSelectedLangValue(itemsLangSelected[index].codigo, selected);
          setState(() {});
        });
      } else if (itemsLangSelected.length > 0 &&
          index == itemsLangSelected.length) {
        return new ListDivisor(widget.gearWidth);
      } else {
        return new LanguageListItem(
            itemsLangGeneral[index - itemsLangSelected.length - 1],
            widget.gearWidth, (selected) {
          changeSelectedLangValue(
              itemsLangGeneral[index - itemsLangSelected.length - 1].codigo,
              selected);
          setState(() {});
        });
      }
    } else {
      return new LanguageListItem(itemsLangGeneral[index], widget.gearWidth,
              (selected) {
            changeSelectedLangValue(itemsLangGeneral[index].codigo, selected);
            setState(() {});
          });
    }
  }

  changeSelectedLangValue(codigo, selected) {
    var langs = new MainFilter().filter.subtitulos;
    for (int i = 0; i < langs.length; i++) {
      if (langs[i].codigo == codigo) {
        if (!selected) {
          new MainFilter()
              .filter
              .subtitulos
              .removeByValues(new Language(codigo: codigo));
        } else {
          return;
        }
      }
    }
    if (selected) {
      new MainFilter().filter.subtitulos.add(new Language(codigo: codigo));
    }
  }

  transformLangItems() {
    itemsLangSelected.clear();
    itemsLangGeneral.clear();
    var languages = new MainFilter().filter.subtitulos;
    List<String> jj = new List();
    for (Language l in languages) {
      jj.add(l.codigo);
    }
    for (Language l in respLang) {
      bool selected = (jj.indexOf(l.codigo) != -1);
      if (selected) {
        itemsLangSelected.add(new LanguageListItemData(selected, l));
      }
      itemsLangGeneral.add(new LanguageListItemData(selected, l));
    }
  }

  _getLangItems() async {
    itemsLangGeneral.clear();
    itemsLangSelected.clear();
    respLang = await getSubtitlesList();
    respLang.sort((a, b) => a.codigo.compareTo(b.codigo));
    transformLangItems();
    setState(() {});
  }

  int _getLangLenght() {
    if (itemsLangSelected.length > 0) {
      return itemsLangSelected.length + 1 + itemsLangGeneral.length;
    }
    return itemsLangGeneral.length;
  }

  initState() {
    super.initState();
    _getLangItems();
  }

  @override
  Widget build(BuildContext context) {
    transformLangItems();
    return new Container(
        padding: new EdgeInsets.only(
            top: 2.0 *
                (widget.gearWidth / DesignConstants.gearWidth)),
        width:
        72.0 * (widget.gearWidth / DesignConstants.gearWidth),
        height: 207.0 *
            (widget.gearWidth / DesignConstants.gearWidth),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Image.asset(
              'assets/icons/icon_subs.png',
              width: 20.0 * (widget.gearWidth / DesignConstants.gearWidth),
              height: 20.0 * (widget.gearWidth / DesignConstants.gearWidth),
            ),
            new Expanded(
                child: new Container(
                  child: new CustomScrollView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    slivers: <Widget>[
                      new SliverList(
                        delegate: new SliverChildBuilderDelegate(
                              (context, index) => getItemLang(index),
                          childCount: _getLangLenght(),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
        decoration: new BoxDecoration(
          color: new Color(0xFFEAEAEA),
          border: new Border.all(
              color: new Color(0xFF564C19), width: 2.0),
        ));
  }
}