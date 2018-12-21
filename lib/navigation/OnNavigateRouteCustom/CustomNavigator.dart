import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/detail/DetailFilmScreenContainer.dart';
import 'package:pelis_busta/feats/edit/EditFilmScreenContainer.dart';
import 'package:pelis_busta/feats/filmList/UserFilmListScreenContainer.dart';
import 'package:pelis_busta/feats/filter/FilterScreen.dart';
import 'package:pelis_busta/feats/filter/FilterScreenContainer.dart';
import 'package:pelis_busta/feats/filmList/FilmListScreenContainer.dart';
import 'package:pelis_busta/feats/list/ListScreenContainer.dart';
import 'package:pelis_busta/navigation/OnNavigateRouteCustom/CustomRoute.dart';

const String HomeRouteName = "/";
const String FilterRouteName = "/filter";
const String FilterTitleRouteName = "/filtertitle";
const String FilterDirectorRouteName = "/filterdirector";
const String FilterCastRouteName = "/filtercast";
const String FilterGenreRouteName = "/filtergenre";
const String FilterMoreGenreRouteName = "/filtergenre/more";
const String FilterLangRouteName = "/filterlang";
const String FilterLocationRouteName = "/filterlocation";
const String FilterYearRouteName = "/filteryear";
const String FilmListRouteName = "/filmList";
const String RandomFilmRouteName = "/randomFilm";
const String DetailRouteName = "/detail";
const String EditRouteName = "/detail/edit";
const String ListRouteName = "/list";
const String UserListRouteName = "/list/filmList";


class CustomNavigator extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Navigator(onGenerateRoute: getCustomRoutes);
  }

  static var routes = <String, WidgetBuilder>{
    HomeRouteName: (context) => FilterScreenContainer.main(),
    //FilterRouteName: (context) => FilterScreenContainer.main(),
    FilterTitleRouteName: (context) =>
        FilterScreenContainer(FilterStates.TitleFilter, title: "TITLE"),
    FilterDirectorRouteName: (context) =>
        FilterScreenContainer(FilterStates.DirectorFilter, title: "DIRECTOR"),
    FilterCastRouteName: (context) =>
        FilterScreenContainer(FilterStates.CastFilter, title: "CAST"),
    FilterGenreRouteName: (context) =>
        FilterScreenContainer(FilterStates.GenderFilter, title: "GENRES"),
    FilterMoreGenreRouteName: (context) =>
        FilterScreenContainer(FilterStates.MoreGenreFilter, title: "GENRES"),
    FilterLangRouteName: (context) =>
        FilterScreenContainer(FilterStates.LanguagesFilter, title: "LANGUAGES"),
    FilterLocationRouteName: (context) =>
        FilterScreenContainer(FilterStates.LocationFilter, title: "LOCATION"),
    FilterYearRouteName: (context) =>
        FilterScreenContainer(FilterStates.YearFilter, title: "YEAR"),
    FilmListRouteName: (context) => FilmListScreenContainer(),
    RandomFilmRouteName: (context) => DetailScreenContainer(randomFilm: true),
    DetailRouteName: (context) => DetailScreenContainer(),
    EditRouteName: (context) => EditFilmScreenContainer(),
    ListRouteName: (context) => ListScreenContainer(),
    UserListRouteName: (context) => UserFilmListScreenContainer(),
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
