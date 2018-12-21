import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/feats/edit/EditFilmScreen.dart';
import 'package:pelis_busta/models/EditFilm.dart';
import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/models/LanguageList.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

class EditFilmScreenContainer extends StatelessWidget {
  final String title;

  EditFilmScreenContainer({Key key, this.title}) : super(key: key);

  @override
  build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: (store) {
        return ViewModel.fromStore(store);
      },
      builder: (context, vm) {
        return new EditFilmScreen(vm, title: title);
      },
    );
  }
}

class ViewModel {
  final bool showLoader;
  final LanguageList allLangs;
  final LanguageList allSubs;
  final int peliculaId;
  final String location;
  final bool vista;
  final String formato;
  final int size;
  final String imdbId;
  final String filmaffinityId;
  final bool serie;
  final bool completed;
  final String nombreArchivo;
  final String comentarios;
  final List<Language> idiomas;
  final List<Language> subtitulos;
  final Function(String) setLocation;
  final Function(bool) setVista;
  final Function(String) setFormato;
  final Function(int) setSize;
  final Function(String) setImdbId;
  final Function(String) setFilmaffinityId;
  final Function(bool) setSerie;
  final Function(bool) setCompleted;
  final Function(String) setNombreArchivo;
  final Function(String) setComentarios;
  final Function(List<Language>) setIdiomas;
  final Function(List<Language>) setSubtitulos;
  final Function(dynamic) uploadChanges;

  ViewModel(
      {@required this.showLoader,
      @required this.allLangs,
      @required this.allSubs,
      @required this.peliculaId,
      @required this.location,
      @required this.vista,
      @required this.formato,
      @required this.size,
      @required this.imdbId,
      @required this.filmaffinityId,
      @required this.serie,
      @required this.completed,
      @required this.nombreArchivo,
      @required this.comentarios,
      @required this.idiomas,
      @required this.subtitulos,
      @required this.setLocation,
      @required this.setVista,
      @required this.setFormato,
      @required this.setSize,
      @required this.setImdbId,
      @required this.setFilmaffinityId,
      @required this.setSerie,
      @required this.setCompleted,
      @required this.setNombreArchivo,
      @required this.setComentarios,
      @required this.setIdiomas,
      @required this.setSubtitulos,
      @required this.uploadChanges});

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
        showLoader: store.state.loadingDataState.loadingProcesses > 0,
        allLangs: LanguageList(l: store.state.languages.languagesList),
        allSubs: LanguageList(l: store.state.languages.subtitlesList),
        peliculaId: store.state.editFilm.editFilmData.film_Id,
        location: store.state.editFilm.editFilmData.location,
        vista: store.state.editFilm.editFilmData.seen,
        formato: store.state.editFilm.editFilmData.format,
        size: store.state.editFilm.editFilmData.size,
        imdbId: store.state.editFilm.editFilmData.imdb_id,
        filmaffinityId: store.state.editFilm.editFilmData.filmaffinity_id,
        serie: store.state.editFilm.editFilmData.series,
        completed: store.state.editFilm.editFilmData.completed,
        nombreArchivo: store.state.editFilm.editFilmData.filename,
        comentarios: store.state.editFilm.editFilmData.comment,
        idiomas: store.state.editFilm.editFilmData.languages,
        subtitulos: store.state.editFilm.editFilmData.subtitles,
        setLocation: (String v) {
          store.dispatch(SetEditFilmLocation(v));
        },
        setVista: (bool v) {
          store.dispatch(SetEditFilmVista(v));
        },
        setFormato: (String v) {
          store.dispatch(SetEditFilmFormato(v));
        },
        setSize: (int v) {
          store.dispatch(SetEditFilmSize(v));
        },
        setImdbId: (String v) {
          store.dispatch(SetEditFilmImdbId(v));
        },
        setFilmaffinityId: (String v) {
          store.dispatch(SetEditFilmFilmaffinityId(v));
        },
        setSerie: (bool v) {
          store.dispatch(SetEditFilmSerie(v));
        },
        setCompleted: (bool v) {
          store.dispatch(SetEditFilmCompleted(v));
        },
        setNombreArchivo: (String v) {
          store.dispatch(SetEditFilmNombreArchivo(v));
        },
        setComentarios: (String v) {
          store.dispatch(SetEditFilmComentarios(v));
        },
        setIdiomas: (List<Language> v) {
          store.dispatch(SetEditFilmIdiomas(v));
        },
        setSubtitulos: (List<Language> v) {
          store.dispatch(SetEditFilmSubtitulos(v));
        },
        uploadChanges: (onSuccessFinal) {
          print(json.encode(store.state.editFilm.editFilmData.toMap()));
          EditFilm ef = store.state.editFilm.editFilmData;
          store.dispatch(updateFilmRequest(ef, onSuccess: () {
            print("after update");
//            store.dispatch(getFilmDetailRequest(ef.peliculaId, onSuccess: (response) {
//              print("done update");
//            }));
            store.dispatch(
                getFilmDetailRequest(ef.film_Id, onSuccess: onSuccessFinal));
          }));
        });
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewModel &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          allLangs == other.allLangs &&
          allSubs == other.allSubs &&
          peliculaId == other.peliculaId &&
          location == other.location &&
          vista == other.vista &&
          formato == other.formato &&
          size == other.size &&
          imdbId == other.imdbId &&
          filmaffinityId == other.filmaffinityId &&
          serie == other.serie &&
          completed == other.completed &&
          nombreArchivo == other.nombreArchivo &&
          comentarios == other.comentarios &&
          idiomas == other.idiomas &&
          subtitulos == other.subtitulos;

  @override
  int get hashCode =>
      showLoader.hashCode ^
      allLangs.hashCode ^
      allSubs.hashCode ^
      peliculaId.hashCode ^
      location.hashCode ^
      vista.hashCode ^
      formato.hashCode ^
      size.hashCode ^
      imdbId.hashCode ^
      filmaffinityId.hashCode ^
      serie.hashCode ^
      completed.hashCode ^
      nombreArchivo.hashCode ^
      comentarios.hashCode ^
      idiomas.hashCode ^
      subtitulos.hashCode;
}
