import 'package:pelis_busta/state/LoadingDataState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:pelis_busta/support/services/UserListServices.dart';
import 'package:redux/redux.dart';

final loadingDataReducer = combineReducers<LoadingDataState>([
  TypedReducer<LoadingDataState, GetFilteredListRequestStartAction>(
      _setLoadingData),
  TypedReducer<LoadingDataState, GetFilteredListRequestSuccessAction>(
      _setNotLoadingData),
  TypedReducer<LoadingDataState, GetFilteredListRequestFailureAction>(
      _setNotLoadingData),
  TypedReducer<LoadingDataState, GetFilmRequestStartAction>(_setLoadingData),
  TypedReducer<LoadingDataState, GetFilmRequestSuccessAction>(
      _setNotLoadingData),
  TypedReducer<LoadingDataState, GetFilmRequestFailureAction>(
      _setNotLoadingData),
  TypedReducer<LoadingDataState, GetRandomFilmFilteredRequestStartAction>(
      _setLoadingData),
  TypedReducer<LoadingDataState, GetRandomFilmFilteredRequestSuccessAction>(
      _setNotLoadingData),
  TypedReducer<LoadingDataState, GetRandomFilmFilteredRequestFailureAction>(
      _setNotLoadingData),
  TypedReducer<LoadingDataState, UpdateFilmRequestStartAction>(_setLoadingData),
  TypedReducer<LoadingDataState, UpdateFilmRequestSuccessAction>(
      _setNotLoadingData),
  TypedReducer<LoadingDataState, UpdateFilmRequestFailureAction>(
      _setNotLoadingData),
  TypedReducer<LoadingDataState, GetUserListRequestStartAction>(
      _setLoadingData),
  TypedReducer<LoadingDataState, GetUserListRequestSuccessAction>(
      _setNotLoadingData),
  TypedReducer<LoadingDataState, GetUserListRequestFailureAction>(
      _setNotLoadingData),
  TypedReducer<LoadingDataState, RemoveListFromUserRequestStartAction>(
      _setLoadingData),
  TypedReducer<LoadingDataState, RemoveListFromUserRequestSuccessAction>(
      _setNotLoadingData),
  TypedReducer<LoadingDataState, RemoveListFromUserRequestFailureAction>(
      _setNotLoadingData)
]);

LoadingDataState _setLoadingData(LoadingDataState state, dynamic action) {
  return state.copyWith(loadingProcesses: add(state.loadingProcesses));
}

LoadingDataState _setNotLoadingData(LoadingDataState state, dynamic action) {
  return state.copyWith(loadingProcesses: sub(state.loadingProcesses));
}

final add = (intData) => intData + 1;

final sub = (intData) => intData == 0 ? 0 : intData - 1;
