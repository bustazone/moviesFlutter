import 'package:pelis_busta/models/Film.dart';
import 'package:meta/meta.dart';
import 'package:pelis_busta/state/CountState.dart';
import 'package:pelis_busta/state/FilmListState.dart';
import 'package:pelis_busta/state/FilterState.dart';

@immutable
class AppState {
  final FilterState filter;
  final FilmListState filmList;

  const AppState(
      {
      this.filter = const FilterState(),
      this.filmList = const FilmListState()});

  factory AppState.initial() => new AppState(
      filter: FilterState.initial(),
      filmList: FilmListState.initial());

  AppState copyWith({
    CountState count,
    FilterState filter,
    List<Film> filmList,
  }) {
    return new AppState(
        filter: filter ?? this.filter,
        filmList: filmList ?? this.filmList);
  }

  @override
  int get hashCode => filter.hashCode ^ filmList.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          filter == other.filter &&
          filmList == other.filmList;

  @override
  String toString() {
    return 'AppState{filter: $filter, filmList: $filmList}';
  }
}
