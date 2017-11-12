import 'dart:async';
import 'package:flutter/services.dart';
import 'package:pelis_busta/FilmModel.dart';
import 'dart:convert';

const String BASE_URL = "http://bustazone.com:8080/pelisBustaWS/peliculas";
final String listUrl = BASE_URL+"/list";
final String listSubGenre = BASE_URL+"/listGenders?everything=false&type=listas_filmaffinity";
final String listLangs = BASE_URL+"/listLanguages?everything=false";
final String listSubs = BASE_URL+"/listSubtitles?everything=false";

Future<List<Film>> getItemsList(FilmFilter filter) async {
  var httpClient = createHttpClient();
  print(JSON.encode(filter.toMap()));
  var response = await httpClient.post(listUrl, body: JSON.encode(filter.toMap()));
  print('Response status: ${response.statusCode}');
  print(response.body);
  var fromResponseFilm = Response.fromResponseFilmString(response.body);
  httpClient.close();
  return fromResponseFilm.items;
}

Future<List<Gender>> getSubGenresList() async {
  var httpClient = createHttpClient();
  var response = await httpClient.get(listSubGenre);
  print('Response status: ${response.statusCode}');
  print(response.body);
  var fromResponseFilm = Response.fromResponseGenreString(response.body);
  httpClient.close();
  return fromResponseFilm.items;
}

Future<List<Language>> getLanguagesList() async {
  var httpClient = createHttpClient();
  var response = await httpClient.get(listLangs);
  print('Response status: ${response.statusCode}');
  print(response.body);
  print("jhljhgkjhgkjhgkjhv");
  var fromResponseFilm = Response.fromResponseLangString(response.body);
  httpClient.close();
  return fromResponseFilm.items;
}

Future<List<Language>> getSubtitlesList() async {
  var httpClient = createHttpClient();
  var response = await httpClient.get(listSubs);
  print('Response status: ${response.statusCode}');
  print(response.body);
  print("jhljhgkjhgkjhgkjhv");
  var fromResponseFilm = Response.fromResponseLangString(response.body);
  httpClient.close();
  return fromResponseFilm.items;
}