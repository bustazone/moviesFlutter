import 'package:pelis_busta/models/Genre.dart';
import 'package:pelis_busta/models/GenreList.dart';
import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/models/LanguageList.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class FilmFilter {
  String titleFilter;
  String location;
  bool seen;
  String format;
  int year;
  int minYear;
  int maxYear;
  String director;
  bool series;
  String countries;
  String mainCast;
  LanguageList languages = new LanguageList();
  LanguageList subtitles = new LanguageList();
  GenreList genres = new GenreList();
  int page;
  bool randomFilm = false;

  FilmFilter(
      {this.titleFilter,
      this.location,
      this.seen,
      this.format,
      this.year,
      this.minYear,
      this.maxYear,
      this.director,
      this.series,
      this.countries,
      this.mainCast,
      this.languages,
      this.subtitles,
      this.genres,
      this.page,
      this.randomFilm});

  Map toMap() {
    Map m = new Map();
    if (!isNullOrEmpty(titleFilter)) {
      m.putIfAbsent('titleFilter', () => titleFilter);
    }
    if (!isNullOrEmpty(location)) {
      m.putIfAbsent('location', () => location);
    }
    if (seen != null) {
      m.putIfAbsent('seen', () => seen);
    }
    if (!isNullOrEmpty(format)) {
      m.putIfAbsent('format', () => format);
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
    if (series != null && series == true) {
      m.putIfAbsent('series', () => series);
    }
    if (!isNullOrEmpty(countries)) {
      m.putIfAbsent('countries', () => countries);
    }
    if (!isNullOrEmpty(mainCast)) {
      m.putIfAbsent('main_cast', () => mainCast);
    }
    if (!isNullOrEmpty(languages)) {
      List li = new List();
      for (Language i in languages) {
        li.add(i.toMap());
      }
      m.putIfAbsent('languages', () => li);
    }
    if (!isNullOrEmpty(subtitles)) {
      List ls = new List();
      for (Language s in subtitles) {
        ls.add(s.toMap());
      }
      m.putIfAbsent('subtitles', () => ls);
    }
    if (!isNullOrEmpty(genres)) {
      List lg = new List();
      for (Genre g in genres) {
        lg.add(g.toMap());
      }
      m.putIfAbsent('genres', () => lg);
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
