import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/state/CountState.dart';
import 'package:redux/redux.dart';

final countReducer = combineReducers<CountState>([
  TypedReducer<CountState, SumAction>(_sum)
]);

CountState _sum(CountState state, SumAction action) {
  return state.copyWith(count: state.count + 1);
}

//CountState countReducer(CountState state, dynamic action) {
//  if (action == SumAction) {
//    return state.copyWith(count: state.count + 1);
//  }
//
//  return state;
//}