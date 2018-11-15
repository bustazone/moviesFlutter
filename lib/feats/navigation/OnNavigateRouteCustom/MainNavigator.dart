import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/home/HomeScreen.dart';
import 'package:pelis_busta/feats/navigation/OnNavigateRouteCustom/CustomRoute.dart';
import 'package:pelis_busta/feats/navigation/OnNavigateRouteCustom/FilterNavigator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainNavigator {
  static var routes = <String, WidgetBuilder>{
    '/': (context) => HomeScreen(),
    '/filter': (context) => FilterNavigator()
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
