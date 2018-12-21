import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/feats/filmList/FilmListScreen.dart';
import 'package:pelis_busta/feats/filmList/FilmListViewModel.dart';
import 'package:pelis_busta/state/AppState.dart';

class FilmListScreenContainer extends StatelessWidget {
  FilmListScreenContainer();

  @override
  build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: (store) {
        return ViewModel.fromFilmListStore(store);
      },
      builder: (context, vm) {
        return FilmListScreen(vm);
      },
    );
  }
}
