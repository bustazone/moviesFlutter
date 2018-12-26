import 'package:flutter/material.dart';
import 'package:pelis_busta/navigation/OnNavigateRouteCustom/CustomNavigator.dart';

navigateToFilmList(context) {
  Navigator.of(context).pushNamed(FilmListRouteName);
}
