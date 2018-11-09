import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/list/FilmRow.dart';
import 'package:pelis_busta/models/Film.dart';
import 'package:pelis_busta/models/FilmFilter.dart';
import 'package:pelis_busta/feats/list/ProgressScreen.dart';
import 'package:pelis_busta/support/services/Services.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class ListScreen extends StatefulWidget {
  ListScreen(this.filmFilter, this.queryMore, {Key key}) : super(key: key);

  final bool queryMore;
  final FilmFilter filmFilter;

  @override
  State<ListScreen> createState() {
    return new ListScreenState();
  }
}

class ListScreenState extends State<ListScreen> {
  bool queryMore = true;
  bool loadingData = false;
  bool firstQuery = true;
  List<Film> items = new List();

  _getFilms() async {
    loadingData = true;
    List<Film> resp = await getItemsList(widget.filmFilter);
    loadingData = false;
    firstQuery = false;
    if (!isNullOrEmpty(resp)) {
      setState(() {
        items.insertAll(items.length - 1, resp);
      });
    } else {
      if (items.length == 2) {
        setState(() {
          items.insert(items.length - 1, null);
        });
      }
      queryMore = false;
      setState(() {});
    }
  }

  initState() {
    super.initState();
    firstQuery = true;
    queryMore = widget.queryMore;
    widget.filmFilter.page = 0;
    items.add(new Film());
    items.add(new Film());
    if (!loadingData) {
      loadingData = true;
      _getFilms();
    }
  }

  reload() {
    items.clear();
    firstQuery = true;
    queryMore = widget.queryMore;
    widget.filmFilter.page = 0;
    items.add(new Film());
    items.add(new Film());
    if (!loadingData) {
      loadingData = true;
      _getFilms();
    }
  }

  Widget getFilmItem(index) {
    if (queryMore &&
        items.length > 2 &&
        index > items.length - 10 &&
        !loadingData) {
      loadingData = true;
      widget.filmFilter.page += 1;
      _getFilms();
    }
    if (index == 0) {
      return new FirstRow();
    } else if (index == items.length - 1) {
      return new LastRow();
    } else {
      if (items[index] == null) {
        return new NoResultsRow();
      } else {
        return new FilmRow(index, items[index]);
      }
    }
  }

  Widget _getReloadButton() {
    if (widget.filmFilter.randomFilm) {
      return new Container(
          margin: new EdgeInsets.symmetric(horizontal: 4.0),
          child: new IconButton(
              color: new Color(0xFF564C19),
              icon: new Icon(Icons.repeat),
              onPressed: () {
                reload();
              }));
    } else {
      return new Container();
    }
  }

  Widget _getLoadingScreen() {
    if (loadingData && firstQuery) {
      return new ProgressScreen();
    } else {
      return new Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            color: const Color(0xFFCC9900),
            child: new Stack(
              children: <Widget>[
                new CustomScrollView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  slivers: <Widget>[
                    new SliverList(
                      delegate: new SliverChildBuilderDelegate(
                        (context, index) => getFilmItem(index),
                        childCount: items.length,
                      ),
                    ),
                  ],
                ),
                new Positioned(
                  child: new Container(
                      color: new Color(0x80CC9900),
                      width: MediaQuery.of(context).size.width,
                      height: new AppBar().preferredSize.height,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Container(
                            child: new IconButton(
                                color: new Color(0xFF564C19),
                                icon: new Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                          ),
                          new Expanded(child: new Container()),
                          _getReloadButton(),
                        ],
                      )),
                  top: MediaQuery.of(context).padding.top,
                ),
                new Positioned(
                  child: new Container(
                    color: new Color(0xFFCC9900),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).padding.top,
                  ),
                ),
                _getLoadingScreen(),
              ],
            )));
  }
}