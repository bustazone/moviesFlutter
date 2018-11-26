import 'package:meta/meta.dart';
import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/state/EditFilmState.dart';
import 'package:pelis_busta/state/FilmDetailState.dart';
import 'package:pelis_busta/state/FilmListState.dart';
import 'package:pelis_busta/state/FilterState.dart';
import 'package:pelis_busta/state/LanguagesListState.dart';
import 'package:pelis_busta/state/LoadingDataState.dart';
import 'package:pelis_busta/state/SubGenresListState.dart';

@immutable
class AppState {
  final FilterState filter;
  final FilmListState filmList;
  final FilmDetailState filmDetail;
  final EditFilmState editFilm;
  final LanguagesListState languages;
  final SubGenresListState subGenres;
  final LoadingDataState loadingDataState;

  const AppState(
      {this.filter = const FilterState(),
      this.filmList = const FilmListState(),
      this.filmDetail = const FilmDetailState(),
      this.editFilm = const EditFilmState(),
      this.languages = const LanguagesListState(),
      this.subGenres = const SubGenresListState(),
      this.loadingDataState = const LoadingDataState()});

  factory AppState.initial() => new AppState(
      filter: FilterState.initial(),
      filmList: FilmListState.initial(),
      filmDetail: FilmDetailState.initial(),
      editFilm: EditFilmState.initial(),
      languages: LanguagesListState.initial(),
      subGenres: SubGenresListState.initial(),
      loadingDataState: LoadingDataState.initial());

  AppState copyWith(
      {FilterState filter,
      List<Film> filmList,
      FilmDetailState filmDetail,
      EditFilmState editFilm,
      LanguagesListState languages,
      SubGenresListState subGenres,
      LoadingDataState loadingDataState}) {
    return new AppState(
        filter: filter ?? this.filter,
        filmList: filmList ?? this.filmList,
        filmDetail: filmDetail ?? this.filmDetail,
        editFilm: editFilm ?? this.editFilm,
        languages: languages ?? this.languages,
        subGenres: subGenres ?? this.subGenres,
        loadingDataState: loadingDataState ?? this.loadingDataState);
  }

  @override
  int get hashCode =>
      filter.hashCode ^
      filmList.hashCode ^
      filmDetail.hashCode ^
      editFilm.hashCode ^
      languages.hashCode ^
      subGenres.hashCode ^
      loadingDataState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          filter == other.filter &&
          filmList == other.filmList &&
          filmDetail == other.filmDetail &&
          editFilm == other.editFilm &&
          languages == other.languages &&
          subGenres == other.subGenres &&
          loadingDataState == other.loadingDataState;

  @override
  String toString() {
    return 'AppState{filter: $filter, filmList: $filmList, filmDetail: $filmDetail, editFilm: $editFilm, languages: $languages, subGenres: $subGenres, loadingDataState: $loadingDataState}';
  }
}
