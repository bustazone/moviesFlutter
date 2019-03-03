import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/components/dialogs/DialogWidget.dart';
import 'package:pelis_busta/models/UserList.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/UserListServices.dart';
import 'package:redux/redux.dart';

enum Answers { YES, NO }

class AddFilmToListDialogContainer extends StatelessWidget {
  static showAddFilmToListDialog(context, filmId) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AddFilmToListDialogContainer(filmId);
        }).then((value) {
      switch (value) {
        case Answers.YES:
          break;
        case Answers.NO:
          break;
      }
    });
  }

  final int filmId;
  BuildContext context;

  AddFilmToListDialogContainer(this.filmId, {Key key}) : super(key: key);

  _getItem(UserList item, _ViewModel vm) {
    return InkWell(
        onTap: () {
          Navigator.pop(context, Answers.YES);
          vm.insertFilmInList(item.id);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            color: const Color(0xFFEAEAEA),
          ),
          child: new Text(item.name,
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: new Color(0xFF6B6969),
                  fontFamily: 'Marion',
                  fontWeight: FontWeight.normal,
                  fontSize: 30.0,
                  decoration: TextDecoration.none)),
        ));
  }

  _body(_ViewModel vm) {
    return (context) {
      return new Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Container(
                height: 200,
                child: new CustomScrollView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  slivers: <Widget>[
                    new SliverList(
                      delegate: new SliverChildBuilderDelegate(
                        (context, index) =>
                            _getItem(vm.listUserList[index], vm),
                        childCount: vm.listUserList.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
    };
  }

  _buttons(_ViewModel vm) {
    return (context) {
      return ButtonTheme.bar(
        child: ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, Answers.NO);
              },
            )
          ],
        ),
      );
    };
  }

  @override
  build(BuildContext context) {
    this.context = context;
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel.fromStore(store, filmId);
      },
      builder: (context, vm) {
        return DialogWidget(
            title: "Select a list to add the film:",
            body: this._body(vm),
            buttons: this._buttons(vm));
      },
    );
  }
}

class _ViewModel {
  final int filmId;
  final List<UserList> listUserList;
  final Function(int) insertFilmInList;

  _ViewModel({this.filmId, this.listUserList, this.insertFilmInList});

  static _ViewModel fromStore(Store<AppState> store, int filmId) {
    return _ViewModel(
        filmId: filmId,
        listUserList: store.state.userState.user.lists,
        insertFilmInList: (int listId) {
          store.dispatch(addFilmToListRequest(listId, filmId));
        });
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          filmId == other.filmId;

  @override
  int get hashCode => filmId.hashCode;
}
