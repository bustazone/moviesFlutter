import 'dart:convert';

import 'package:pelis_busta/models/Genre.dart';
import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class Film {
  int peliculaId;
  String titulo;
  int size;
  String location;
  bool vista;
  String formato;
  int year;
  String director;
  String imdbId;
  String filmaffinityId;
  String tituloOriginal;
  String comentarios;
  bool serie;
  bool completed;
  String nombreArchivo;
  double punctFilmaffinity;
  double punctImdb;
  int duracion;
  String countries;
  String casts;
  String plot;
  String imageUrl;
  String idiomasStr;
  String subtitulosStr;
  String generosStr;
  double punctuation;
  List<Language> idiomas = new List();
  List<Language> subtitulos = new List();
  List<Genre> generos = new List();

  Film();

  factory Film.fromString(String data) {
    Map dataConverted = json.decode(data);
    return new Film.fromMap(dataConverted);
  }

  factory Film.fromMap(Map dataConverted) {
    Film f = new Film();
    f.peliculaId = dataConverted['peliculaId'];
    f.titulo = dataConverted['titulo'];
    f.size = dataConverted['size'];
    f.location = dataConverted['location'];
    f.vista = dataConverted['vista'];
    f.formato = dataConverted['formato'];
    f.year = dataConverted['year'];
    f.director = dataConverted['director'];
    f.imdbId = dataConverted['imdbId'];
    f.filmaffinityId = dataConverted['filmaffinityId'];
    f.tituloOriginal = dataConverted['tituloOriginal'];
    f.comentarios = dataConverted['comentarios'];
    f.serie = dataConverted['serie'];
    f.completed = dataConverted['completed'];
    f.nombreArchivo = dataConverted['nombreArchivo'];
    f.punctFilmaffinity = dataConverted['punctFilmaffinity'];
    f.punctImdb = dataConverted['punctImdb'];
    f.duracion = dataConverted['duracion'];
    f.countries = dataConverted['countries'];
    f.casts = dataConverted['casts'];
    f.plot = dataConverted['plot'];
    f.imageUrl = dataConverted['imageUrl'];
    f.idiomasStr = dataConverted['idiomasStr'];
    f.subtitulosStr = dataConverted['subtitulosStr'];
    f.generosStr = dataConverted['generosStr'];
    f.punctuation = dataConverted['punctuation'];
    List listIdiomas = dataConverted['idiomas'];
    List listSubtitulos = dataConverted['subtitulos'];
    List listGeneros = dataConverted['generos'];
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
    if (!isNullOrEmpty(listGeneros)) {
      for (Map i in listGeneros) {
        f.generos.add(new Genre.fromMap(i));
      }
    }
    return f;
  }

  @override
  String toString() {
    return 'Film{'
        'peliculaId: $peliculaId,'
        'titulo: $titulo,'
        'size: $size,'
        'location: $location,'
        'vista: $vista,'
        'formato: $formato,'
        'year: $year,'
        'director: $director,'
        'imdbId: $imdbId,'
        'filmaffinityId: $filmaffinityId,'
        'tituloOriginal: $tituloOriginal,'
        'comentarios: $comentarios,'
        'serie: $serie,'
        'completed: $completed,'
        'nombreArchivo: $nombreArchivo,'
        'punctFilmaffinity: $punctFilmaffinity,'
        'punctImdb: $punctImdb,'
        'duracion: $duracion,'
        'countries: $countries,'
        'casts: $casts,'
        'plot: $plot,'
        'imageUrl: $imageUrl,'
        'idiomasStr: $idiomasStr,'
        'subtitulosStr: $subtitulosStr,'
        'generosStr: $generosStr,'
        'punctuation: $punctuation,'
        'idiomas: $idiomas,'
        'subtitulos: $subtitulos,'
        'generos: $generos,'
        '}';
  }
}
