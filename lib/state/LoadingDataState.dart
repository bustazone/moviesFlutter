import 'package:meta/meta.dart';

@immutable
class LoadingDataState {
  final int loadingProcesses;

  const LoadingDataState({this.loadingProcesses});

  factory LoadingDataState.initial() =>
      new LoadingDataState(loadingProcesses: 0);

  LoadingDataState copyWith({int loadingProcesses}) {
    return new LoadingDataState(
        loadingProcesses: loadingProcesses ?? this.loadingProcesses);
  }

  @override
  int get hashCode => loadingProcesses.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadingDataState &&
          runtimeType == other.runtimeType &&
          loadingProcesses == other.loadingProcesses;

  @override
  String toString() {
    return 'LoadingDataState{loadingProcesses: $loadingProcesses}';
  }
}
