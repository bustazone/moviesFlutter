import 'package:flutter/material.dart';
import 'package:pelis_busta/models/UserList.dart';
import 'package:pelis_busta/navigation/OnNavigateRouteCustom/CustomNavigator.dart';
import 'package:pelis_busta/support/constants/DesignConstants.dart';

class ListRow extends StatelessWidget {
  final Function(int) setListId;
  final UserList list;

  ListRow(this.list, this.setListId);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final transformProportion = (screenWidth / DesignConstants.filmRowWidth);

    String title = list.name ?? "";

    var background = new Container(
        color: const Color(0xFFEAEAEA),
        child: new Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            new Image.asset('assets/genderIcon/Stroke1.png'),
            new Image.asset(
              'assets/genderIcon/Stroke2.png',
              width: 110.0 * transformProportion,
            ),
            new Image.asset('assets/genderIcon/Stroke3.png'),
            new Image.asset('assets/genderIcon/Stroke4.png'),
            new Image.asset(
              'assets/imgs/backFilmRow.png',
              color: new Color(0xFFCC9900),
              scale: 0.5,
              fit: BoxFit.cover,
            ),
            new Container(
              child: new Text(title,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: new Color(0xFF6B6969),
                      fontFamily: 'Marion',
                      fontWeight: FontWeight.normal,
                      fontSize: 50.0 * transformProportion,
                      decoration: TextDecoration.none)),
            )
          ],
        ));

    return new GestureDetector(
        onTap: () {
          this.setListId(list.id);
          Navigator.of(context).pushNamed(UserListRouteName);
        },
        child: new Container(
            height: DesignConstants.filmRowHeight * transformProportion,
            width: screenWidth,
            child: new Stack(
              children: [
                background,
                //rightSideContainer,
              ],
            )));
  }
}

class FirstRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return new Container(
      width: screenWidth,
      color: const Color(0xFFEAEAEA),
      child: new Image.asset(
        'assets/imgs/backFilmFirstRow.png',
        color: new Color(0xFFCC9900),
        fit: BoxFit.cover,
      ),
    );
  }
}

class LastRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final transformProportion = (screenWidth / DesignConstants.filmRowWidth);

    return new Container(
      height: ((DesignConstants.filmRowHeight * transformProportion) / 2) - 1.0,
      color: const Color(0xFFEAEAEA),
      child: new Image.asset(
        'assets/imgs/backFilmLastRow.png',
        color: new Color(0xFFCC9900),
        fit: BoxFit.cover,
      ),
    );
  }
}

class NoResultsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final transformProportion = (screenWidth / DesignConstants.filmRowWidth);

    return new Container(
        color: const Color(0xFFEAEAEA),
        child: new Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            new Image.asset(
              'assets/imgs/backFilmRow.png',
              color: new Color(0xFFCC9900),
              scale: 0.5,
              fit: BoxFit.cover,
            ),
            new Container(
              child: new Text("Sorry,\nthe filter\nhas no results...",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: new Color(0xFF6B6969),
                      fontFamily: 'Marion',
                      fontWeight: FontWeight.normal,
                      fontSize: 25.0 * transformProportion,
                      decoration: TextDecoration.none)),
            )
          ],
        ));
  }
}
