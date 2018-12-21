import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/feats/filmList/FilmListScreen.dart';
import 'package:pelis_busta/feats/filmList/FilmListViewModel.dart';
import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

class UserFilmListScreenContainer extends StatelessWidget {

  UserFilmListScreenContainer();

  @override
  build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: (store) {
        return ViewModel.fromUserFilmListStore(store);
      },
      builder: (context, vm) {
        return FilmListScreen(vm);
      },
    );
  }
}