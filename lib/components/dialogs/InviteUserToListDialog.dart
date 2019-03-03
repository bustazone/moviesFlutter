import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/components/dialogs/DialogWidget.dart';
import 'package:pelis_busta/feats/edit/components/TextInputWithLabel.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:redux/redux.dart';

enum Answers { YES, NO }

class InviteUserToListDialogContainer extends StatelessWidget {
  static showInviteUserToListDialog(context, listId) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return InviteUserToListDialogContainer(listId);
        }).then((value) {
      switch (value) {
        case Answers.YES:
          break;
        case Answers.NO:
          break;
      }
    });
  }

  final int listId;

  InviteUserToListDialogContainer(this.listId, {Key key}) : super(key: key);

  _body(context) {
    return new Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextInputWithLabel("Email:", (val) {}, ""),
          ],
        ));
  }

  _buttons(context) {
    return ButtonTheme.bar(
      child: ButtonBar(
        children: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context, Answers.YES);
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.pop(context, Answers.YES);
            },
          )
        ],
      ),
    );
  }

  @override
  build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel.fromStore(store, listId);
      },
      builder: (context, vm) {
        return DialogWidget(
            title: "Write the User Email:",
            body: this._body,
            buttons: this._buttons);
      },
    );
  }
}

class _ViewModel {
  final int listId;
  final Function(String) inviteUserToList;

  _ViewModel({@required this.listId, @required this.inviteUserToList});

  static _ViewModel fromStore(Store<AppState> store, int listId) {
    return _ViewModel(
        listId: listId,
        inviteUserToList: (String v) {
          //store.dispatch(SetEditFilmLocation(v));
        });
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          listId == other.listId;

  @override
  int get hashCode => listId.hashCode;
}
