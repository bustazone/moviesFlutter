import 'package:meta/meta.dart';
import 'package:pelis_busta/models/Film.dart';

@immutable
class FilmListState {
  final List<Film> filmList;
  final int page;
  final bool couldQueryMore;
  final bool loading;

  const FilmListState(
      {this.filmList, this.page, this.couldQueryMore, this.loading});

  factory FilmListState.initial() => new FilmListState(
      filmList: const <Film>[], page: 0, couldQueryMore: true, loading: false);

  FilmListState copyWith(
      {List<Film> filmList, int page, bool couldQueryMore, bool loading}) {
    return new FilmListState(
        filmList: filmList ?? this.filmList,
        page: page ?? this.page,
        couldQueryMore: couldQueryMore ?? this.couldQueryMore,
        loading: loading ?? this.loading);
  }

  @override
  int get hashCode => filmList.hashCode ^ page.hashCode ^ loading.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilmListState &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          filmList == other.filmList &&
          loading == other.loading;

  @override
  String toString() {
    return 'FilmListState{filmList: $filmList, page: $page, loading: $loading}';
  }
}
