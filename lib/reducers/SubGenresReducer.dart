import 'package:pelis_busta/models/GenreList.dart';
import 'package:pelis_busta/state/SubGenresListState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

final subGenresListReducer = combineReducers<SubGenresListState>([
  TypedReducer<SubGenresListState, GetSubGenresListRequestStartAction>(
      _setLoadingData),
  TypedReducer<SubGenresListState, GetSubGenresListRequestSuccessAction>(
      _setLangs),
  TypedReducer<SubGenresListState, GetSubGenresListRequestFailureAction>(
      _setNotLoadingData)
]);

SubGenresListState _setLangs(
    SubGenresListState state, GetSubGenresListRequestSuccessAction action) {
  return state.copyWith(genresList: GenreList(l: action.response));
}

SubGenresListState _setLoadingData(SubGenresListState state, dynamic action) {
  return state.copyWith(loading: true);
}

SubGenresListState _setNotLoadingData(
    SubGenresListState state, dynamic action) {
  return state.copyWith(loading: false);
}
