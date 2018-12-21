import 'dart:convert';

import 'package:pelis_busta/models/UserList.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class User {
  int id;
  String name;
  String email;
  List<UserList> lists;

  User({this.id, this.name, this.email, this.lists});

  factory User.fromString(String data) {
    Map dataConverted = json.decode(data);
    return new User.fromMap(dataConverted);
  }

  factory User.fromMap(Map dataConverted) {
    User l = new User();
    l.id = dataConverted['id'];
    l.name = dataConverted['name'];
    l.email = dataConverted['email'];
    List listFilms = dataConverted['lists'];
    if (!isNullOrEmpty(listFilms)) {
      l.lists = new List();
      for (Map i in listFilms) {
        l.lists.add(new UserList.fromMap(i));
      }
    }
    return l;
  }
}
