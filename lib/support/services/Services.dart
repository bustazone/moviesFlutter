import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/models/FilmFilter.dart';
import 'package:pelis_busta/models/Genre.dart';
import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/models/NetResponse.dart';

const String BASE_URL = "http://bustazone.com:8080/pelisBustaWS/peliculas";
final String listUrl = BASE_URL + "/list";
final String listSubGenre =
    BASE_URL + "/listGenders?everything=false&type=listas_filmaffinity";
final String listLangs = BASE_URL + "/listLanguages?everything=false";
final String listSubs = BASE_URL + "/listSubtitles?everything=false";

Future<List<Film>> getItemsList(FilmFilter filter) async {
  var httpClient = Client();
  var response =
      await httpClient.post(listUrl, body: json.encode(filter.toMap()));
  print('Response status: ${response.statusCode}');
  print(response.body);
  var fromResponseFilm = NetResponse.fromResponseFilmString(response.body);
  httpClient.close();
  return fromResponseFilm.items;
}

Future<List<Genre>> getSubGenresList() async {
  var httpClient = Client();
  var response = await httpClient.get(listSubGenre);
  print('Response status: ${response.statusCode}');
  print(response.body);
  var fromResponseFilm = NetResponse.fromResponseGenreString(response.body);
  httpClient.close();
  return fromResponseFilm.items;
}

Future<List<Language>> getLanguagesList() async {
  var httpClient = Client();
  var response = await httpClient.get(listLangs);
  print('Response status: ${response.statusCode}');
  print(response.body);
  print("jhljhgkjhgkjhgkjhv");
  var fromResponseFilm = NetResponse.fromResponseLangString(response.body);
  httpClient.close();
  return fromResponseFilm.items;
}

Future<List<Language>> getSubtitlesList() async {
  var httpClient = Client();
  var response = await httpClient.get(listSubs);
  print('Response status: ${response.statusCode}');
  print(response.body);
  print("jhljhgkjhgkjhgkjhv");
  var fromResponseFilm = NetResponse.fromResponseLangString(response.body);
  httpClient.close();
  return fromResponseFilm.items;
}
