import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filter/FilterScreen.dart';
import 'package:pelis_busta/feats/navigation/OnNavigateRouteCustom/CustomRoute.dart';

const String FilterTitleRouteName = "/title";
const String FilterDirectorRouteName = "/director";
const String FilterCastRouteName = "/cast";
const String FilterGenreRouteName = "/genre";
const String FilterMoreGenreRouteName = "/genre/more";
const String FilterLangRouteName = "/lang";
const String FilterLocationRouteName = "/location";
const String FilterYearRouteName = "/year";


class FilterNavigator extends StatelessWidget {

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget build(BuildContext context) {
    return new Navigator(
      onGenerateRoute: getCustomRoutes,
      initialRoute: '/',
    );
  }

  static var routes = <String, WidgetBuilder>{
//    '/': (context) => FilterScreen(currentState: FilterStates.FilterSelector),
//    FilterTitleRouteName: (context) =>
//        FilterScreen(title: "TITLE", currentState: FilterStates.TitleFilter),
//    FilterDirectorRouteName: (context) => FilterScreen(
//        title: "DIRECTOR", currentState: FilterStates.DirectorFilter),
//    FilterCastRouteName: (context) =>
//        FilterScreen(title: "CAST", currentState: FilterStates.CastFilter),
//    FilterGenreRouteName: (context) =>
//        FilterScreen(title: "GENRES", currentState: FilterStates.GenderFilter),
//    FilterMoreGenreRouteName: (context) => FilterScreen(
//        title: "GENRES", currentState: FilterStates.MoreGenreFilter),
//    FilterLangRouteName: (context) => FilterScreen(
//        title: "LANGUAGES", currentState: FilterStates.LanguagesFilter),
//    FilterLocationRouteName: (context) => FilterScreen(
//        title: "LOCATION", currentState: FilterStates.LocationFilter),
//    FilterYearRouteName: (context) =>
//        FilterScreen(title: "YEAR", currentState: FilterStates.YearFilter),
  };

  static Route<BuildContext> getCustomRoutes(RouteSettings settings) {
    var builder = routes[settings.name];
    if (builder != null) {
      return new CustomRoute(
        settings: settings,
        builder: builder,
      );
    }
    return null;
  }
}
