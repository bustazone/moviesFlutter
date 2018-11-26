import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/state/FilmListState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

final filmListReducer = combineReducers<FilmListState>([
  TypedReducer<FilmListState, GetFilteredListRequestStartAction>(
      _setLoadingData),
  TypedReducer<FilmListState, GetFilteredListNextPageRequestStartAction>(
      _setLoadingData),
  TypedReducer<FilmListState, GetFilteredListRequestSuccessAction>(_setFilms),
  TypedReducer<FilmListState, GetFilteredListRequestSuccessAction>(
      _setNotLoadingData),
  TypedReducer<FilmListState, GetFilteredListNextPageRequestSuccessAction>(
      _addFilms),
  TypedReducer<FilmListState, GetFilteredListNextPageRequestSuccessAction>(
      _setPage),
  TypedReducer<FilmListState, GetFilteredListNextPageRequestSuccessAction>(
      _setNotLoadingData),
  TypedReducer<FilmListState, GetFilteredListRequestFailureAction>(
      _setNotLoadingData),
  TypedReducer<FilmListState, GetFilteredListNextPageRequestFailureAction>(
      _setNotLoadingData),
  TypedReducer<FilmListState, GetFilteredListNextPageRequestFailureAction>(
      _setNotCouldQueryMore),
  TypedReducer<FilmListState, ResetListAction>(_resetList)
]);

FilmListState _setFilms(
    FilmListState state, GetFilteredListRequestSuccessAction action) {
  return state.copyWith(filmList: action.response);
}

FilmListState _addFilms(
    FilmListState state, GetFilteredListNextPageRequestSuccessAction action) {
  List<Film> list = List.from(state.filmList)..addAll(action.response);
  return state.copyWith(filmList: list, couldQueryMore: action.response.length > 0);
}

FilmListState _setPage(FilmListState state, dynamic action) {
  return state.copyWith(page: state.page + 1);
}

FilmListState _setNotCouldQueryMore(FilmListState state, dynamic action) {
  return state.copyWith(couldQueryMore: false);
}

FilmListState _setLoadingData(FilmListState state, dynamic action) {
  return state.copyWith(loading: true);
}

FilmListState _setNotLoadingData(FilmListState state, dynamic action) {
  return state.copyWith(loading: false);
}

FilmListState _resetList(FilmListState state, dynamic action) {
  return FilmListState.initial();
}
