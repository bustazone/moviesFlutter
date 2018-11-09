import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/models/FilmFilter.dart';
import 'package:meta/meta.dart';
import 'package:pelis_busta/state/CountState.dart';

@immutable
class FilterState {
  final bool series;

  const FilterState(
      {
        this.series = false
      });

  factory FilterState.initial() => new FilterState();

  FilterState copyWith({
    bool series
  }) {
    return new FilterState(
        series: series ?? this.series
    );
  }

  @override
  int get hashCode =>
      series.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FilterState &&
              runtimeType == other.runtimeType &&
              series == other.series;

  @override
  String toString() {
    return 'AppState{series: $series}';
  }
}