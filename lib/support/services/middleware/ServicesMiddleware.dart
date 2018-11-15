import 'package:http/http.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddlewareRequest.dart';
import 'package:redux/redux.dart';

void servicesMiddleware(Store<AppState> store, action, NextDispatcher next) {

  // If our Middleware encounters a `FetchTodoAction`
  if (action is ServicesMiddlewareRequest) {
    final ServicesMiddlewareRequest castedAction = action;
    next(castedAction.actionStart);
    final httpClient = Client();
    if (castedAction.method == RequestMethod.POST) {
      httpClient.post(castedAction.url, body: castedAction.body).then((
          Response response) {
        print('Response status: ${response.statusCode}');
        print(response.body);
        castedAction.actionSuccess.response =
            castedAction.transformFunction(response.body);
        next(castedAction.actionSuccess);
      }).catchError((onError) {
        print("onError");
        print(onError);
        castedAction.actionFailure.status = 0;
        castedAction.actionFailure.error = onError.toString();
        next(castedAction.actionFailure);
      }).whenComplete(() {
        httpClient.close();
      });
    }
  } else {
    next(action);
  }
}