import 'package:pelis_busta/models/Film.dart';
import 'package:meta/meta.dart';
import 'package:pelis_busta/state/FilmDetailState.dart';
import 'package:pelis_busta/state/FilmListState.dart';
import 'package:pelis_busta/state/FilterState.dart';
import 'package:pelis_busta/state/LoadingDataState.dart';

@immutable
class AppState {
  final FilterState filter;
  final FilmListState filmList;
  final FilmDetailState filmDetail;
  final LoadingDataState loadingDataState;

  const AppState(
      {this.filter = const FilterState(),
      this.filmList = const FilmListState(),
      this.filmDetail = const FilmDetailState(),
      this.loadingDataState = const LoadingDataState()});

  factory AppState.initial() => new AppState(
      filter: FilterState.initial(),
      filmList: FilmListState.initial(),
      filmDetail: FilmDetailState.initial(),
      loadingDataState: LoadingDataState.initial());

  AppState copyWith({
    FilterState filter,
    List<Film> filmList,
    FilmDetailState filmDetail,
    LoadingDataState loadingDataState
  }) {
    return new AppState(
        filter: filter ?? this.filter,
        filmList: filmList ?? this.filmList,
        filmDetail: filmDetail ?? this.filmDetail,
        loadingDataState: loadingDataState ?? this.loadingDataState);
  }

  @override
  int get hashCode => filter.hashCode ^ filmList.hashCode ^ filmDetail.hashCode ^ loadingDataState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          filter == other.filter &&
          filmList == other.filmList &&
          filmDetail == other.filmDetail &&
          loadingDataState == other.loadingDataState;

  @override
  String toString() {
    return 'AppState{filter: $filter, filmList: $filmList, filmDetail: $filmDetail, loadingDataState: $loadingDataState}';
  }
}
