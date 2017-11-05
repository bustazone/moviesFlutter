import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/services/image_provider.dart';
import 'package:pelis_busta/FilmModel.dart';
import 'package:pelis_busta/DesignConstants.dart';
import 'package:pelis_busta/Utils.dart';

//class assetProv extends AssetBundleImageProvider {
//
//  @override
//  Future<AssetBundleImageKey> obtainKey(ImageConfiguration configuration) {
//    return new SynchronousFuture<AssetBundleImageKey>(this);
//  }
//}

List<Widget> fillImageList(
    List<String> inputList, String imagePathFormat, double height, spaced) {
  var list = new List<Widget>();
  for (var g in inputList) {
    Widget image;
    try {
      //image = new Image(image: new ImageProvider<AssetImage>())
      image = new Image.asset(
        imagePathFormat + g + '.png',
        height: height,
        width: height,
      );
    } catch (Exception) {
      image = new Image.asset(
        'assets/languages/fake.png',
        height: height,
        width: height,
      );
    }
    list.add(new Container(
      margin: new EdgeInsets.symmetric(horizontal: spaced),
      child: image,
    ));
  }
  return list;
}

class FilmRow extends StatelessWidget {
  final int itemNum;
  final Film film;

  FilmRow(this.itemNum, this.film);

  @override
  Widget build(BuildContext context) {
    print(itemNum);

    final double screenWidth = MediaQuery.of(context).size.width;
    final transformProportion = (screenWidth / DesignConstants.filmRowWidth);

    List<Widget> listGenderImages = new List();
    List<Widget> listLangs = new List();
    List<Widget> listSubs = new List();
//    int backgroundNumber = 99;
//    //String filmTitle = "El imperio contraataca y su puta madre: Episodio 666.Edición subnormal y toda la ostia",
//    //String filmTitle = "La guerra de las galaxias. Episodio II: El ataque de los clones";
//    String filmTitle = "La guerra";
//    String filmImageURL =
//        'https://pics.filmaffinity.com/cold_skin-120725468-large.jpg';
//    String filmYear = "(" + "1666" + ")";
//    String filmTime = "120" + "'";
//    String filmPunc = "6,6";
//    String filmLoc = "peliculas_666";
    if (!isNullOrEmpty(film.generosStr)) {
      listGenderImages = fillImageList(
          film.generosStr.split(';'),
          'assets/genderIcon/genderIcon_',
          20.0 * transformProportion,
          2.0 * transformProportion);
    }
    if (!isNullOrEmpty(film.idiomasStr)) {
      listLangs = fillImageList(
          film.idiomasStr.split(';'),
          'assets/languages/',
          20.0 * transformProportion,
          2.0 * transformProportion);
    }
    if (!isNullOrEmpty(film.subtitulosStr)) {
      listSubs = fillImageList(
          film.subtitulosStr.split(';'),
          'assets/languages/',
          20.0 * transformProportion,
          2.0 * transformProportion);
    }
    int backgroundNumber = itemNum;
    String filmTitle = film.titulo ?? "";
    String filmImageURL = film.imageUrl ?? "";
    String filmYear = "";
    if (film.year != null) {
      filmYear = "(" + film.year.toString() + ")";
    }
    String filmTime = "";
    if (film.duracion != null) {
      filmTime = film.duracion.toString() + "'";
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
            new Image.asset('assets/imgs/backFilmRow.png'),
            new Container(
              //margin: new EdgeInsets.only(top: 25.0 * transformProportion),
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
            margin:
                new EdgeInsets.symmetric(horizontal: 4.0 * transformProportion),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Image.asset(
                  'assets/icons/icon_audio.png',
                  width: 11.0 * transformProportion,
                ),
                new Expanded(
                    //child: new Container(
                    //    color: Colors.green[300],
                    child: new Row(
                  children: listLangs,
                )
                    //)
                    )
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
                  //child: new Container(
                  //color: Colors.green[500],
                  child: new Row(
                children: listSubs,
              )
                  //)
                  )
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
              child: new Column(
            children: <Widget>[
//              new Expanded(
//                  child:
              new Container(
                height: 35.0 * transformProportion,
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: listGenderImages,
                ),
//              )
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
          ))
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

    return new Container(
        height: DesignConstants.filmRowHeight * transformProportion,
        child: new Stack(
          children: [
            background,
            dataContainer,
          ],
        ));
  }
}
