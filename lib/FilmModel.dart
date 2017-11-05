import 'dart:collection';
import 'dart:convert';
import 'package:pelis_busta/Utils.dart';

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
  LanguageList idiomas;
  LanguageList subtitulos;
  GenderList generos;
  int page;
  bool randomFilm;

  FilmFilter() {
    idiomas = new LanguageList();
    subtitulos = new LanguageList();
    generos = new GenderList();
  }

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
      for (Gender g in generos) {
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

class LanguageList extends ListBase<Language> {
  final List<Language> l = [];
  LanguageList();

  set length(int newLength) { l.length = newLength; }
  int get length => l.length;
  Language operator [](int index) => l[index];
  void operator []=(int index, Language value) { l[index] = value; }

  void removeByValues(Language lang) {
    for(Language langList in l) {
      if (langList.equals(lang)) {
        l.remove(langList);
        return;
      }
    }
  }

  bool hasByValues(Language lang) {
    for(Language langList in l) {
      if (langList.equals(lang)) {
        return true;
      }
    }
    return false;
  }
}

class GenderList extends ListBase<Gender> {
  final List<Gender> l = [];
  GenderList();

  set length(int newLength) { l.length = newLength; }
  int get length => l.length;
  Gender operator [](int index) => l[index];
  void operator []=(int index, Gender value) { l[index] = value; }

  void removeByValues(Gender g) {
    for(Gender gList in l) {
      if (gList.equals(g)) {
        l.remove(gList);
        return;
      }
    }
  }

  bool hasByValues(Gender g) {
    for(Gender gList in l) {
      if (gList.equals(g)) {
        return true;
      }
    }
    return false;
  }
}

class Response<T> {
  String code;
  String message;
  int rowCount;
  List<T> items = new List();

  static Response<Film> fromResponseFilmString(String data) {
    var response = new Response<Film>();
    Map dataConverted = JSON.decode(data);
    response.code = dataConverted['code'];
    response.message = dataConverted['message'];
    response.rowCount = dataConverted['rowCount'];
    List listItems = dataConverted['items'];
    for (Map i in listItems) {
      response.items.add(new Film.fromMap(i));
    }
    return response;
  }
}

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
  bool serie;
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
  List<Gender> generos = new List();

  Film();

  factory Film.fromString(String data) {
    Map dataConverted = JSON.decode(data);
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
    f.serie = dataConverted['serie'];
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
        f.generos.add(new Gender.fromMap(i));
      }
    }
    return f;
  }
}

class Language {
  String codigo;
  String nombre;

  Language();

  factory Language.fromString(String data) {
    Map dataConverted = JSON.decode(data);
    return new Language.fromMap(dataConverted);
  }

  factory Language.fromMap(Map dataConverted) {
    Language l = new Language();
    l.codigo = dataConverted['codigo'];
    l.nombre = dataConverted['nombre'];
    return l;
  }

  Map toMap() {
    Map m = new Map();
    if (!isNullOrEmpty(codigo)) {
      m.putIfAbsent('codigo', () => codigo);
    }
    if (!isNullOrEmpty(nombre)) {
      m.putIfAbsent('nombre', () => nombre);
    }
    return m;
  }

  bool equals (Language lang) {
    if (this.nombre != null && (lang.nombre == null || this.nombre!=lang.nombre)) {
        return false;
    }
    if (this.codigo != null && (lang.codigo == null || this.codigo!=lang.codigo)) {
      return false;
    }
    return true;
  }
}

class Gender {

  static const int GENDER_ACTION_CODE = 3;
  static const int GENDER_ADVENTURE_CODE = 24;
  static const int GENDER_ANIMATION_CODE = 20;
  static const int GENDER_BELIC_CODE = 45;
  static const int GENDER_COMEDY_CODE = 9;
  static const int GENDER_DOCU_CODE = 188;
  static const int GENDER_DRAMA_CODE = 8;
  static const int GENDER_FANTASTIC_CODE = 14;
  static const int GENDER_HORROR_CODE = 4;
  static const int GENDER_KIDS_CODE = 74;
  static const int GENDER_MUSICAL_CODE = 129;
  static const int GENDER_NOIR_CODE = 186;
  static const int GENDER_ROMANCE_CODE = 30;
  static const int GENDER_SCIFI_CODE = 49;
  static const int GENDER_SUSPENSE_CODE = 15;
  static const int GENDER_THRILLER_CODE = 2;
  static const int GENDER_WESTERN_CODE = 109;


  int id;
  String nombre;
  String tipo;

  Gender({this.id, this.nombre, this.tipo});

  factory Gender.fromString(String data) {
    Map dataConverted = JSON.decode(data);
    return new Gender.fromMap(dataConverted);
  }

  factory Gender.fromMap(Map dataConverted) {
    Gender g = new Gender();
    g.id = dataConverted['id'];
    g.nombre = dataConverted['nombre'];
    g.tipo = dataConverted['tipo'];
    return g;
  }

  Map toMap() {
    Map m = new Map();
    if (id != null) {
      m.putIfAbsent('id', () => id);
    }
    if (!isNullOrEmpty(nombre)) {
      m.putIfAbsent('nombre', () => nombre);
    }
    if (!isNullOrEmpty(tipo)) {
      m.putIfAbsent('tipo', () => tipo);
    }
    return m;
  }

  bool equals (Gender g) {
    if (this.nombre != null && (g.nombre == null || this.nombre!=g.nombre)) {
      return false;
    }
    if (this.id != null && (g.id == null || this.id!=g.id)) {
      return false;
    }
    if (this.tipo != null && (g.tipo == null || this.tipo!=g.tipo)) {
      return false;
    }
    return true;
  }
}
