import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pelis_busta/components/dialogs/ConfirmDialog.dart';
import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/support/constants/DesignConstants.dart';
import 'package:pelis_busta/support/custom_widgets/HorizontalmageList.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class FilmRow extends StatelessWidget {
  final Function(int) selectFilm;
  final int itemNum;
  final Film film;
  final Function(int) deleteFilmFromList;
  final bool withOptions;

  FilmRow(this.itemNum, this.film, this.selectFilm, this.withOptions,
      this.deleteFilmFromList);

  @override
  Widget build(BuildContext context) {
    print(itemNum);

    final double screenWidth = MediaQuery.of(context).size.width;
    final transformProportion = (screenWidth / DesignConstants.filmRowWidth);

    int backgroundNumber = itemNum;
    String filmTitle = film.title ?? "";
    String filmImageURL = film.imageUrl ?? "";
    String filmYear = "";
    if (film.year != null) {
      filmYear = "(" + film.year.toString() + ")";
    }
    String filmTime = "";
    if (film.duration != null) {
      filmTime = film.duration.toString() + "'";
    }
    String filmPunc = film.punctuation?.toStringAsFixed(1) ?? "";
    String filmLoc = film.location ?? "";

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
              child: new Text(backgroundNumber.toString(),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: new Color(0xFF6B6969),
                      fontFamily: 'Marion',
                      fontWeight: FontWeight.normal,
                      fontSize: 100.0 * transformProportion,
                      decoration: TextDecoration.none)),
            )
          ],
        ));

    var languageContainer = new Container(
        child: new Column(children: <Widget>[
      new Expanded(
        child: new Container(
            margin: new EdgeInsets.only(left: 4.0 * transformProportion),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Image.asset(
                  'assets/icons/icon_audio.png',
                  width: 11.0 * transformProportion,
                ),
                new Expanded(
                    child: HorizontalImageList(
                        (isNullOrEmpty(film.languagesStr))
                            ? []
                            : film.languagesStr.split(';'),
                        'assets/languages/',
                        23.0 * transformProportion,
                        1.0 * transformProportion))
              ],
            )),
      ),
      new Expanded(
        child: new Container(
          margin:
              new EdgeInsets.symmetric(horizontal: 4.0 * transformProportion),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Image.asset(
                'assets/icons/icon_subs.png',
                width: 11.0 * transformProportion,
              ),
              new Expanded(
                  child: HorizontalImageList(
                      (isNullOrEmpty(film.subtitlesStr))
                          ? []
                          : film.subtitlesStr.split(';'),
                      'assets/languages/',
                      23.0 * transformProportion,
                      1.0 * transformProportion))
            ],
          ),
        ),
      ),
    ]));
    var leftSideContainer = new Container(
        width: DesignConstants.imageFilmRowWidth * transformProportion,
        child: new Column(children: <Widget>[
          new Container(
            child: new Image.network(
              filmImageURL,
              fit: BoxFit.cover,
              height: DesignConstants.imageFilmRowHeight * transformProportion,
            ),
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(
                    new Radius.circular(5.0 * transformProportion)),
                border: new Border.all(
                    color: new Color(0xFFCC9900),
                    width: 3.0 * transformProportion)),
          ),
          new Expanded(child: languageContainer),
        ]));
    var rightSideContainer = new Expanded(
        child: new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                    margin: new EdgeInsets.only(
                        top: 2.0 * transformProportion,
                        bottom: 2.0 * transformProportion),
                    child: new Text(filmTitle,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.clip,
                        maxLines: 3,
                        style: new TextStyle(
                          color: new Color(0xFF564C19),
                          fontFamily: 'Marion',
                          fontSize: 17.0 * transformProportion,
                          decoration: TextDecoration.none,
                        ))),
                new Text(filmYear,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                        color: new Color(0xFF564C19),
                        fontFamily: 'Marion',
                        fontSize: 14.0 * transformProportion,
                        decoration: TextDecoration.none)),
              ],
            ),
          ),
          new Expanded(
              child: new Container(
                  margin: new EdgeInsets.only(bottom: 5.0),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: 30.0 * transformProportion,
                        child: HorizontalImageList(
                            (isNullOrEmpty(film.genresStr))
                                ? []
                                : film.genresStr.split(';'),
                            'assets/genderIcon/genderIcon_',
                            25.0 * transformProportion,
                            2.0 * transformProportion,
                            mainAxisAlignment: MainAxisAlignment.end),
                      ),
                      new Expanded(
                          child: new Container(
                              child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                              margin: new EdgeInsets.only(
                                  right: 4.0 * transformProportion,
                                  top: 2.0 * transformProportion),
                              child: new Text(filmTime,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                      color: new Color(0xFF564C19),
                                      fontFamily: 'Marion',
                                      fontSize: 14.0 * transformProportion,
                                      decoration: TextDecoration.none))),
                          new Image.asset(
                            'assets/icons/icon_time.png',
                            width: 12 * transformProportion,
                          ),
                        ],
                      ))),
                      new Expanded(
                          child: new Container(
                              child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                              margin: new EdgeInsets.only(
                                  right: 4.0 * transformProportion,
                                  top: 3.0 * transformProportion),
                              child: new Text(filmPunc,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                      color: new Color(0xFF564C19),
                                      fontFamily: 'Marion',
                                      fontSize: 14.0 * transformProportion,
                                      decoration: TextDecoration.none))),
                          new Image.asset(
                            'assets/icons/icon_punc.png',
                            width: 12.0 * transformProportion,
                          ),
                        ],
                      ))),
                      new Expanded(
                          child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                            margin: new EdgeInsets.only(
                                right: 4.0 * transformProportion,
                                top: 4.0 * transformProportion),
                            child: new Text(filmLoc,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                    color: new Color(0xFF564C19),
                                    fontFamily: 'Marion',
                                    fontSize: 14.0 * transformProportion,
                                    decoration: TextDecoration.none)),
                          ),
                          new Image.asset(
                            'assets/icons/icon_location.png',
                            width: 12.0 * transformProportion,
                          ),
                        ],
                      )),
                    ],
                  )))
        ],
      ),
    ));
    var dataContainer = new Container(
      margin: new EdgeInsets.symmetric(
        vertical: DesignConstants.rowDataContainerVerticalMargin *
            transformProportion,
        horizontal: DesignConstants.rowDataContainerHorizontalMargin *
            transformProportion,
      ),
      child: new Row(
        children: <Widget>[
          leftSideContainer,
          rightSideContainer,
        ],
      ),
    );

    Widget body = new Container(
        height: DesignConstants.filmRowHeight * transformProportion,
        width: screenWidth,
        child: new Stack(children: [
          background,
          dataContainer,
        ]));

    var deleteSlideAction = new IconSlideAction(
      caption: 'Delete',
      color: Colors.blue,
      icon: Icons.delete,
      onTap: () {
        ConfirmDialog.showConfirmDialog(context,
            "You're going to delete the film from the list. Are you sure??",
            () {
          this.deleteFilmFromList(film.filmId);
        });
      },
    );

    return new GestureDetector(
        onTap: () {
          this.selectFilm(film.filmId);
        },
        child: this.withOptions
            ? new Slidable(
                delegate: new SlidableBehindDelegate(),
                actionExtentRatio: 0.30,
                child: new Container(
                  color: Colors.white,
                  child: body,
                ),
                actions: <Widget>[
                    deleteSlideAction,
                  ],
                secondaryActions: <Widget>[
                    deleteSlideAction,
                  ])
            : body);
  }
}

class FirstRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SliverToBoxAdapter(
      child: Container(
        width: screenWidth,
        color: const Color(0xFFEAEAEA),
        child: new Image.asset(
          'assets/imgs/backFilmFirstRow.png',
          color: new Color(0xFFCC9900),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class LastRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final transformProportion = (screenWidth / DesignConstants.filmRowWidth);

    return SliverToBoxAdapter(
      child: Container(
        height:
            ((DesignConstants.filmRowHeight * transformProportion) / 2) - 1.0,
        color: const Color(0xFFEAEAEA),
        child: new Image.asset(
          'assets/imgs/backFilmLastRow.png',
          color: new Color(0xFFCC9900),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class NoResultsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final transformProportion = (screenWidth / DesignConstants.filmRowWidth);

    return SliverToBoxAdapter(
      child: Container(
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
        ),
      ),
    );
  }
}
