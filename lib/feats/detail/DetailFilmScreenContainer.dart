import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/feats/detail/DetailFilmScreen.dart';
import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

class DetailScreenContainer extends StatelessWidget {
  final String title;
  final bool randomFilm;

  DetailScreenContainer({Key key, this.title, this.randomFilm = false})
      : super(key: key);

  @override
  build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: (store) {
        return ViewModel.fromStore(store, randomFilm);
      },
      builder: (context, vm) {
        return new DetailScreen(vm, title: title);
      },
    );
  }
}

class ViewModel {
  final bool showLoader;
  final Film film;
  final bool randomFilmFilter;
  final Function() getFilm;

  ViewModel(
      {@required this.showLoader,
      @required this.film,
      @required this.randomFilmFilter,
      @required this.getFilm});

  static ViewModel fromStore(Store<AppState> store, bool randomFilm) {
    return ViewModel(
      //showLoader: store.state.filmDetail.selectedFilm == null || store.state.filmDetail.selectedFilm == null,
      showLoader: store.state.filmDetail.selectedFilm == null,
      film: store.state.filmDetail.selectedFilm,
      randomFilmFilter: randomFilm,
      getFilm: () {

        final onSuccess = (response) {
          final filmId = response[0].filmId;
          store.dispatch(SetSelectedFilmIdStateAction(filmId));
          store.dispatch(getFilmDetailRequest(filmId));
        };

        var filmId = store.state.filmDetail.selectedFilmId;
        var film = store.state.filmDetail.selectedFilm;
        if (film == null || film.filmId != filmId || randomFilm) {
          if (randomFilm) {
            var filter = store.state.filter.getFilmFilter();
            store.dispatch(getRandomFilmFilteredRequest(filter));
          } else {
            store.dispatch(getFilmDetailRequest(filmId));
          }
        }
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewModel &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          film == other.film;

  @override
  int get hashCode => showLoader.hashCode ^ film.hashCode;
}
