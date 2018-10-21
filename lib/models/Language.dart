import 'dart:convert';

import 'package:pelis_busta/support/utils/Utils.dart';

class Language {
  String codigo;
  String nombre;

  Language({this.codigo, this.nombre});

  factory Language.fromString(String data) {
    Map dataConverted = json.decode(data);
    return new Language.fromMap(dataConverted);
  }

  factory Language.fromMap(Map dataConverted) {
    Language l = new Language();
    l.codigo = dataConverted['codigo'];
    l.nombre = dataConverted['nombre'];
    return l;
  }

  Map toMap() {
    Map m = new Map();
    if (!isNullOrEmpty(codigo)) {
      m.putIfAbsent('codigo', () => codigo);
    }
    if (!isNullOrEmpty(nombre)) {
      m.putIfAbsent('nombre', () => nombre);
    }
    return m;
  }

  bool equals(Language lang) {
    if (this.nombre != null &&
        (lang.nombre == null || this.nombre != lang.nombre)) {
      return false;
    }
    if (this.codigo != null &&
        (lang.codigo == null || this.codigo != lang.codigo)) {
      return false;
    }
    return true;
  }
}
