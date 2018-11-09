import 'package:pelis_busta/reducers/CountReducer.dart';
import 'package:pelis_busta/reducers/FilterReducer.dart';
import 'package:pelis_busta/state/AppState.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      count: countReducer(state.count, action),
      filter: filterReducer(state.filter, action));
}
