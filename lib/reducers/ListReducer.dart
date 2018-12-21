import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/state/ListState.dart';
import 'package:pelis_busta/support/services/UserListServices.dart';
import 'package:redux/redux.dart';

final listReducer = combineReducers<ListState>([
  TypedReducer<ListState, GetUserListRequestStartAction>(_setLoadingData),
  TypedReducer<ListState, GetUserListRequestSuccessAction>(_setFilms),
  TypedReducer<ListState, GetUserListRequestSuccessAction>(_setNotLoadingData),
  TypedReducer<ListState, GetUserListRequestFailureAction>(_setNotLoadingData),
  TypedReducer<ListState, SetSelectedListIdStateAction>(_setSelectedListId)
]);

ListState _setFilms(ListState state, GetUserListRequestSuccessAction action) {
  return state.copyWith(
      list: (action.response != null && action.response.length > 0)
          ? action.response[0]
          : null);
}

ListState _setLoadingData(ListState state, dynamic action) {
  return state.copyWith(loading: true);
}

ListState _setNotLoadingData(ListState state, dynamic action) {
  return state.copyWith(loading: false);
}

ListState _setSelectedListId(
    ListState state, SetSelectedListIdStateAction action) {
  return state.copyWith(selectedList: action.listId);
}
