import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/GetItemsList.dart';
import 'package:pelis_busta/support/services/UserServices.dart';
import 'package:redux/redux.dart';

class PreloadWidget extends StatelessWidget {
  final Widget child;

  PreloadWidget(this.child, {Key key}) : super(key: key);

  @override
  build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: (store) {
        return ViewModel.fromStore(store);
      },
      builder: (context, vm) {
        return new PreloadWidgetView(vm, child);
      },
    );
  }
}

class ViewModel {
  final bool hasLanguages;
  final bool hasSubtitles;
  final bool hasGenres;
  final bool hasUser;
  final Function() getLanguages;
  final Function() getSubtitles;
  final Function() getGenres;
  final Function() getUser;

  ViewModel(
      {@required this.hasLanguages,
      @required this.hasSubtitles,
      @required this.hasGenres,
      @required this.hasUser,
      @required this.getLanguages,
      @required this.getSubtitles,
      @required this.getGenres,
      @required this.getUser});

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
      hasLanguages: store.state.languages.languagesList.l.length > 0,
      hasSubtitles: store.state.languages.subtitlesList.l.length > 0,
      hasGenres: store.state.subGenres.genresList.length > 0,
      hasUser: store.state.userState.user != null,
      getLanguages: () {
        var loading = store.state.languages.loadingLanguages;
        if (!loading) {
          store.dispatch(getLanguagesRequest());
        }
      },
      getSubtitles: () {
        var loading = store.state.languages.loadingSubtitles;
        if (!loading) {
          store.dispatch(getSubtitlesRequest());
        }
      },
      getGenres: () {
        var loading = store.state.subGenres.loading;
        if (!loading) {
          store.dispatch(getSubGenresRequest());
        }
      },
      getUser: () {
        var loading = store.state.userState.loading;
        if (!loading) {
          store.dispatch(getUserRequest());
        }
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewModel &&
          runtimeType == other.runtimeType &&
          hasLanguages == other.hasLanguages &&
          hasSubtitles == other.hasSubtitles &&
          hasGenres == other.hasGenres &&
          hasUser == other.hasUser;

  @override
  int get hashCode => hasLanguages.hashCode ^ hasSubtitles.hashCode ^ hasGenres.hashCode ^ hasUser.hashCode;
}

class PreloadWidgetView extends StatelessWidget {
  final ViewModel vm;
  final Widget child;

  PreloadWidgetView(this.vm, this.child, {Key key}) : super(key: key);

  @override
  build(BuildContext context) {
    if (!vm.hasLanguages) vm.getLanguages();
    if (!vm.hasSubtitles) vm.getSubtitles();
    if (!vm.hasGenres) vm.getGenres();
    if (!vm.hasUser) vm.getUser();
    return child;
  }
}
