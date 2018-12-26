import 'dart:convert';

import 'package:pelis_busta/support/utils/Utils.dart';

class Language {
  String code;
  String name;

  Language({this.code, this.name});

  factory Language.fromString(String data) {
    Map dataConverted = json.decode(data);
    return new Language.fromMap(dataConverted);
  }

  factory Language.fromMap(Map dataConverted) {
    Language l = new Language();
    l.code = dataConverted['code'];
    l.name = dataConverted['name'];
    return l;
  }

  Map toMap() {
    Map m = new Map();
    if (!isNullOrEmpty(code)) {
      m.putIfAbsent('code', () => code);
    }
    if (!isNullOrEmpty(name)) {
      m.putIfAbsent('name', () => name);
    }
    return m;
  }

  bool equals(Language lang) {
    if (this.name != null && (lang.name == null || this.name != lang.name)) {
      return false;
    }
    if (this.code != null && (lang.code == null || this.code != lang.code)) {
      return false;
    }
    return true;
  }
}
