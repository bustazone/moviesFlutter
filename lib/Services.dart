import 'dart:async';
import 'package:flutter/services.dart';
import 'package:pelis_busta/FilmModel.dart';
import 'dart:convert';

final String listUrl = "http://bustazone.com:8080/pelisBustaWS/peliculas/list";
final String listSubGenre = "http://bustazone.com:8080/pelisBustaWS/peliculas/listGenders?everything=false&tipo=listas_filmaffinity";

var httpClient;

Future<List<Film>> getItemsList(FilmFilter filter) async {
  httpClient = createHttpClient();
  print(JSON.encode(filter.toMap()));
  var response = await httpClient.post(listUrl, body: JSON.encode(filter.toMap()));
  print('Response status: ${response.statusCode}');
  print(response.body);
  var fromResponseFilm = Response.fromResponseFilmString(response.body);
  httpClient.close();
  return fromResponseFilm.items;
}

Future<List<Gender>> getSubGenresList() async {
  httpClient = createHttpClient();
  var response = await httpClient.get(listSubGenre);
  print('Response status: ${response.statusCode}');
  print(response.body);
  var fromResponseFilm = Response.fromResponseGenreString(response.body);
  httpClient.close();
  return fromResponseFilm.items;
}