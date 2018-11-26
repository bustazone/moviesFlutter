import 'package:flutter/material.dart';

class ProgressScreen extends StatefulWidget {
  ProgressScreen({Key key}) : super(key: key);

  @override
  State createState() => new ProgressScreenState();
}

class ProgressScreenState extends State<ProgressScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(color: new Color(0xFFCC9900)),
      child: new Center(
        child: new Text('Loading...',
            style: new TextStyle(fontSize: 40.0, color: Colors.black87)),
      ),
    );
  }
}
