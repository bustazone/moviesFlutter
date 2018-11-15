import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/feats/list/ListScreen.dart';
import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

class ListScreenContainer extends StatelessWidget {
  final bool randomFilm;

  ListScreenContainer({this.randomFilm = false});

  @override
  build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: (store) {
        return ViewModel.fromStore(store, randomFilm);
      },
      builder: (context, vm) {
        return ListScreen(vm);
      },
    );
  }
}

class ViewModel {
  final bool randomFilmFilter;
  final bool canQueryMore;
  final Function(bool) getFilms;
  final Function() getMoreFilms;
  final Function() resetList;
  final List<Film> filmList;
  final bool loadingData;

  ViewModel(
      {@required this.randomFilmFilter,
      @required this.canQueryMore,
      @required this.getFilms,
      @required this.getMoreFilms,
      @required this.resetList,
      @required this.filmList,
      @required this.loadingData});

  static ViewModel fromStore(Store<AppState> store, bool randomFilm) {
    return ViewModel(
        randomFilmFilter: randomFilm,
        canQueryMore: randomFilm ? false : store.state.filmList.couldQueryMore,
        getFilms: (random) {
          var filter = store.state.filter.getFilmFilter();
          filter.randomFilm = random;
          store.dispatch(getFilteredListRequest(filter));
        },
        getMoreFilms: () {
          var filter = store.state.filter.getFilmFilter();
          filter.page = store.state.filmList.page + 1;
          store.dispatch(getFilteredListRequest(filter, queryMore: true));
        },
        resetList: () {
          store.dispatch(ResetListAction());
        },
        filmList: store.state.filmList.filmList,
        loadingData: store.state.filmList.loading);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewModel &&
          runtimeType == other.runtimeType &&
          randomFilmFilter == other.randomFilmFilter &&
          filmList == other.filmList;

  @override
  int get hashCode => randomFilmFilter.hashCode ^ filmList.hashCode;
}
