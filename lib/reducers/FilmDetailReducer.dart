import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/state/FilmDetailState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

final filmDetailReducer = combineReducers<FilmDetailState>([
  TypedReducer<FilmDetailState, SetSelectedFilmIdStateAction>(
      _setSelectedFilmId),
  TypedReducer<FilmDetailState, GetFilmRequestStartAction>(_setLoadingData),
  TypedReducer<FilmDetailState, GetFilmRequestSuccessAction>(
      _setNotLoadingData),
  TypedReducer<FilmDetailState, GetFilmRequestFailureAction>(
      _setNotLoadingData),
  TypedReducer<FilmDetailState, GetFilmRequestSuccessAction>(_setFilm),
  TypedReducer<FilmDetailState, GetRandomFilmFilteredRequestStartAction>(
      _setLoadingData),
  TypedReducer<FilmDetailState, GetRandomFilmFilteredRequestFailureAction>(
      _setNotLoadingData),
  TypedReducer<FilmDetailState, GetRandomFilmFilteredRequestSuccessAction>(
      _setNotLoadingData),
  TypedReducer<FilmDetailState, GetRandomFilmFilteredRequestSuccessAction>(
      _setFilm),
]);

FilmDetailState _setSelectedFilmId(
    FilmDetailState state, SetSelectedFilmIdStateAction action) {
  return state.copyWith(selectedFilmId: action.filmId);
}

FilmDetailState _setFilm(FilmDetailState state, dynamic action) {
  return state.copyWith(
      selectedFilm: (action.response != null && action.response.length > 0)
          ? action.response[0]
          : null);
}

FilmDetailState _setLoadingData(FilmDetailState state, dynamic action) {
  return state.copyWith(loading: true);
}

FilmDetailState _setNotLoadingData(FilmDetailState state, dynamic action) {
  return state.copyWith(loading: false);
}
