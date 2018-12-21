import 'package:pelis_busta/models/NetResponse.dart';
import 'package:pelis_busta/models/User.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequest.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestFailureAction.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestStartAction.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestSuccessAction.dart';

const String BASE_URL = "http://bustazone.com:8080/pelisBustaWS";

ServicesMiddlewareRequest getUserRequest({onSuccess}) {
  final String listUrl = BASE_URL + "/user/?email=bustazone@gmail.com";
  final transformFunc = (responseBody) {
    return NetResponse.fromResponseUserString(responseBody).items;
  };
  return new ServicesMiddlewareRequest.get(
      listUrl,
      transformFunc,
      GetUserRequestStartAction(),
      GetUserRequestSuccessAction(),
      GetUserRequestFailureAction(),
      onSuccess: onSuccess);
}

class GetUserRequestStartAction extends ServicesMiddlewareRequestStartAction {}

class GetUserRequestSuccessAction
    extends ServicesMiddlewareRequestSuccessAction<List<User>> {}

class GetUserRequestFailureAction
    extends ServicesMiddlewareRequestFailureAction {}
