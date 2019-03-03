import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pelis_busta/components/dialogs/DialogWidget.dart';
import 'package:pelis_busta/feats/edit/components/TextInputWithLabel.dart';
import 'package:pelis_busta/state/AppState.dart';
import 'package:pelis_busta/support/services/UserListServices.dart';
import 'package:pelis_busta/support/services/UserServices.dart';
import 'package:redux/redux.dart';

enum Answers { YES, NO }

class AddListDialogContainer extends StatefulWidget {
  static showAddListDialog(context, {onSuccess}) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AddListDialogContainer(onSuccess: onSuccess);
        }).then((value) {
      switch (value) {
        case Answers.YES:
//          if (onSuccess == null) {
//            onSuccess();
//          }
          break;
        case Answers.NO:
          break;
      }
    });
  }

  final Function() onSuccess;

  AddListDialogContainer({this.onSuccess}) : super();

  @override
  State createState() => new AddListDialogContainerState();
}

class AddListDialogContainerState extends State<AddListDialogContainer> {
  var text = "";

  _body(context) {
    return new Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextInputWithLabel("data", (val) {
              setState(() {
                text = val;
              });
            }, text),
          ],
        ));
  }

  _buttons(_ViewModel vm) {
    return (context) {
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
                vm.setName(text);
                Navigator.pop(context, Answers.YES);
              },
            )
          ],
        ),
      );
    };
  }

  @override
  build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel.fromStore(store, onSuccess: widget.onSuccess);
      },
      builder: (context, vm) {
        return DialogWidget(
            title: "Create a new list:",
            body: this._body,
            buttons: this._buttons(vm));
      },
    );
  }
}

class _ViewModel {
  final Function(String) setName;

  _ViewModel({@required this.setName});

  static _ViewModel fromStore(Store<AppState> store, {Function() onSuccess}) {
    return _ViewModel(setName: (String v) {
      final ddd = (response) {
        store.dispatch(getUserRequest());
      };
      int userId = store.state.userState.user.id;
      store.dispatch(addUserListRequest(userId, v, onSuccess: ddd));
    });
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType;

  @override
  int get hashCode => 1;
}
