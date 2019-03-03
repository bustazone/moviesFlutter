import 'package:pelis_busta/models/NetResponse.dart';
import 'package:pelis_busta/models/User.dart';
import 'package:pelis_busta/models/UserList.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequest.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestFailureAction.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestStartAction.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestSuccessAction.dart';

const String BASE_URL = "http://bustazone.com:8080/pelisBustaWS";

ServicesMiddlewareRequest getUserListRequest(int listId, {onSuccess}) {
  final String listUrl = BASE_URL + "/list/" + listId.toString();
  final transformFunc = (responseBody) {
    return NetResponse.fromResponseUserListString(responseBody).items;
  };
  return new ServicesMiddlewareRequest.get(
      listUrl,
      transformFunc,
      GetUserListRequestStartAction(),
      GetUserListRequestSuccessAction(),
      GetUserListRequestFailureAction(),
      onSuccess: onSuccess);
}

class GetUserListRequestStartAction
    extends ServicesMiddlewareRequestStartAction {}

class GetUserListRequestSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<List<UserList>> {}

class GetUserListRequestFailureAction
    extends ServicesMiddlewareRequestFailureAction {}

ServicesMiddlewareRequest addUserListRequest(int userId, String listName,
    {onSuccess}) {
  final String listUrl = BASE_URL + "/list/create";
  final transformFunc = (responseBody) {
    return NetResponse.fromResponseUserListString(responseBody).items;
  };
  return new ServicesMiddlewareRequest.post(
      listUrl,
      "{\"user_id\":$userId,\"listName\":\"$listName\"}",
      transformFunc,
      AddUserToListRequestStartAction(),
      AddUserToListRequestSuccessAction(),
      AddUserToListRequestFailureAction(),
      onSuccess: onSuccess);
}

class AddUserToListRequestStartAction
    extends ServicesMiddlewareRequestStartAction {}

class AddUserToListRequestSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<List<UserList>> {}

class AddUserToListRequestFailureAction
    extends ServicesMiddlewareRequestFailureAction {}

ServicesMiddlewareRequest removeListFromUserRequest(int userId, int listId,
    {onSuccess}) {
  final String listUrl = BASE_URL + "/list/remove";
  final transformFunc = (responseBody) {
    return NetResponse.fromResponseUserString(responseBody).items;
  };
  return new ServicesMiddlewareRequest.post(
      listUrl,
      "{\"user_id\":$userId,\"list_id\":$listId}",
      transformFunc,
      RemoveListFromUserRequestStartAction(),
      RemoveListFromUserRequestSuccessAction(),
      RemoveListFromUserRequestFailureAction(),
      onSuccess: onSuccess);
}

class RemoveListFromUserRequestStartAction
    extends ServicesMiddlewareRequestStartAction {}

class RemoveListFromUserRequestSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<List<User>> {}

class RemoveListFromUserRequestFailureAction
    extends ServicesMiddlewareRequestFailureAction {}

ServicesMiddlewareRequest addFilmToListRequest(int listId, int filmId,
    {onSuccess}) {
  final String listUrl = BASE_URL + "/list/add_film";
//  final transformFunc = (responseBody) {
//    return NetResponse.fromResponseUserString(responseBody).items;
//  };
  return new ServicesMiddlewareRequest.post(
      listUrl,
      "{\"film_id\":$filmId,\"list_id\":$listId}",
      null,
      AddFilmToListRequestStartAction(),
      AddFilmToListRequestSuccessAction(),
      AddFilmToListRequestFailureAction(),
      onSuccess: onSuccess);
}

class AddFilmToListRequestStartAction
    extends ServicesMiddlewareRequestStartAction {}

class AddFilmToListRequestSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<List<User>> {}

class AddFilmToListRequestFailureAction
    extends ServicesMiddlewareRequestFailureAction {}

ServicesMiddlewareRequest removeFilmFromListRequest(int filmId, int listId,
    {onSuccess}) {
  final String listUrl = BASE_URL + "/list/remove_film";
  final transformFunc = (responseBody) {
    return NetResponse.fromResponseUserListString(responseBody).items;
  };
  return new ServicesMiddlewareRequest.post(
      listUrl,
      "{\"film_id\":$filmId,\"list_id\":$listId}",
      transformFunc,
      RemoveFilmFromListRequestStartAction(),
      RemoveFilmFromListRequestSuccessAction(),
      RemoveFilmFromListRequestFailureAction(),
      onSuccess: onSuccess);
}

class RemoveFilmFromListRequestStartAction
    extends ServicesMiddlewareRequestStartAction {}

class RemoveFilmFromListRequestSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<List<UserList>> {}

class RemoveFilmFromListRequestFailureAction
    extends ServicesMiddlewareRequestFailureAction {}
