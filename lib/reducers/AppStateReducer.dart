import 'package:pelis_busta/reducers/EditFilmReducer.dart';
import 'package:pelis_busta/reducers/FilmDetailReducer.dart';
import 'package:pelis_busta/reducers/FilmListReducer.dart';
import 'package:pelis_busta/reducers/FilterReducer.dart';
import 'package:pelis_busta/reducers/LanguagesReducer.dart';
import 'package:pelis_busta/reducers/ListReducer.dart';
import 'package:pelis_busta/reducers/LoadingDataReducer.dart';
import 'package:pelis_busta/reducers/SubGenresReducer.dart';
import 'package:pelis_busta/reducers/UserReducer.dart';
import 'package:pelis_busta/state/AppState.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      filter: filterReducer(state.filter, action),
      filmList: filmListReducer(state.filmList, action),
      filmDetail: filmDetailReducer(state.filmDetail, action),
      editFilm: editFilmReducer(state.editFilm, action),
      languages: languagesListReducer(state.languages, action),
      subGenres: subGenresListReducer(state.subGenres, action),
      loadingDataState: loadingDataReducer(state.loadingDataState, action),
      userState: userReducer(state.userState, action),
      listState: listReducer(state.listState, action));
}
