import 'dart:convert';

import 'package:pelis_busta/support/utils/Utils.dart';

class Genre {
  static const String TYPE_GENDER = "principal";
  static const String TYPE_SUBGENDER = "listas_filmaffinity";

  static const int GENDER_ACTION_CODE = 3;
  static const int GENDER_ADVENTURE_CODE = 24;
  static const int GENDER_ANIMATION_CODE = 20;
  static const int GENDER_BELIC_CODE = 45;
  static const int GENDER_COMEDY_CODE = 9;
  static const int GENDER_DOCU_CODE = 188;
  static const int GENDER_DRAMA_CODE = 8;
  static const int GENDER_FANTASTIC_CODE = 14;
  static const int GENDER_HORROR_CODE = 4;
  static const int GENDER_KIDS_CODE = 74;
  static const int GENDER_MUSICAL_CODE = 129;
  static const int GENDER_NOIR_CODE = 186;
  static const int GENDER_ROMANCE_CODE = 30;
  static const int GENDER_SCIFI_CODE = 49;
  static const int GENDER_SUSPENSE_CODE = 15;
  static const int GENDER_THRILLER_CODE = 2;
  static const int GENDER_WESTERN_CODE = 109;

  int id;
  String name;
  String type;

  Genre({this.id, this.name, this.type});

  factory Genre.fromString(String data) {
    Map dataConverted = json.decode(data);
    return new Genre.fromMap(dataConverted);
  }

  factory Genre.fromMap(Map dataConverted) {
    Genre g = new Genre();
    g.id = dataConverted['id'];
    g.name = dataConverted['name'];
    g.type = dataConverted['type'];
    return g;
  }

  Map toMap() {
    Map m = new Map();
    if (id != null) {
      m.putIfAbsent('id', () => id);
    }
    if (!isNullOrEmpty(name)) {
      m.putIfAbsent('name', () => name);
    }
    if (!isNullOrEmpty(type)) {
      m.putIfAbsent('type', () => type);
    }
    return m;
  }

  bool equals(Genre g) {
    if (this.name != null && (g.name == null || this.name != g.name)) {
      return false;
    }
    if (this.id != null && (g.id == null || this.id != g.id)) {
      return false;
    }
    if (this.type != null && (g.type == null || this.type != g.type)) {
      return false;
    }
    return true;
  }
}
