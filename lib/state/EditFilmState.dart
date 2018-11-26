import 'package:meta/meta.dart';
import 'package:pelis_busta/models/EditFilm.dart';

@immutable
class EditFilmState {
  final EditFilm editFilmData;

  const EditFilmState({this.editFilmData});

  factory EditFilmState.initial() => new EditFilmState(editFilmData: null);

  EditFilmState copyWith({EditFilm editFilmData}) {
    return new EditFilmState(editFilmData: editFilmData ?? this.editFilmData);
  }

  @override
  int get hashCode => editFilmData.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditFilmState &&
          runtimeType == other.runtimeType &&
          editFilmData == other.editFilmData;

  @override
  String toString() {
    return 'EditFilmState{editFilmData: $editFilmData}';
  }
}
