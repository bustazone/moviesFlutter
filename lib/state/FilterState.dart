import 'package:meta/meta.dart';
import 'package:pelis_busta/models/FilmFilter.dart';
import 'package:pelis_busta/models/GenreList.dart';
import 'package:pelis_busta/models/LanguageList.dart';

@immutable
class FilterState {
  final String tituloFilter;
  final String location;
  final String formato;
  final int year;
  final int minYear;
  final int maxYear;
  final String director;
  final bool series;
  final String countries;
  final String casts;
  final LanguageList idiomas;
  final LanguageList subtitulos;
  final GenreList generos;

  const FilterState(
      {this.tituloFilter,
      this.location,
      this.formato,
      this.year,
      this.minYear,
      this.maxYear,
      this.director,
      this.series,
      this.countries,
      this.casts,
      this.idiomas,
      this.subtitulos,
      this.generos});

  factory FilterState.initial() => new FilterState(
      series: false,
      idiomas: new LanguageList(),
      subtitulos: new LanguageList(),
      generos: new GenreList());

  FilterState copyWith(
      {String tituloFilter,
      String location,
      String formato,
      int year,
      int minYear,
      int maxYear,
      String director,
      String casts,
      LanguageList idiomas,
      LanguageList subtitulos,
      GenreList generos,
      bool series}) {
    return new FilterState(
        tituloFilter: tituloFilter ?? this.tituloFilter,
        location: location ?? this.location,
        formato: formato ?? this.formato,
        year: year ?? this.year,
        minYear: minYear ?? this.minYear,
        maxYear: maxYear ?? this.maxYear,
        director: director ?? this.director,
        series: series ?? this.series,
        casts: casts ?? this.casts,
        idiomas: idiomas ?? this.idiomas,
        subtitulos: subtitulos ?? this.subtitulos,
        generos: generos ?? this.generos);
  }

  @override
  int get hashCode =>
      tituloFilter.hashCode ^
      location.hashCode ^
      formato.hashCode ^
      year.hashCode ^
      minYear.hashCode ^
      maxYear.hashCode ^
      director.hashCode ^
      series.hashCode ^
      casts.hashCode ^
      idiomas.hashCode ^
      subtitulos.hashCode ^
      generos.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterState &&
          runtimeType == other.runtimeType &&
          tituloFilter == other.tituloFilter &&
          location == other.location &&
          formato == other.formato &&
          year == other.year &&
          minYear == other.minYear &&
          maxYear == other.maxYear &&
          director == other.director &&
          series == other.series &&
          casts == other.casts &&
          idiomas == other.idiomas &&
          subtitulos == other.subtitulos &&
          generos == other.generos;

  @override
  String toString() {
    return 'FilterState{'
        'tituloFilter: $tituloFilter,'
        'location: $location,'
        'formato: $formato,'
        'year: $year,'
        'minYear: $minYear,'
        'maxYear: $maxYear,'
        'director: $director,'
        'series: $series,'
        'casts: $casts,'
        'idiomas: $idiomas,'
        'subtitulos: $subtitulos,'
        'generos: $generos,'
        '}';
  }

  FilmFilter getFilmFilter() {
    return new FilmFilter(
        tituloFilter: tituloFilter ?? this.tituloFilter,
        location: location ?? this.location,
        formato: formato ?? this.formato,
        year: year ?? this.year,
        minYear: minYear ?? this.minYear,
        maxYear: maxYear ?? this.maxYear,
        director: director ?? this.director,
        serie: series ?? this.series,
        casts: casts ?? this.casts,
        idiomas: idiomas ?? this.idiomas,
        subtitulos: subtitulos ?? this.subtitulos,
        generos: generos ?? this.generos);
  }
}
