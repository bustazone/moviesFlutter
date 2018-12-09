import 'package:flutter/material.dart';
import 'package:pelis_busta/navigation/OnNavigateRouteCustom/CustomNavigator.dart';
import 'package:pelis_busta/support/custom_widgets/PressingButton.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);


  Widget getMainButtons(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return new Stack(alignment: const FractionalOffset(0.0, 0.5), children: [
      new Positioned(
        child: new PressingButton('assets/imgs/search.png',
            'assets/imgs/search_selected.png', 200.0, null, () {
              Navigator.of(context).pushNamed(FilterRouteName);
            }),
        left: (screenWidth / 2.0) - 100.0,
        top: screenHeight / 2.0 - 100.0,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(FilterRouteName);
    return new Scaffold(
        body: new Container(
      color: const Color(0xFFEAEAEA),
      child: new Center(
        child: getMainButtons(context),
      ),
    ));
  }
}
