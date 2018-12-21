import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filter/components/LanguagesListItem.dart';
import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/models/LanguageList.dart';

class LanguagesMultiselectionList extends StatefulWidget {
  final LanguageList languages;
  final Function(LanguageList) setLanguages;
  final LanguageList allLangs;

  LanguagesMultiselectionList(this.languages, this.setLanguages, this.allLangs,
      {Key key})
      : super(key: key);

  @override
  State createState() => new LanguagesMultiselectionListState();
}

class LanguagesMultiselectionListState
    extends State<LanguagesMultiselectionList> with TickerProviderStateMixin {
  List<LanguageListItemData> itemsLangGeneral = new List();
  List<LanguageListItemData> itemsLangSelected = new List();
  List<Language> respLang = new List();

  getItemLang(int index) {
    if (itemsLangSelected.length > 0) {
      if (index < itemsLangSelected.length) {
        return new LanguageListItem(itemsLangSelected[index], (selected) {
          changeSelectedLangValue(itemsLangSelected[index].code, selected);
        });
      } else if (itemsLangSelected.length > 0 &&
          index == itemsLangSelected.length) {
        return new ListDivisor();
      } else {
        return new LanguageListItem(
            itemsLangGeneral[index - itemsLangSelected.length - 1], (selected) {
          changeSelectedLangValue(
              itemsLangGeneral[index - itemsLangSelected.length - 1].code,
              selected);
        });
      }
    } else {
      return new LanguageListItem(itemsLangGeneral[index], (selected) {
        changeSelectedLangValue(itemsLangGeneral[index].code, selected);
      });
    }
  }

  changeSelectedLangValue(codigo, selected) {
    var langs = widget.languages;
    for (int i = 0; i < langs.length; i++) {
      if (langs[i].code == codigo) {
        if (!selected) {
          widget.setLanguages(LanguageList(l: List.from(widget.languages))
            ..removeByValues(new Language(code: codigo)));
        } else {
          return;
        }
      }
    }
    if (selected) {
      widget.setLanguages(LanguageList(l: List.from(widget.languages))
        ..add(new Language(code: codigo)));
    }
  }

  transformLangItems() {
    itemsLangSelected.clear();
    itemsLangGeneral.clear();
    var languages = widget.languages;
    List<String> intemediateList = new List();
    for (Language l in languages) {
      intemediateList.add(l.code);
    }
    for (Language l in respLang) {
      bool selected = (intemediateList.indexOf(l.code) != -1);
      if (selected) {
        itemsLangSelected.add(new LanguageListItemData(selected, l));
      }
      itemsLangGeneral.add(new LanguageListItemData(selected, l));
    }
  }

  _getLangItems() async {
    itemsLangGeneral.clear();
    itemsLangSelected.clear();
    respLang = List.from(widget.allLangs);
    respLang.sort((a, b) => a.code.compareTo(b.code));
    transformLangItems();
  }

  int _getLangLength() {
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
    return new CustomScrollView(
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      slivers: <Widget>[
        new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (context, index) => getItemLang(index),
            childCount: _getLangLength(),
          ),
        ),
      ],
    );
  }
}
