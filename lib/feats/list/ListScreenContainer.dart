import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/actions/actions.dart';
import 'package:pelis_busta/feats/list/ListScreen.dart';
import 'package:pelis_busta/models/UserList.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:redux/redux.dart';

class ListScreenContainer extends StatelessWidget {

  ListScreenContainer();

  @override
  build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: (store) {
        return ViewModel.fromStore(store);
      },
      builder: (context, vm) {
        return ListScreen(vm);
      },
    );
  }
}

class ViewModel {
  final bool showLoader;
  final List<UserList> userLists;
  final Function(int) selectList;
  final Function() addList;
  final Function() getList;
  final bool loadingData;

  ViewModel(
      {@required this.showLoader,
        @required this.userLists,
        @required this.selectList,
        @required this.addList,
        @required this.getList,
        @required this.loadingData});

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
        showLoader: store.state.loadingDataState.loadingProcesses > 0,
        userLists: store.state.userState.user.lists,
        selectList: (listId) {
          store.dispatch(SetSelectedListIdStateAction(listId));
        },
        addList: () {
          var filter = store.state.filter.getFilmFilter();
          filter.page = store.state.filmList.page + 1;
          store.dispatch(getFilteredListRequest(filter, queryMore: true));
        },
        getList: () {
          var filter = store.state.filter.getFilmFilter();
          store.dispatch(getFilteredListRequest(filter));
        },
        loadingData: store.state.filmList.loading);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ViewModel &&
              runtimeType == other.runtimeType &&
              showLoader == other.showLoader &&
              userLists == other.userLists &&
              loadingData == other.loadingData;

  @override
  int get hashCode =>
      showLoader.hashCode ^ loadingData.hashCode ^ userLists.hashCode;
}
