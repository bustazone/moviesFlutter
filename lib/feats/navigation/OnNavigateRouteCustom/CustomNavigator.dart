import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filter/FilterScreen.dart';
import 'package:pelis_busta/feats/filter/FilterScreenContainer.dart';
import 'package:pelis_busta/feats/home/HomeScreen.dart';
import 'package:pelis_busta/feats/list/ListScreenContainer.dart';
import 'package:pelis_busta/feats/navigation/OnNavigateRouteCustom/CustomRoute.dart';

const String HomeRouteName = "/";
const String FilterRouteName = "/filter";
const String FilterTitleRouteName = "/filter/title";
const String FilterDirectorRouteName = "/filter/director";
const String FilterCastRouteName = "/filter/cast";
const String FilterGenreRouteName = "/filter/genre";
const String FilterMoreGenreRouteName = "/filter/genre/more";
const String FilterLangRouteName = "/filter/lang";
const String FilterLocationRouteName = "/filter/location";
const String FilterYearRouteName = "/filter/year";
const String ListRouteName = "/list";
const String RandomFilmRouteName = "/randomFilm";

class CustomNavigator extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Navigator(onGenerateRoute: getCustomRoutes);
  }

  static var routes = <String, WidgetBuilder>{
    HomeRouteName: (context) => HomeScreen(),
    FilterRouteName: (context) => FilterScreenContainer.main(),
    FilterTitleRouteName: (context) =>
        FilterScreenContainer(FilterStates.TitleFilter, title: "TITLE"),
    FilterDirectorRouteName: (context) => FilterScreenContainer(FilterStates.DirectorFilter, title: "DIRECTOR"),
    FilterCastRouteName: (context) => FilterScreenContainer(FilterStates.CastFilter, title: "CAST"),
    FilterGenreRouteName: (context) => FilterScreenContainer(FilterStates.GenderFilter, title: "GENRES"),
    FilterMoreGenreRouteName: (context) => FilterScreenContainer(FilterStates.MoreGenreFilter, title: "GENRES"),
    FilterLangRouteName: (context) => FilterScreenContainer(FilterStates.LanguagesFilter, title: "LANGUAGES"),
    FilterLocationRouteName: (context) => FilterScreenContainer(FilterStates.LocationFilter, title: "LOCATION"),
    FilterYearRouteName: (context) => FilterScreenContainer(FilterStates.YearFilter, title: "YEAR"),
    ListRouteName: (context) => ListScreenContainer(),
    RandomFilmRouteName: (context) => ListScreenContainer(randomFilm: true),
  };

  static Route<BuildContext> getCustomRoutes(RouteSettings settings) {
    print("routeMain");
    print(settings);
    var builder = routes[settings.name];
    print(builder);
    if (builder != null) {
      return new CustomRoute(
        settings: settings,
        builder: builder,
      );
    }
    return null;
  }
}
