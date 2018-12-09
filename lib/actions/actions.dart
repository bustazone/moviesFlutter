import 'package:pelis_busta/models/GenreList.dart';
import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/models/LanguageList.dart';

class SetFilterTitleStateAction {
  final String title;

  SetFilterTitleStateAction(this.title);
}

class ResetFilterTitleStateAction {}

class SetFilterDirectorStateAction {
  final String director;

  SetFilterDirectorStateAction(this.director);
}

class ResetFilterDirectorStateAction {}

class SetFilterCastStateAction {
  final String cast;

  SetFilterCastStateAction(this.cast);
}

class ResetFilterCastStateAction {}

class SetFilterLocationStateAction {
  final String location;

  SetFilterLocationStateAction(this.location);
}

class ResetFilterLocationStateAction {}

class SetFilterYearStateAction {
  final int year;

  SetFilterYearStateAction(this.year);
}

class SetFilterMinYearStateAction {
  final int year;

  SetFilterMinYearStateAction(this.year);
}

class SetFilterMaxYearStateAction {
  final int year;

  SetFilterMaxYearStateAction(this.year);
}

class ResetFilterYearsStateAction {}

class SetFilterLanguagesStateAction {
  final LanguageList languages;

  SetFilterLanguagesStateAction(this.languages);
}

class ResetFilterLanguagesStateAction {}

class SetFilterSubtitlesStateAction {
  final LanguageList subtitles;

  SetFilterSubtitlesStateAction(this.subtitles);
}

class ResetFilterSubtitlesStateAction {}

class SetFilterGenresStateAction {
  final GenreList genres;

  SetFilterGenresStateAction(this.genres);
}

class SetFilterSeriesStateAction {
  final bool series;

  SetFilterSeriesStateAction(this.series);
}

class ResetWholeFilterStateAction {}

class ResetListAction {}

class SetSelectedFilmIdStateAction {
  final int filmId;

  SetSelectedFilmIdStateAction(this.filmId);
}

//edit
class SetEditFilmLocation {
  final String location;

  SetEditFilmLocation(this.location);
}

class SetEditFilmVista {
  final bool seen;

  SetEditFilmVista(this.seen);
}

class SetEditFilmFormato {
  final String format;

  SetEditFilmFormato(this.format);
}

class SetEditFilmSize {
  final int size;

  SetEditFilmSize(this.size);
}

class SetEditFilmImdbId {
  final String imdbId;

  SetEditFilmImdbId(this.imdbId);
}

class SetEditFilmFilmaffinityId {
  final String filmaffinityId;

  SetEditFilmFilmaffinityId(this.filmaffinityId);
}

class SetEditFilmSerie {
  final bool series;

  SetEditFilmSerie(this.series);
}

class SetEditFilmCompleted {
  final bool completed;

  SetEditFilmCompleted(this.completed);
}

class SetEditFilmNombreArchivo {
  final String filename;

  SetEditFilmNombreArchivo(this.filename);
}

class SetEditFilmComentarios {
  final String comentaries;

  SetEditFilmComentarios(this.comentaries);
}

class SetEditFilmIdiomas {
  final List<Language> languages;

  SetEditFilmIdiomas(this.languages);
}

class SetEditFilmSubtitulos {
  final List<Language> subtitules;

  SetEditFilmSubtitulos(this.subtitules);
}
