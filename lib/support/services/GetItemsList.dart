import 'dart:convert';

import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/models/FilmFilter.dart';
import 'package:pelis_busta/models/LanguageList.dart';
import 'package:pelis_busta/models/NetResponse.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequest.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestFailureAction.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestStartAction.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestSuccessAction.dart';

const String BASE_URL = "http://bustazone.com:8080/pelisBustaWS/peliculas";

ServicesMiddlewareRequest getFilteredListRequest(FilmFilter filter,
    {bool queryMore = false, onSuccess}) {
  final String listUrl = BASE_URL + "/list";
  final body = json.encode(filter.toMap());
  final transformFunc = (responseBody) {
    return NetResponse
        .fromResponseFilmString(responseBody)
        .items;
  };
  if (queryMore) {
    return new ServicesMiddlewareRequest.post(
        listUrl,
        body,
        transformFunc,
        GetFilteredListNextPageRequestStartAction(),
        GetFilteredListNextPageRequestSuccessAction(),
        GetFilteredListNextPageRequestFailureAction(),
        onSuccess: onSuccess);
  } else {
    return new ServicesMiddlewareRequest.post(
        listUrl,
        body,
        transformFunc,
        GetFilteredListRequestStartAction(),
        GetFilteredListRequestSuccessAction(),
        GetFilteredListRequestFailureAction(),
        onSuccess: onSuccess);
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


ServicesMiddlewareRequest getFilmDetailRequest(int id) {
  final String itemUrl = "$BASE_URL/$id";
  print(itemUrl);
  final transformFunc = (responseBody) {
    return NetResponse
        .fromResponseFilmString(responseBody)
        .items;
  };
  return new ServicesMiddlewareRequest.get(
      itemUrl,
      transformFunc,
      GetFilmRequestStartAction(),
      GetFilmRequestSuccessAction(),
      GetFilmRequestFailureAction());
}

class GetFilmRequestStartAction extends ServicesMiddlewareRequestStartAction {}

class GetFilmRequestSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<List<Film>> {}

class GetFilmRequestFailureAction
    extends ServicesMiddlewareRequestFailureAction {}


ServicesMiddlewareRequest getLanguagesRequest() {
  final String itemUrl = "$BASE_URL/listLanguages?everything=false";
  print(itemUrl);
  final transformFunc = (responseBody) {
    return NetResponse
        .fromResponseLangString(responseBody)
        .items;
  };
  return new ServicesMiddlewareRequest.get(
      itemUrl,
      transformFunc,
      GetLanguagesListRequestStartAction(),
      GetLanguagesListRequestSuccessAction(),
      GetLanguagesListRequestFailureAction());
}

class GetLanguagesListRequestStartAction extends ServicesMiddlewareRequestStartAction {}

class GetLanguagesListRequestSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<LanguageList> {}

class GetLanguagesListRequestFailureAction
    extends ServicesMiddlewareRequestFailureAction {}


ServicesMiddlewareRequest getSubtitlesRequest() {
  final String itemUrl = "$BASE_URL/listSubtitles?everything=false";
  print(itemUrl);
  final transformFunc = (responseBody) {
    return NetResponse
        .fromResponseLangString(responseBody)
        .items;
  };
  return new ServicesMiddlewareRequest.get(
      itemUrl,
      transformFunc,
      GetSubtitlesListRequestStartAction(),
      GetSubtitlesListSuccessAction(),
      GetSubtitlesListFailureAction());
}

class GetSubtitlesListRequestStartAction extends ServicesMiddlewareRequestStartAction {}

class GetSubtitlesListSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<LanguageList> {}

class GetSubtitlesListFailureAction
    extends ServicesMiddlewareRequestFailureAction {}


ServicesMiddlewareRequest getSubGenresRequest() {
  final String itemUrl = "$BASE_URL/listGenders?everything=false&type=listas_filmaffinity";
  print(itemUrl);
  final transformFunc = (responseBody) {
    return NetResponse
        .fromResponseGenreString(responseBody)
        .items;
  };
  return new ServicesMiddlewareRequest.get(
      itemUrl,
      transformFunc,
      GetSubGenresListRequestStartAction(),
      GetSubGenresListSuccessAction(),
      GetSubGenresListFailureAction());
}

class GetSubGenresListRequestStartAction extends ServicesMiddlewareRequestStartAction {}

class GetSubGenresListSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<LanguageList> {}

class GetSubGenresListFailureAction
    extends ServicesMiddlewareRequestFailureAction {}