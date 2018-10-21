import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filter/FilterScreen.dart';

void main() {
  runApp(new PelisApp());
}

class PelisApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "pelis app",
      theme: new ThemeData(
          splashColor: const Color(0xFFEAEAEA),
          primaryColor: const Color(0xFFCC9900),
          backgroundColor: const Color(0xFFEAEAEA)
      ),
      home: new FilterScreen.main(),
    );
  }
}
