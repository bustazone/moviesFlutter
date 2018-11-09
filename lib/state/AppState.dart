import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/models/FilmFilter.dart';
import 'package:meta/meta.dart';
import 'package:pelis_busta/state/CountState.dart';
import 'package:pelis_busta/state/FilterState.dart';

@immutable
class AppState {
  final CountState count;
  final FilterState filter;

  const AppState(
      {
        this.count = const CountState(),
        this.filter = const FilterState()
      });

  factory AppState.initial() => new AppState();

  AppState copyWith({
    CountState count,
    FilterState filter,
  }) {
    return new AppState(
        count: count ?? this.count,
        filter: filter ?? this.filter
    );
  }

  @override
  int get hashCode =>
      count.hashCode ^
      filter.hashCode ;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              count == other.count &&
              filter == other.filter;

  @override
  String toString() {
    return 'AppState{count: $count, filter: $filter}';
  }
}