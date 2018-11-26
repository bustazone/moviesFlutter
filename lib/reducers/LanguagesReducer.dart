import 'package:pelis_busta/models/LanguageList.dart';
import 'package:pelis_busta/state/LanguagesListState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

final languagesListReducer = combineReducers<LanguagesListState>([
  TypedReducer<LanguagesListState, GetLanguagesListRequestStartAction>(
      _setLoadingLangsData),
  TypedReducer<LanguagesListState, GetLanguagesListRequestSuccessAction>(
      _setLangs),
  TypedReducer<LanguagesListState, GetLanguagesListRequestFailureAction>(
      _setNotLoadingLangsData),
  TypedReducer<LanguagesListState, GetSubtitlesListRequestStartAction>(
      _setLoadingSubsData),
  TypedReducer<LanguagesListState, GetSubtitlesListRequestSuccessAction>(
      _setSubs),
  TypedReducer<LanguagesListState, GetSubtitlesListRequestFailureAction>(
      _setNotLoadingSubsData)
]);

LanguagesListState _setLangs(
    LanguagesListState state, GetLanguagesListRequestSuccessAction action) {
  return state.copyWith(languagesList: LanguageList(l: action.response));
}

LanguagesListState _setSubs(
    LanguagesListState state, GetSubtitlesListRequestSuccessAction action) {
  return state.copyWith(subtitlesList: LanguageList(l: action.response));
}

LanguagesListState _setLoadingLangsData(
    LanguagesListState state, dynamic action) {
  return state.copyWith(loadingLanguages: true);
}

LanguagesListState _setNotLoadingLangsData(
    LanguagesListState state, dynamic action) {
  return state.copyWith(loadingLanguages: false);
}

LanguagesListState _setLoadingSubsData(
    LanguagesListState state, dynamic action) {
  return state.copyWith(loadingSubtitles: true);
}

LanguagesListState _setNotLoadingSubsData(
    LanguagesListState state, dynamic action) {
  return state.copyWith(loadingSubtitles: false);
}
