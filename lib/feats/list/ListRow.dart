import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pelis_busta/components/dialogs/ConfirmDialog.dart';
import 'package:pelis_busta/models/UserList.dart';
import 'package:pelis_busta/navigation/OnNavigateRouteCustom/CustomNavigator.dart';
import 'package:pelis_busta/support/constants/DesignConstants.dart';

class ListRow extends StatelessWidget {
  final UserList list;
  final Function(int) setListId;
  final Function(int, String) shareList;
  final Function(int) deleteList;

  ListRow(this.list, this.setListId, this.shareList, this.deleteList);

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
              margin: EdgeInsets.all(28.0),
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

    var deleteSlideAction = new IconSlideAction(
      caption: 'Delete',
      color: Colors.blue,
      icon: Icons.delete,
      onTap: () {
        ConfirmDialog.showConfirmDialog(
            context, "You're going to delete the list. Are you sure??", () {
          this.deleteList(list.id);
        });
      },
    );

    var shareSlideAction = new IconSlideAction(
      caption: 'Share',
      color: Colors.indigo,
      icon: Icons.share,
      onTap: () {
//        ConfirmDialog.showShareDialog(
//            context, "You're going to delete the list. Are you sure??", () {
//          //this.shareList(list.id, name);
//        });
      },
    );

    var mainBody = new GestureDetector(
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

//    return new Dismissible(
//        key: Key(list.id.toString()),
//        onDismissed: (dismissDirection) {
//          if (dismissDirection == DismissDirection.endToStart) {
//            this.shareList(list.id);
//          } else if (dismissDirection == DismissDirection.startToEnd) {
//            ConfirmDialog.showConfirmDialog(
//                context, "You're going to delete the list. Are you sure??", () {
//              this.deleteList(list.id);
//            });
//          }
//        },
//        direction: DismissDirection.horizontal,
//        dismissThresholds: {
//          DismissDirection.endToStart: 0.5,
//          DismissDirection.startToEnd: 0.5
//        },
//        child: mainBody);

    return new Slidable(
        delegate: new SlidableBehindDelegate(),
        actionExtentRatio: 0.30,
        child: new Container(
          color: Colors.white,
          child: mainBody,
        ),
        actions: <Widget>[
          shareSlideAction,
          deleteSlideAction,
        ],
        secondaryActions: <Widget>[
          deleteSlideAction,
          shareSlideAction,
        ]);
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
