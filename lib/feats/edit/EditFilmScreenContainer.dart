import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/feats/edit/EditFilmScreen.dart';
import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

class EditFilmScreenContainer extends StatelessWidget {
  final String title;

  EditFilmScreenContainer({Key key, this.title}) : super(key: key);

  @override
  build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: (store) {
        return ViewModel.fromStore(store);
      },
      builder: (context, vm) {
        return new EditFilmScreen(vm, title: title);
      },
    );
  }
}

class ViewModel {
  final Film film;
  final Function() getFilm;

  ViewModel({@required this.film, @required this.getFilm});

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
      film: store.state.filmDetail.selectedFilm,
      getFilm: () {
        var filmId = store.state.filmDetail.selectedFilmId;
        var film = store.state.filmDetail.selectedFilm;
        if (film == null ||  film.peliculaId != filmId) {
          store.dispatch(getFilmDetailRequest(filmId));
        }
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewModel &&
          runtimeType == other.runtimeType &&
          film == other.film;

  @override
  int get hashCode => film.hashCode;
}
