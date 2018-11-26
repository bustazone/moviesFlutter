import 'package:meta/meta.dart';
import 'package:pelis_busta/models/Film.dart';

@immutable
class FilmDetailState {
  final Film selectedFilm;
  final int selectedFilmId;
  final bool loading;

  const FilmDetailState({this.selectedFilm, this.selectedFilmId, this.loading});

  factory FilmDetailState.initial() => new FilmDetailState(
      selectedFilm: null, selectedFilmId: null, loading: false);

  FilmDetailState copyWith(
      {Film selectedFilm, int selectedFilmId, bool loading}) {
    return new FilmDetailState(
        selectedFilm: selectedFilm ?? this.selectedFilm,
        selectedFilmId: selectedFilmId ?? this.selectedFilmId,
        loading: loading ?? this.loading);
  }

  @override
  int get hashCode =>
      selectedFilm.hashCode ^ selectedFilmId.hashCode ^ loading.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilmDetailState &&
          runtimeType == other.runtimeType &&
          selectedFilm == other.selectedFilm &&
          selectedFilmId == other.selectedFilmId &&
          loading == other.loading;

  @override
  String toString() {
    return 'FilmDetailState{selectedFilm: $selectedFilm, selectedFilmId: $selectedFilmId, loading: $loading}';
  }
}
