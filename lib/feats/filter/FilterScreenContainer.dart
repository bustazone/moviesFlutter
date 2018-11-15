import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/feats/filter/FilterScreen.dart';
import 'package:pelis_busta/models/GenreList.dart';
import 'package:pelis_busta/models/LanguageList.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:redux/redux.dart';

class FilterScreenContainer extends StatelessWidget {
  final String title;
  final FilterStates currentState;

  FilterScreenContainer(this.currentState, {Key key, this.title})
      : super(key: key);

  factory FilterScreenContainer.main({Key key, String title}) {
    return new FilterScreenContainer(
      FilterStates.FilterSelector,
      title: title,
    );
  }

  @override
  build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: (store) {
        return ViewModel.fromStore(store);
      },
      builder: (context, vm) {
        return new FilterScreen(currentState, vm, title: title);
      },
    );
  }
}

class ViewModel {
  final Function(String) setTitle;
  final Function() resetTitle;
  final Function(String) setDirector;
  final Function() resetDirector;
  final Function(String) setCast;
  final Function() resetCast;
  final Function(String) setLocation;
  final Function() resetLocation;
  final Function(int) setYear;
  final Function(int) setMaxYear;
  final Function(int) setMinYear;
  final Function() resetYears;
  final Function(LanguageList) setLanguages;
  final Function() resetLanguages;
  final Function(LanguageList) setSubtitles;
  final Function() resetSubtitles;
  final Function(GenreList) setGenres;
  final Function(bool) setSeries;
  final Function() resetFilter;

  final String title;
  final String director;
  final String cast;
  final String location;
  final int year;
  final int minYear;
  final int maxYear;
  final LanguageList languages;
  final LanguageList subtitles;
  final GenreList genres;
  final bool series;

  ViewModel({
    @required this.setTitle,
    @required this.resetTitle,
    @required this.setDirector,
    @required this.resetDirector,
    @required this.setCast,
    @required this.resetCast,
    @required this.setLocation,
    @required this.resetLocation,
    @required this.setYear,
    @required this.setMaxYear,
    @required this.setMinYear,
    @required this.resetYears,
    @required this.setLanguages,
    @required this.resetLanguages,
    @required this.setSubtitles,
    @required this.resetSubtitles,
    @required this.setGenres,
    @required this.setSeries,
    @required this.resetFilter,
    @required this.title,
    @required this.director,
    @required this.cast,
    @required this.location,
    @required this.year,
    @required this.minYear,
    @required this.maxYear,
    @required this.languages,
    @required this.subtitles,
    @required this.genres,
    @required this.series,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
        setTitle: (title) {
          store.dispatch(SetFilterTitleStateAction(title));
        },
        resetTitle: () {
          store.dispatch(ResetFilterTitleStateAction());
        },
        setDirector: (director) {
          store.dispatch(SetFilterDirectorStateAction(director));
        },
        resetDirector: () {
          store.dispatch(ResetFilterDirectorStateAction());
        },
        setCast: (cast) {
          store.dispatch(SetFilterCastStateAction(cast));
        },
        resetCast: () {
          store.dispatch(ResetFilterCastStateAction());
        },
        setLocation: (location) {
          store.dispatch(SetFilterLocationStateAction(location));
        },
        resetLocation: () {
          store.dispatch(ResetFilterLocationStateAction());
        },
        setYear: (year) {
          store.dispatch(SetFilterYearStateAction(year));
        },
        setMinYear: (minYear) {
          store.dispatch(SetFilterMinYearStateAction(minYear));
        },
        setMaxYear: (maxYear) {
          store.dispatch(SetFilterMaxYearStateAction(maxYear));
        },
        resetYears: () {
          store.dispatch(ResetFilterYearsStateAction());
        },
        setLanguages: (languages) {
          store.dispatch(SetFilterLanguagesStateAction(languages));
        },
        resetLanguages: () {
          store.dispatch(ResetFilterLanguagesStateAction());
        },
        setSubtitles: (subtitles) {
          store.dispatch(SetFilterSubtitlesStateAction(subtitles));
        },
        resetSubtitles: () {
          store.dispatch(ResetFilterSubtitlesStateAction());
        },
        setGenres: (genres) {
          store.dispatch(SetFilterGenresStateAction(genres));
        },
        setSeries: (isSeries) {
          store.dispatch(SetFilterSeriesStateAction(isSeries));
        },
        resetFilter: () {
          store.dispatch(ResetWholeFilterStateAction());
        },
        title: store.state.filter.tituloFilter,
        director: store.state.filter.director,
        cast: store.state.filter.casts,
        location: store.state.filter.location,
        year: store.state.filter.year,
        minYear: store.state.filter.minYear,
        maxYear: store.state.filter.maxYear,
        languages: store.state.filter.idiomas,
        subtitles: store.state.filter.subtitulos,
        genres: store.state.filter.generos,
        series: store.state.filter.series);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          director == other.director &&
          cast == other.cast &&
          location == other.location &&
          year == other.year &&
          minYear == other.minYear &&
          maxYear == other.maxYear &&
          languages == other.languages &&
          subtitles == other.subtitles &&
          genres == other.genres &&
          series == other.series;

  @override
  int get hashCode =>
      title.hashCode ^
      director.hashCode ^
      cast.hashCode ^
      location.hashCode ^
      year.hashCode ^
      minYear.hashCode ^
      maxYear.hashCode ^
      languages.hashCode ^
      subtitles.hashCode ^
      genres.hashCode ^
      series.hashCode;
}
