import 'dart:convert';

import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class EditFilm {
  int peliculaId;
  String location;
  bool vista;
  String formato;
  int size;
  String imdbId;
  String filmaffinityId;
  bool serie;
  bool completed;
  String nombreArchivo;
  String comentarios;
  List<Language> idiomas = new List();
  List<Language> subtitulos = new List();

  EditFilm();

  factory EditFilm.fromString(String data) {
    Map dataConverted = json.decode(data);
    return new EditFilm.fromMap(dataConverted);
  }

  factory EditFilm.fromMap(Map dataConverted) {
    EditFilm f = new EditFilm();
    f.peliculaId = dataConverted['peliculaId'];
    f.size = dataConverted['size'];
    f.location = dataConverted['location'];
    f.vista = dataConverted['vista'];
    f.formato = dataConverted['formato'];
    f.imdbId = dataConverted['imdbId'];
    f.filmaffinityId = dataConverted['filmaffinityId'];
    f.serie = dataConverted['serie'];
    f.completed = dataConverted['completed'];
    f.nombreArchivo = dataConverted['nombreArchivo'];
    f.comentarios = dataConverted['comentarios'];
    List listIdiomas = dataConverted['idiomas'];
    List listSubtitulos = dataConverted['subtitulos'];
    if (!isNullOrEmpty(listIdiomas)) {
      for (Map i in listIdiomas) {
        f.idiomas.add(new Language.fromMap(i));
      }
    }
    if (!isNullOrEmpty(listSubtitulos)) {
      for (Map i in listSubtitulos) {
        f.subtitulos.add(new Language.fromMap(i));
      }
    }
    return f;
  }

  Map toMap() {
    Map m = new Map();
    if (peliculaId != null) {
      m.putIfAbsent('peliculaId', () => peliculaId);
    }
    if (!isNullOrEmpty(location)) {
      m.putIfAbsent('location', () => location);
    }
    if (vista != null) {
      m.putIfAbsent('vista', () => vista);
    }
    if (!isNullOrEmpty(formato)) {
      m.putIfAbsent('formato', () => formato);
    }
    if (size != null) {
      m.putIfAbsent('size', () => size);
    }
    if (!isNullOrEmpty(imdbId)) {
      m.putIfAbsent('imdbId', () => imdbId);
    }
    if (!isNullOrEmpty(filmaffinityId)) {
      m.putIfAbsent('filmaffinityId', () => filmaffinityId);
    }
    if (serie != null) {
      m.putIfAbsent('serie', () => serie);
    }
    if (completed != null) {
      m.putIfAbsent('completed', () => completed);
    }
    if (!isNullOrEmpty(nombreArchivo)) {
      m.putIfAbsent('nombreArchivo', () => nombreArchivo);
    }
    if (!isNullOrEmpty(comentarios)) {
      m.putIfAbsent('comentarios', () => comentarios);
    }
    if (!isNullOrEmpty(idiomas)) {
      List li = new List();
      for (Language i in idiomas) {
        li.add(i.toMap());
      }
      m.putIfAbsent('idiomas', () => li);
    }
    if (!isNullOrEmpty(subtitulos)) {
      List ls = new List();
      for (Language s in subtitulos) {
        ls.add(s.toMap());
      }
      m.putIfAbsent('subtitulos', () => ls);
    }
    return m;
  }

  @override
  String toString() {
    return 'Film{'
        'peliculaId: $peliculaId,'
        'size: $size,'
        'location: $location,'
        'vista: $vista,'
        'formato: $formato,'
        'imdbId: $imdbId,'
        'filmaffinityId: $filmaffinityId,'
        'serie: $serie,'
        'completed: $completed,'
        'nombreArchivo: $nombreArchivo,'
        'comentarios: $comentarios,'
        'idiomas: $idiomas,'
        'subtitulos: $subtitulos,'
        '}';
  }
}
