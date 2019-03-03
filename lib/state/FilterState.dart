import 'package:meta/meta.dart';
import 'package:pelis_busta/models/FilmFilter.dart';
import 'package:pelis_busta/models/GenreList.dart';
import 'package:pelis_busta/models/LanguageList.dart';

@immutable
class FilterState {
  final String titleFilter;
  final String location;
  final String format;
  final int year;
  final int minYear;
  final int maxYear;
  final String director;
  final bool series;
  final String countries;
  final String mainCast;
  final LanguageList languages;
  final LanguageList subtitles;
  final GenreList genres;

  const FilterState(
      {this.titleFilter,
      this.location,
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
      this.genres});

  factory FilterState.initial() => new FilterState(
      titleFilter: "",
      location: "",
      format: "",
      year: null,
      minYear: null,
      maxYear: null,
      director: "",
      series: false,
      countries: "",
      mainCast: "",
      languages: new LanguageList(),
      subtitles: new LanguageList(),
      genres: new GenreList());

  FilterState copyWith(
      {String titleFilter,
      String location,
      String format,
      int year,
      int minYear,
      int maxYear,
      String director,
      String mainCast,
      LanguageList languages,
      LanguageList subtitles,
      GenreList genres,
      bool series}) {
    return new FilterState(
        titleFilter: titleFilter ?? this.titleFilter,
        location: location ?? this.location,
        format: format ?? this.format,
        year: (year != null) ? ((year > 0) ? year : null) : this.year,
        minYear:
            (minYear != null) ? ((minYear > 0) ? minYear : null) : this.minYear,
        maxYear:
            (maxYear != null) ? ((maxYear > 0) ? maxYear : null) : this.maxYear,
        director: director ?? this.director,
        series: series ?? this.series,
        mainCast: mainCast ?? this.mainCast,
        languages: languages ?? this.languages,
        subtitles: subtitles ?? this.subtitles,
        genres: genres ?? this.genres);
  }

  @override
  int get hashCode =>
      titleFilter.hashCode ^
      location.hashCode ^
      format.hashCode ^
      year.hashCode ^
      minYear.hashCode ^
      maxYear.hashCode ^
      director.hashCode ^
      series.hashCode ^
      mainCast.hashCode ^
      languages.hashCode ^
      subtitles.hashCode ^
      genres.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterState &&
          runtimeType == other.runtimeType &&
          titleFilter == other.titleFilter &&
          location == other.location &&
          format == other.format &&
          year == other.year &&
          minYear == other.minYear &&
          maxYear == other.maxYear &&
          director == other.director &&
          series == other.series &&
          mainCast == other.mainCast &&
          languages == other.languages &&
          subtitles == other.subtitles &&
          genres == other.genres;

  @override
  String toString() {
    return 'FilterState{'
        'titleFilter: $titleFilter,'
        'location: $location,'
        'format: $format,'
        'year: $year,'
        'minYear: $minYear,'
        'maxYear: $maxYear,'
        'director: $director,'
        'series: $series,'
        'mainCast: $mainCast,'
        'languages: $languages,'
        'subtitles: $subtitles,'
        'genres: $genres,'
        '}';
  }

  FilmFilter getFilmFilter() {
    return new FilmFilter(
        titleFilter: titleFilter ?? this.titleFilter,
        location: location ?? this.location,
        format: format ?? this.format,
        year: year ?? this.year,
        minYear: minYear ?? this.minYear,
        maxYear: maxYear ?? this.maxYear,
        director: director ?? this.director,
        series: series ?? this.series,
        mainCast: mainCast ?? this.mainCast,
        languages: languages ?? this.languages,
        subtitles: subtitles ?? this.subtitles,
        genres: genres ?? this.genres);
  }
}
