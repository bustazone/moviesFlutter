import 'dart:collection';
import 'package:pelis_busta/models/Language.dart';

class LanguageList extends ListBase<Language> {
  final List<Language> l;

  LanguageList({this.l = const <Language>[]});

  set length(int newLength) {
    l.length = newLength;
  }

  int get length => l.length;

  Language operator [](int index) => l[index];

  void operator []=(int index, Language value) {
    l[index] = value;
  }

  void removeByValues(Language lang) {
    for (Language langList in l) {
      if (langList.equals(lang)) {
        l.remove(langList);
        return;
      }
    }
  }

  bool hasByValues(Language lang) {
    for (Language langList in l) {
      if (langList.equals(lang)) {
        return true;
      }
    }
    return false;
  }
}
