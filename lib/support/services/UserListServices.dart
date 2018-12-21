import 'package:pelis_busta/models/NetResponse.dart';
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
