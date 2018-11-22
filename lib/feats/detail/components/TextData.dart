import 'package:flutter/material.dart';

class TextData extends StatelessWidget {

  final String name;
  final String value;

  const TextData(this.name, this.value, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: new EdgeInsets.all(16.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                name,
                style: new TextStyle(
                    color: Color(0xFFCC9900), fontSize: 14),
              ),
              new Text(
                value != null
                    ? value
                    : "",
                style: new TextStyle(
                    color: Color(0xFF564C19), fontSize: 20),
              ),
            ]));
  }

}