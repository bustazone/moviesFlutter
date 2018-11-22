import 'package:pelis_busta/models/LanguageList.dart';
import 'package:pelis_busta/state/LanguagesListState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

final languagesListReducer = combineReducers<LanguagesListState>([
  TypedReducer<LanguagesListState, GetLanguagesListRequestStartAction>(
      _setLoadingData),
  TypedReducer<LanguagesListState, GetLanguagesListRequestSuccessAction>(_setLangs),
  TypedReducer<LanguagesListState, GetLanguagesListRequestFailureAction>(
      _setNotLoadingData)
]);

LanguagesListState _setLangs(
    LanguagesListState state, GetLanguagesListRequestSuccessAction action) {
  return state.copyWith(languagesList: LanguageList(l: action.response));
}

LanguagesListState _setLoadingData(LanguagesListState state, dynamic action) {
  return state.copyWith(loading: true);
}

LanguagesListState _setNotLoadingData(LanguagesListState state, dynamic action) {
  return state.copyWith(loading: false);
}