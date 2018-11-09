import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/state/CountState.dart';
import 'package:pelis_busta/state/FilterState.dart';
import 'package:redux/redux.dart';

final filterReducer = combineReducers<FilterState>([
  TypedReducer<FilterState, SetSeriesAction>(_setSeries)
]);

FilterState _setSeries(FilterState state, SetSeriesAction action) {
  return state.copyWith(series: action.isSeries);
}
