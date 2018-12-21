import 'dart:convert';

import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class EditFilm {
  int film_Id;
  String location;
  bool seen;
  String format;
  int size;
  String imdb_id;
  String filmaffinity_id;
  bool series;
  bool completed;
  String filename;
  String comment;
  List<Language> languages = new List();
  List<Language> subtitles = new List();

  EditFilm();

  factory EditFilm.fromString(String data) {
    Map dataConverted = json.decode(data);
    return new EditFilm.fromMap(dataConverted);
  }

  factory EditFilm.fromMap(Map dataConverted) {
    EditFilm f = new EditFilm();
    f.film_Id = dataConverted['film_Id'];
    f.size = dataConverted['size'];
    f.location = dataConverted['location'];
    f.seen = dataConverted['seen'];
    f.format = dataConverted['format'];
    f.imdb_id = dataConverted['imdb_id'];
    f.filmaffinity_id = dataConverted['filmaffinity_id'];
    f.series = dataConverted['series'];
    f.completed = dataConverted['completed'];
    f.filename = dataConverted['filename'];
    f.comment = dataConverted['comment'];
    List listIdiomas = dataConverted['languages'];
    List listSubtitulos = dataConverted['subtitles'];
    if (!isNullOrEmpty(listIdiomas)) {
      for (Map i in listIdiomas) {
        f.languages.add(new Language.fromMap(i));
      }
    }
    if (!isNullOrEmpty(listSubtitulos)) {
      for (Map i in listSubtitulos) {
        f.subtitles.add(new Language.fromMap(i));
      }
    }
    return f;
  }

  Map toMap() {
    Map m = new Map();
    if (film_Id != null) {
      m.putIfAbsent('film_id', () => film_Id);
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
    if (size != null) {
      m.putIfAbsent('size', () => size);
    }
    if (!isNullOrEmpty(imdb_id)) {
      m.putIfAbsent('imdb_id', () => imdb_id);
    }
    if (!isNullOrEmpty(filmaffinity_id)) {
      m.putIfAbsent('filmaffinity_id', () => filmaffinity_id);
    }
    if (series != null) {
      m.putIfAbsent('series', () => series);
    }
    if (completed != null) {
      m.putIfAbsent('completed', () => completed);
    }
    if (!isNullOrEmpty(filename)) {
      m.putIfAbsent('filename', () => filename);
    }
    if (!isNullOrEmpty(comment)) {
      m.putIfAbsent('comment', () => comment);
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
    return m;
  }

  @override
  String toString() {
    return 'Film{'
        'film_id: $film_Id,'
        'size: $size,'
        'location: $location,'
        'seen: $seen,'
        'format: $format,'
        'imdb_id: $imdb_id,'
        'filmaffinity_id: $filmaffinity_id,'
        'series: $series,'
        'completed: $completed,'
        'filename: $filename,'
        'comment: $comment,'
        'languages: $languages,'
        'subtitles: $subtitles,'
        '}';
  }
}
