import 'dart:convert';

import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/models/FilmFilter.dart';
import 'package:pelis_busta/models/NetResponse.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequest.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestFailureAction.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestStartAction.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestSuccessAction.dart';

ServicesMiddlewareRequest getFilteredListRequest(FilmFilter filter,
    {bool queryMore = false}) {
  const String BASE_URL = "http://bustazone.com:8080/pelisBustaWS/peliculas";
  final String listUrl = BASE_URL + "/list";
  final body = json.encode(filter.toMap());
  final transformFunc = (responseBody) {
    return NetResponse.fromResponseFilmString(responseBody).items;
  };
  if (queryMore) {
    return new ServicesMiddlewareRequest.post(
        listUrl,
        body,
        transformFunc,
        GetFilteredListNextPageRequestStartAction(),
        GetFilteredListNextPageRequestSuccessAction(),
        GetFilteredListNextPageRequestFailureAction());
  } else {
    return new ServicesMiddlewareRequest.post(
        listUrl,
        body,
        transformFunc,
        GetFilteredListRequestStartAction(),
        GetFilteredListRequestSuccessAction(),
        GetFilteredListRequestFailureAction());
  }
}

class GetFilteredListRequestStartAction
    extends ServicesMiddlewareRequestStartAction {}

class GetFilteredListRequestSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<List<Film>> {}

class GetFilteredListRequestFailureAction
    extends ServicesMiddlewareRequestFailureAction {}

class GetFilteredListNextPageRequestStartAction
    extends ServicesMiddlewareRequestStartAction {}

class GetFilteredListNextPageRequestSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<List<Film>> {}

class GetFilteredListNextPageRequestFailureAction
    extends ServicesMiddlewareRequestFailureAction {}
