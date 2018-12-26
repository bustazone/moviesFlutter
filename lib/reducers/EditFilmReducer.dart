import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/models/EditFilm.dart';
import 'package:pelis_busta/state/EditFilmState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

final editFilmReducer = combineReducers<EditFilmState>([
  TypedReducer<EditFilmState, GetFilmRequestSuccessAction>(_setFilmData),
  TypedReducer<EditFilmState, GetRandomFilmFilteredRequestSuccessAction>(
      _setFilmData),
  TypedReducer<EditFilmState, SetEditFilmLocation>(_setLocation),
  TypedReducer<EditFilmState, SetEditFilmVista>(_setVista),
  TypedReducer<EditFilmState, SetEditFilmFormato>(_setFormato),
  TypedReducer<EditFilmState, SetEditFilmSize>(_setSize),
  TypedReducer<EditFilmState, SetEditFilmImdbId>(_setImdbId),
  TypedReducer<EditFilmState, SetEditFilmFilmaffinityId>(_setFilmaffinityId),
  TypedReducer<EditFilmState, SetEditFilmSerie>(_setSerie),
  TypedReducer<EditFilmState, SetEditFilmCompleted>(_setComplete),
  TypedReducer<EditFilmState, SetEditFilmNombreArchivo>(_setNombreArchivo),
  TypedReducer<EditFilmState, SetEditFilmComentarios>(_setComentarios),
  TypedReducer<EditFilmState, SetEditFilmIdiomas>(_setIdiomas),
  TypedReducer<EditFilmState, SetEditFilmSubtitulos>(_setSubtitulos),
]);

EditFilmState _setLocation(EditFilmState state, SetEditFilmLocation action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.location = action.location;
  return ef;
}

EditFilmState _setVista(EditFilmState state, SetEditFilmVista action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.seen = action.seen;
  return ef;
}

EditFilmState _setFormato(EditFilmState state, SetEditFilmFormato action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.format = action.format;
  return ef;
}

EditFilmState _setSize(EditFilmState state, SetEditFilmSize action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.size = action.size;
  return ef;
}

EditFilmState _setImdbId(EditFilmState state, SetEditFilmImdbId action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.imdb_id = action.imdbId;
  return ef;
}

EditFilmState _setFilmaffinityId(
    EditFilmState state, SetEditFilmFilmaffinityId action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.filmaffinity_id = action.filmaffinityId;
  return ef;
}

EditFilmState _setSerie(EditFilmState state, SetEditFilmSerie action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.series = action.series;
  return ef;
}

EditFilmState _setComplete(EditFilmState state, SetEditFilmCompleted action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.completed = action.completed;
  return ef;
}

EditFilmState _setNombreArchivo(
    EditFilmState state, SetEditFilmNombreArchivo action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.filename = action.filename;
  return ef;
}

EditFilmState _setComentarios(
    EditFilmState state, SetEditFilmComentarios action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.comment = action.comentaries;
  return ef;
}

EditFilmState _setIdiomas(EditFilmState state, SetEditFilmIdiomas action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.languages = action.languages;
  return ef;
}

EditFilmState _setSubtitulos(
    EditFilmState state, SetEditFilmSubtitulos action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.subtitles = action.subtitules;
  return ef;
}

EditFilmState _setFilmData(EditFilmState state, dynamic action) {
  EditFilm data;
  if (action.response != null && action.response.length > 0) {
    data = EditFilm();
    data.film_Id = action.response[0].filmId;
    data.location = action.response[0].location;
    data.seen = action.response[0].seen;
    data.format = action.response[0].format;
    data.size = action.response[0].size;
    data.imdb_id = action.response[0].imdbId;
    data.filmaffinity_id = action.response[0].filmaffinityId;
    data.series = action.response[0].series;
    data.completed = action.response[0].completed;
    data.filename = action.response[0].filename;
    data.comment = action.response[0].comment;
    data.languages = action.response[0].languages;
    data.subtitles = action.response[0].subtitles;
  }
  return state.copyWith(editFilmData: data);
}
