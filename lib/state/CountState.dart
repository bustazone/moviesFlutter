import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/models/FilmFilter.dart';
import 'package:meta/meta.dart';

@immutable
class CountState {
  final int count;

  const CountState(
      {
        this.count
      });

  factory CountState.initial() => new CountState(count: 2);

  CountState copyWith({
    int count
  }) {
    return new CountState(
        count: count ?? this.count
    );
  }

  @override
  int get hashCode =>
      count.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CountState &&
              runtimeType == other.runtimeType &&
              count == other.count;

  @override
  String toString() {
    return 'CountState{count: $count}';
  }
}