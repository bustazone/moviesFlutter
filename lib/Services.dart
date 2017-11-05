import 'dart:async';
import 'package:flutter/services.dart';
import 'package:pelis_busta/FilmModel.dart';
import 'dart:convert';

final String listUrl = "http://bustazone.com:8080/pelisBustaWS/peliculas/list";

var httpClient = createHttpClient();

Future<List<Film>> postData(FilmFilter filter) async {
  print(JSON.encode(filter.toMap()));
  var response = await httpClient.post(listUrl, body: JSON.encode(filter.toMap()));
  print('Response status: ${response.statusCode}');
  print(response.body);
  var fromResponseFilm = Response.fromResponseFilmString(response.body);
  return fromResponseFilm.items;
}