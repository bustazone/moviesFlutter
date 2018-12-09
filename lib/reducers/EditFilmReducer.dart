import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/models/EditFilm.dart';
import 'package:pelis_busta/state/EditFilmState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

final editFilmReducer = combineReducers<EditFilmState>([
  TypedReducer<EditFilmState, GetFilmRequestSuccessAction>(_setFilmData),
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
  ef.editFilmData.vista = action.seen;
  return ef;
}

EditFilmState _setFormato(EditFilmState state, SetEditFilmFormato action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.formato = action.format;
  return ef;
}

EditFilmState _setSize(EditFilmState state, SetEditFilmSize action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.size = action.size;
  return ef;
}

EditFilmState _setImdbId(EditFilmState state, SetEditFilmImdbId action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.imdbId = action.imdbId;
  return ef;
}

EditFilmState _setFilmaffinityId(
    EditFilmState state, SetEditFilmFilmaffinityId action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.filmaffinityId = action.filmaffinityId;
  return ef;
}

EditFilmState _setSerie(EditFilmState state, SetEditFilmSerie action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.serie = action.series;
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
  ef.editFilmData.nombreArchivo = action.filename;
  return ef;
}

EditFilmState _setComentarios(
    EditFilmState state, SetEditFilmComentarios action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.comentarios = action.comentaries;
  return ef;
}

EditFilmState _setIdiomas(EditFilmState state, SetEditFilmIdiomas action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.idiomas = action.languages;
  return ef;
}

EditFilmState _setSubtitulos(
    EditFilmState state, SetEditFilmSubtitulos action) {
  EditFilmState ef = state.copyWith();
  ef.editFilmData.subtitulos = action.subtitules;
  return ef;
}

EditFilmState _setFilmData(
    EditFilmState state, GetFilmRequestSuccessAction action) {
  EditFilm data;
  if (action.response != null && action.response.length > 0) {
    data = EditFilm();
    data.peliculaId = action.response[0].peliculaId;
    data.location = action.response[0].location;
    data.vista = action.response[0].vista;
    data.formato = action.response[0].formato;
    data.size = action.response[0].size;
    data.imdbId = action.response[0].imdbId;
    data.filmaffinityId = action.response[0].filmaffinityId;
    data.serie = action.response[0].serie;
    data.completed = action.response[0].completed;
    data.nombreArchivo = action.response[0].nombreArchivo;
    data.comentarios = action.response[0].comentarios;
    data.idiomas = action.response[0].idiomas;
    data.subtitulos = action.response[0].subtitulos;
  }
  return state.copyWith(editFilmData: data);
}
