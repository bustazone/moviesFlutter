import 'package:http/http.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequest.dart';
import 'package:redux/redux.dart';

void servicesMiddleware(Store<AppState> store, action, NextDispatcher next) {
  final onSuccess = (castedAction, response) {

    print(response);
    print('Response status: ${response.statusCode}');
    print(response.body);
    castedAction.actionSuccess.response =
        castedAction.transformFunction(response.body);
    print(castedAction.actionSuccess.response);
    if (castedAction.onSuccess != null)
      castedAction.onSuccess(castedAction.actionSuccess.response);
    next(castedAction.actionSuccess);
  };

  final onFailure = (castedAction, onError) {
    print("onError");
    print(onError);
    castedAction.actionFailure.status = 0;
    castedAction.actionFailure.error = onError.toString();
    if (castedAction.onFailure != null)
      castedAction.onFailure(castedAction.actionFailure.error);
    next(castedAction.actionFailure);
  };

  if (action is ServicesMiddlewareRequest) {
    final ServicesMiddlewareRequest castedAction = action;
    next(castedAction.actionStart);
    final httpClient = Client();
    if (castedAction.method == RequestMethod.GET) {
      httpClient.get(castedAction.url).then((Response response) {
        onSuccess(castedAction, response);
      }).catchError((onError) {
        onFailure(castedAction, onError);
      }).whenComplete(() {
        httpClient.close();
      });
    } else if (castedAction.method == RequestMethod.POST) {
      httpClient
          .post(castedAction.url, body: castedAction.body)
          .then((Response response) {
        onSuccess(castedAction, response);
      }).catchError((onError) {
        onFailure(castedAction, onError);
      }).whenComplete(() {
        httpClient.close();
      });
    }
  } else {
    next(action);
  }
}
