import 'package:pelis_busta/FilmModel.dart';

class MainFilter {
  static final MainFilter _mainFilter = new MainFilter._internal();

  FilmFilter filter;

  factory MainFilter() {
    return _mainFilter;
  }

  MainFilter._internal() {
    filter = new FilmFilter();
  }

  resetFilter() {
    filter = new FilmFilter();
  }

  toMap() {
    return filter.toMap();
  }
}