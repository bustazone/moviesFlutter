import 'dart:convert';

import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/models/Genre.dart';
import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/models/User.dart';
import 'package:pelis_busta/models/UserList.dart';

class NetResponse<T> {
  String code;
  String message;
  int rowCount;
  List<T> items = new List();

  static NetResponse<Film> fromResponseFilmString(String data) {
    var response = new NetResponse<Film>();
    Map dataConverted = json.decode(data);
    response.code = dataConverted['code'];
    response.message = dataConverted['message'];
    response.rowCount = dataConverted['rowCount'];
    List listItems = dataConverted['items'];
    for (Map i in listItems) {
      response.items.add(new Film.fromMap(i));
    }
    return response;
  }

  static NetResponse<Genre> fromResponseGenreString(String data) {
    var response = new NetResponse<Genre>();
    Map dataConverted = json.decode(data);
    response.code = dataConverted['code'];
    response.message = dataConverted['message'];
    response.rowCount = dataConverted['rowCount'];
    List listItems = dataConverted['items'];
    for (Map i in listItems) {
      response.items.add(new Genre.fromMap(i));
    }
    return response;
  }

  static NetResponse<Language> fromResponseLangString(String data) {
    var response = new NetResponse<Language>();
    Map dataConverted = json.decode(data);
    response.code = dataConverted['code'];
    response.message = dataConverted['message'];
    response.rowCount = dataConverted['rowCount'];
    List listItems = dataConverted['items'];
    for (Map i in listItems) {
      response.items.add(new Language.fromMap(i));
    }
    return response;
  }

  static NetResponse<User> fromResponseUserString(String data) {
    var response = new NetResponse<User>();
    Map dataConverted = json.decode(data);
    response.code = dataConverted['code'];
    response.message = dataConverted['message'];
    response.rowCount = dataConverted['rowCount'];
    List listItems = dataConverted['items'];
    for (Map i in listItems) {
      response.items.add(new User.fromMap(i));
    }
    return response;
  }

  static NetResponse<UserList> fromResponseUserListString(String data) {
    var response = new NetResponse<UserList>();
    Map dataConverted = json.decode(data);
    response.code = dataConverted['code'];
    response.message = dataConverted['message'];
    response.rowCount = dataConverted['rowCount'];
    List listItems = dataConverted['items'];
    for (Map i in listItems) {
      response.items.add(new UserList.fromMap(i));
    }
    return response;
  }
}
