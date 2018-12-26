import 'package:flutter/material.dart';
import 'package:pelis_busta/components/dialogs/DialogWidget.dart';

enum Answers { YES, NO }

class ConfirmDialog extends StatelessWidget {
  static showConfirmDialog(context, text, Function() onAccept) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return ConfirmDialog(text: text);
        }).then((value) {
      switch (value) {
        case Answers.YES:
          onAccept();
          break;
        case Answers.NO:
          break;
      }
    });
  }

  final text;

  const ConfirmDialog({Key key, this.text}) : super(key: key);

  _buttons(var vm) {
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
                Navigator.pop(context, Answers.YES);
              },
            )
          ],
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
        title: text ?? 'Are you sure?',
        body: null,
        buttons: this._buttons(null));
  }
}
