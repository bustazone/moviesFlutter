import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestFailureAction.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestStartAction.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequestSuccessAction.dart';

enum RequestMethod { GET, POST }

class ServicesMiddlewareRequest {
  final String url;
  final RequestMethod method;
  final String body;
  final transformFunction;
  final ServicesMiddlewareRequestStartAction actionStart;
  final ServicesMiddlewareRequestSuccessAction actionSuccess;
  final ServicesMiddlewareRequestFailureAction actionFailure;
  final onSuccess;
  final onFailure;

  const ServicesMiddlewareRequest(
      this.url,
      this.method,
      this.body,
      this.transformFunction,
      this.actionStart,
      this.actionSuccess,
      this.actionFailure,
      this.onSuccess,
      this.onFailure);

  factory ServicesMiddlewareRequest.get(
          url, transformFunction, actionStart, actionSuccess, actionFailure,
          {onSuccess, onFailure}) =>
      new ServicesMiddlewareRequest(
          url,
          RequestMethod.GET,
          null,
          transformFunction,
          actionStart,
          actionSuccess,
          actionFailure,
          onSuccess,
          onFailure);

  factory ServicesMiddlewareRequest.post(url, body, transformFunction,
          actionStart, actionSuccess, actionFailure, {onSuccess, onFailure}) =>
      new ServicesMiddlewareRequest(
          url,
          RequestMethod.POST,
          body,
          transformFunction,
          actionStart,
          actionSuccess,
          actionFailure,
          onSuccess,
          onFailure);

  @override
  int get hashCode =>
      url.hashCode ^
      method.hashCode ^
      actionStart.hashCode ^
      actionSuccess.hashCode ^
      actionFailure.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesMiddlewareRequest &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          method == other.method;

  //Type.sameClass()actionSuccess is other.actionSuccess &&
  //actionFailure is other.actionFailure;

  @override
  String toString() {
    return 'ServicesMiddlewareRequest{url: $url, method: $method, body: $body, actionStart: $actionStart, actionSuccess: $actionSuccess, actionFailure: $actionFailure}';
  }
}
