import 'package:pelis_busta/state/UserState.dart';
import 'package:pelis_busta/support/services/UserServices.dart';
import 'package:redux/redux.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, GetUserRequestStartAction>(_setLoadingData),
  TypedReducer<UserState, GetUserRequestSuccessAction>(_setFilms),
  TypedReducer<UserState, GetUserRequestSuccessAction>(_setNotLoadingData),
  TypedReducer<UserState, GetUserRequestFailureAction>(_setNotLoadingData)
]);

UserState _setFilms(UserState state, GetUserRequestSuccessAction action) {
  return state.copyWith(
      user: (action.response != null && action.response.length > 0)
          ? action.response[0]
          : null);
}

UserState _setLoadingData(UserState state, dynamic action) {
  return state.copyWith(loading: true);
}

UserState _setNotLoadingData(UserState state, dynamic action) {
  return state.copyWith(loading: false);
}
