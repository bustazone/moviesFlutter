import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/navigation/OnNavigateRouteCustom/CustomNavigator.dart';
import 'package:pelis_busta/reducers/AppStateReducer.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/custom_widgets/PreloadWidget.dart';
import 'package:pelis_busta/support/custom_widgets/ProgressScreen.dart';
import 'package:pelis_busta/support/services/middleware/ServicesMiddleware.dart';
import 'package:redux/redux.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(new PelisApp());

//  final store = new Store<int>(counterReducer, initialState: 0,
//      middleware: [new LoggingMiddleware.printer()]);
//
//  runApp(new FlutterReduxApp(
//    title: 'Flutter Redux Demo',
//    store: store,
//  ));
}

class PelisApp extends StatelessWidget {
  // This widget is the root of your application.
  final store = new Store<AppState>(appReducer,
      initialState: new AppState.initial(),
      middleware: [servicesMiddleware, _stateLog()]);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xFFCC9900), //or set color with: Color(0xFF0000FF)
    ));
    return new StoreProvider<AppState>(
      store: store,
      child: PreloadWidget(_getMainWidget()),
    );

    //_getLoadingWidget());
  }

  List<Widget> _getMainStack() {}

  Widget _getMainWidget() {
    return new MaterialApp(
        title: "pelis app",
        theme: new ThemeData(
            splashColor: const Color(0xFFEAEAEA),
            primaryColor: const Color(0xFFCC9900),
            backgroundColor: const Color(0xFFEAEAEA)),
        onGenerateRoute: CustomNavigator.getCustomRoutes,
        initialRoute: HomeRouteName,
        navigatorObservers: [routeObserver]);
  }

  Widget _getLoadingWidget() {
    return new MaterialApp(
      title: "pelis app",
      theme: new ThemeData(
          splashColor: const Color(0xFFEAEAEA),
          primaryColor: const Color(0xFFCC9900),
          backgroundColor: const Color(0xFFEAEAEA)),
      home: new ProgressScreen(),
    );
//    return new Directionality(
//            textDirection: TextDirection.rtl,
//            child: new ProgressScreen());
  }
}

Middleware<AppState> _stateLog() {
  return (Store<AppState> store, action, NextDispatcher next) {
    var pre = store.state.copyWith();
    next(action);
    var pos = store.state.copyWith();

    debugPrint("Previous State: $pre");
    debugPrint("Action: $action");
    debugPrint("Next State: $pos");
    debugPrint("Timestamp: ${new DateTime.now()}");
  };
}

// One simple action: Increment
enum Actions { Increment }

// The reducer, which takes the previous count and increments it in response
// to an Increment action.
int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }

  return state;
}

//void main() {
//  // Create your store as a final variable in a base Widget. This works better
//  // with Hot Reload than creating it directly in the `build` function.
//  final store = new Store<int>(counterReducer, initialState: 0);
//
//  runApp(new FlutterReduxApp(
//    title: 'Flutter Redux Demo',
//    store: store,
//  ));
//}

class FlutterReduxApp extends StatelessWidget {
  final Store<int> store;
  final String title;

  FlutterReduxApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The StoreProvider should wrap your MaterialApp or WidgetsApp. This will
    // ensure all routes have access to the store.
    return new StoreProvider<int>(
      // Pass the store to the StoreProvider. Any ancestor `StoreConnector`
      // Widgets will find and use this value as the `Store`.
      store: store,
      child: new MaterialApp(
        theme: new ThemeData.dark(),
        title: title,
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text(title),
          ),
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Text(
                  'You have pushed the button this many times:',
                ),
                // Connect the Store to a Text Widget that renders the current
                // count.
                //
                // We'll wrap the Text Widget in a `StoreConnector` Widget. The
                // `StoreConnector` will find the `Store` from the nearest
                // `StoreProvider` ancestor, convert it into a String of the
                // latest count, and pass that String  to the `builder` function
                // as the `count`.
                //
                // Every time the button is tapped, an action is dispatched and
                // run through the reducer. After the reducer updates the state,
                // the Widget will be automatically rebuilt with the latest
                // count. No need to manually manage subscriptions or Streams!
                new StoreConnector<int, String>(
                  converter: (store) => store.state.toString(),
                  builder: (context, count) {
                    return new Text(
                      count,
                      style: Theme.of(context).textTheme.display1,
                    );
                  },
                )
              ],
            ),
          ),
          // Connect the Store to a FloatingActionButton. In this case, we'll
          // use the Store to build a callback that with dispatch an Increment
          // Action.
          //
          // Then, we'll pass this callback to the button's `onPressed` handler.
          floatingActionButton: new StoreConnector<int, VoidCallback>(
            converter: (store) {
              // Return a `VoidCallback`, which is a fancy name for a function
              // with no parameters. It only dispatches an Increment action.
              return () => store.dispatch(Actions.Increment);
            },
            builder: (context, callback) {
              return new FloatingActionButton(
                // Attach the `callback` to the `onPressed` attribute
                onPressed: callback,
                tooltip: 'asdasdasd',
                child: new Icon(Icons.add),
              );
            },
          ),
        ),
      ),
    );
  }
}
