import 'package:pelis_busta/models/Genre.dart';
import 'package:pelis_busta/models/GenreList.dart';
import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/models/LanguageList.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class FilmFilter {
  String tituloFilter;
  String location;
  bool vista;
  String formato;
  int year;
  int minYear;
  int maxYear;
  String director;
  bool serie;
  String countries;
  String casts;
  LanguageList idiomas = new LanguageList();
  LanguageList subtitulos = new LanguageList();
  GenreList generos = new GenreList();
  int page;
  bool randomFilm = false;

  FilmFilter({
    this.tituloFilter,
    this.location,
    this.vista,
    this.formato,
    this.year,
    this.minYear,
    this.maxYear,
    this.director,
    this.serie,
    this.countries,
    this.casts,
    this.idiomas,
    this.subtitulos,
    this.generos,
  });

  Map toMap() {
    Map m = new Map();
    if (!isNullOrEmpty(tituloFilter)) {
      m.putIfAbsent('tituloFilter', () => tituloFilter);
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
    if (year != null) {
      m.putIfAbsent('year', () => year);
    }
    if (minYear != null) {
      m.putIfAbsent('minYear', () => minYear);
    }
    if (maxYear != null) {
      m.putIfAbsent('maxYear', () => maxYear);
    }
    if (!isNullOrEmpty(director)) {
      m.putIfAbsent('director', () => director);
    }
    if (serie != null) {
      m.putIfAbsent('serie', () => serie);
    }
    if (!isNullOrEmpty(countries)) {
      m.putIfAbsent('countries', () => countries);
    }
    if (!isNullOrEmpty(casts)) {
      m.putIfAbsent('casts', () => casts);
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
    if (!isNullOrEmpty(generos)) {
      List lg = new List();
      for (Genre g in generos) {
        lg.add(g.toMap());
      }
      m.putIfAbsent('generos', () => lg);
    }
    if (page != null) {
      m.putIfAbsent('page', () => page);
    }
    if (randomFilm != null) {
      m.putIfAbsent('randomFilm', () => randomFilm);
    }
    return m;
  }
}
