import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/state/FilterState.dart';
import 'package:redux/redux.dart';

final filterReducer = combineReducers<FilterState>([
  TypedReducer<FilterState, SetFilterTitleStateAction>(_setTitle),
  TypedReducer<FilterState, ResetFilterTitleStateAction>(_resetTitle),
  TypedReducer<FilterState, SetFilterDirectorStateAction>(_setDirector),
  TypedReducer<FilterState, ResetFilterDirectorStateAction>(_resetDirector),
  TypedReducer<FilterState, SetFilterCastStateAction>(_setCast),
  TypedReducer<FilterState, ResetFilterCastStateAction>(_resetCast),
  TypedReducer<FilterState, SetFilterLocationStateAction>(_setLocation),
  TypedReducer<FilterState, ResetFilterLocationStateAction>(_resetLocation),
  TypedReducer<FilterState, SetFilterYearStateAction>(_setYear),
  TypedReducer<FilterState, SetFilterMinYearStateAction>(_setMinYear),
  TypedReducer<FilterState, SetFilterMaxYearStateAction>(_setMaxYear),
  TypedReducer<FilterState, ResetFilterYearsStateAction>(_resetYears),
  TypedReducer<FilterState, SetFilterLanguagesStateAction>(_setLanguages),
  TypedReducer<FilterState, ResetFilterLanguagesStateAction>(_resetLanguages),
  TypedReducer<FilterState, SetFilterSubtitlesStateAction>(_setSubtitles),
  TypedReducer<FilterState, ResetFilterSubtitlesStateAction>(_resetSubtitles),
  TypedReducer<FilterState, SetFilterGenresStateAction>(_setGenres),
  TypedReducer<FilterState, SetFilterSeriesStateAction>(_setSeries),
  TypedReducer<FilterState, ResetWholeFilterStateAction>(_resetWholeFilter)
]);

FilterState _setTitle(FilterState state, SetFilterTitleStateAction action) {
  return state.copyWith(titleFilter: action.title);
}

FilterState _resetTitle(FilterState state, ResetFilterTitleStateAction action) {
  return state.copyWith(titleFilter: "");
}

FilterState _setDirector(
    FilterState state, SetFilterDirectorStateAction action) {
  return state.copyWith(director: action.director);
}

FilterState _resetDirector(
    FilterState state, ResetFilterDirectorStateAction action) {
  return state.copyWith(director: "");
}

FilterState _setCast(FilterState state, SetFilterCastStateAction action) {
  return state.copyWith(mainCast: action.cast);
}

FilterState _resetCast(FilterState state, ResetFilterCastStateAction action) {
  return state.copyWith(mainCast: "");
}

FilterState _setLocation(
    FilterState state, SetFilterLocationStateAction action) {
  return state.copyWith(location: action.location);
}

FilterState _resetLocation(
    FilterState state, ResetFilterLocationStateAction action) {
  return state.copyWith(location: "");
}

FilterState _setYear(FilterState state, SetFilterYearStateAction action) {
  return state.copyWith(year: action.year);
}

FilterState _setMinYear(FilterState state, SetFilterMinYearStateAction action) {
  return state.copyWith(minYear: action.minYear);
}

FilterState _setMaxYear(FilterState state, SetFilterMaxYearStateAction action) {
  return state.copyWith(maxYear: action.maxYear);
}

FilterState _resetYears(FilterState state, ResetFilterYearsStateAction action) {
  return state.copyWith(year: 0, minYear: 0, maxYear: 0);
}

FilterState _setLanguages(
    FilterState state, SetFilterLanguagesStateAction action) {
  return state.copyWith(languages: action.languages);
}

FilterState _resetLanguages(
    FilterState state, ResetFilterLanguagesStateAction action) {
  return state.copyWith(languages: null);
}

FilterState _setSubtitles(
    FilterState state, SetFilterSubtitlesStateAction action) {
  return state.copyWith(subtitles: action.subtitles);
}

FilterState _resetSubtitles(
    FilterState state, ResetFilterSubtitlesStateAction action) {
  return state.copyWith(subtitles: null);
}

FilterState _setGenres(FilterState state, SetFilterGenresStateAction action) {
  return state.copyWith(genres: action.genres);
}

FilterState _setSeries(FilterState state, SetFilterSeriesStateAction action) {
  return state.copyWith(series: action.series);
}

FilterState _resetWholeFilter(
    FilterState state, ResetWholeFilterStateAction action) {
  return FilterState.initial();
}
