import 'dart:convert';

import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class UserList {

  int id;
  String name;
  List<Film> films = new List();

  UserList({this.id, this.name, this.films});

  factory UserList.fromString(String data) {
    Map dataConverted = json.decode(data);
    return new UserList.fromMap(dataConverted);
  }

  factory UserList.fromMap(Map dataConverted) {
    UserList l = new UserList();
    l.id = dataConverted['id'];
    l.name = dataConverted['name'];
    List listFilms = dataConverted['films'];
    if (!isNullOrEmpty(listFilms)) {
      l.films = new List();
      for (Map i in listFilms) {
        l.films.add(new Film.fromMap(i));
      }
    }
    return l;
  }
}
