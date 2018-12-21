import 'package:flutter/material.dart';
import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:pelis_busta/support/services/UserListServices.dart';
import 'package:redux/redux.dart';

class ViewModel {
  final bool showLoader;
  final bool canQueryMore;
  final Function() getFilms;
  final Function() getMoreFilms;
  final Function() resetList;
  final Function(int) selectFilm;
  final List<Film> filmList;
  final bool loadingData;

  ViewModel(
      {@required this.showLoader,
        @required this.canQueryMore,
        @required this.getFilms,
        @required this.getMoreFilms,
        @required this.resetList,
        @required this.selectFilm,
        @required this.filmList,
        @required this.loadingData});

  static ViewModel fromFilmListStore(Store<AppState> store) {
    return ViewModel(
        showLoader: store.state.loadingDataState.loadingProcesses > 0,
        canQueryMore: store.state.filmList.couldQueryMore,
        getFilms: () {
          var filter = store.state.filter.getFilmFilter();
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
        selectFilm: (filmId) {
          print("selectFilm $filmId");
          store.dispatch(SetSelectedFilmIdStateAction(filmId));
        },
        filmList: store.state.filmList.filmList,
        loadingData: store.state.filmList.loading);
  }

  static ViewModel fromUserFilmListStore(Store<AppState> store) {
    return ViewModel(
        showLoader: store.state.loadingDataState.loadingProcesses > 0,
        canQueryMore: false,
        getFilms: () {
          var list_id = store.state.listState.selectedList;
          store.dispatch(getUserListRequest(list_id));
        },
        getMoreFilms: () {
        },
        resetList: () {
          store.dispatch(ResetListAction());
        },
        selectFilm: (filmId) {
          store.dispatch(SetSelectedFilmIdStateAction(filmId));
        },
        filmList: store.state.listState.list.films,
        loadingData: store.state.listState.loading);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ViewModel &&
              runtimeType == other.runtimeType &&
              showLoader == other.showLoader &&
              filmList == other.filmList;

  @override
  int get hashCode =>
      showLoader.hashCode ^ filmList.hashCode;
}
