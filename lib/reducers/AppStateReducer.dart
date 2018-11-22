import 'package:pelis_busta/reducers/FilterReducer.dart';
import 'package:pelis_busta/reducers/FilmListReducer.dart';
import 'package:pelis_busta/reducers/FilmDetailReducer.dart';
import 'package:pelis_busta/reducers/LoadingDataReducer.dart';
import 'package:pelis_busta/state/AppState.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      filter: filterReducer(state.filter, action),
      filmList: filmListReducer(state.filmList, action),
      filmDetail: filmDetailReducer(state.filmDetail, action),
      loadingDataState: loadingDataReducer(state.loadingDataState, action));
}
