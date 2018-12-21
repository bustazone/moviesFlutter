import 'dart:convert';

import 'package:pelis_busta/models/Genre.dart';
import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class Film {
  int filmId;
  String title;
  int size;
  String location;
  bool seen;
  String format;
  int year;
  String director;
  String imdbId;
  String filmaffinityId;
  String originalTitle;
  String comment;
  bool series;
  bool completed;
  String filename;
  double punctFilmaffinity;
  double punctImdb;
  int duration;
  String countries;
  String mainCast;
  String plot;
  String imageUrl;
  String languagesStr;
  String subtitlesStr;
  String genresStr;
  double punctuation;
  List<Language> languages = new List();
  List<Language> subtitles = new List();
  List<Genre> genres = new List();

  Film();

  factory Film.fromString(String data) {
    Map dataConverted = json.decode(data);
    return new Film.fromMap(dataConverted);
  }

  factory Film.fromMap(Map dataConverted) {
    Film f = new Film();
    f.filmId = dataConverted['film_id'];
    f.title = dataConverted['title'];
    f.size = dataConverted['size'];
    f.location = dataConverted['location'];
    f.seen = dataConverted['seen'];
    f.format = dataConverted['format'];
    f.year = dataConverted['year'];
    f.director = dataConverted['director'];
    f.imdbId = dataConverted['imdb_id'];
    f.filmaffinityId = dataConverted['filmaffinity_id'];
    f.originalTitle = dataConverted['original_title'];
    f.comment = dataConverted['comment'];
    f.series = dataConverted['series'];
    f.completed = dataConverted['completed'];
    f.filename = dataConverted['filename'];
    f.punctFilmaffinity = dataConverted['punct_filmaffinity'];
    f.punctImdb = dataConverted['punct_imdb'];
    f.duration = dataConverted['duration'];
    f.countries = dataConverted['countries'];
    f.mainCast = dataConverted['main_cast'];
    f.plot = dataConverted['plot'];
    f.imageUrl = dataConverted['image_url'];
    f.languagesStr = dataConverted['languages_str'];
    f.subtitlesStr = dataConverted['subtitles_str'];
    f.genresStr = dataConverted['genres_str'];
    f.punctuation = dataConverted['punctuation'];
    List listIdiomas = dataConverted['languages'];
    List listSubtitulos = dataConverted['subtitles'];
    List listGeneros = dataConverted['genres'];
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
    if (!isNullOrEmpty(listGeneros)) {
      for (Map i in listGeneros) {
        f.genres.add(new Genre.fromMap(i));
      }
    }
    return f;
  }

  @override
  String toString() {
    return 'Film{'
        'film_id: $filmId,'
        'title: $title,'
        'size: $size,'
        'location: $location,'
        'seen: $seen,'
        'format: $format,'
        'year: $year,'
        'director: $director,'
        'imdb_id: $imdbId,'
        'filmaffinity_id: $filmaffinityId,'
        'original_title: $originalTitle,'
        'comment: $comment,'
        'series: $series,'
        'completed: $completed,'
        'filename: $filename,'
        'punct_filmaffinity: $punctFilmaffinity,'
        'punct_imdb: $punctImdb,'
        'duration: $duration,'
        'countries: $countries,'
        'main_cast: $mainCast,'
        'plot: $plot,'
        'image_url: $imageUrl,'
        'languages_str: $languagesStr,'
        'subtitles_str: $subtitlesStr,'
        'genres_str: $genresStr,'
        'punctuation: $punctuation,'
        'languages: $languages,'
        'subtitles: $subtitles,'
        'genres: $genres,'
        '}';
  }
}
