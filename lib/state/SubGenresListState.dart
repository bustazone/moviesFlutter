import 'package:meta/meta.dart';
import 'package:pelis_busta/models/GenreList.dart';

@immutable
class SubGenresListState {
  final GenreList genresList;
  final bool loading;

  const SubGenresListState({this.genresList, this.loading});

  factory SubGenresListState.initial() =>
      new SubGenresListState(genresList: GenreList(), loading: false);

  SubGenresListState copyWith({GenreList genresList, bool loading}) {
    return new SubGenresListState(
        genresList: genresList ?? this.genresList,
        loading: loading ?? this.loading);
  }

  @override
  int get hashCode => genresList.hashCode ^ loading.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubGenresListState &&
          runtimeType == other.runtimeType &&
          genresList == other.genresList &&
          loading == other.loading;

  @override
  String toString() {
    return 'SubGenresListState{genresList: $genresList, loading: $loading}';
  }
}
