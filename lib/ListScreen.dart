import 'package:flutter/material.dart';
import 'package:pelis_busta/FilmRow.dart';
import 'package:pelis_busta/FilmModel.dart';
import 'package:pelis_busta/Services.dart';

class ListScreen extends StatefulWidget {
  ListScreen(this.filmFilter, {Key key}) : super(key: key);

  final FilmFilter filmFilter;

  @override
  State<ListScreen> createState() {
    return new ListScreenState();
  }
}

class ListScreenState extends State<ListScreen> {

  bool loadingData = false;
  List<Film> items = new List();

  _getFilms() async {
      loadingData = true;
      List<Film> resp = await postData(widget.filmFilter);
      loadingData = false;
      setState(() {
        items.addAll(resp);
      });
  }

  initState() {
    super.initState();
    widget.filmFilter.page = 0;
    _getFilms();
  }

  Widget getFilmItem(index) {
    if (index > items.length - 10 && !loadingData) {
      widget.filmFilter.page += 1;
      _getFilms();
    }
    return new FilmRow(index, items[index]);
  }

  @override
  Widget build(BuildContext context) {
    //_getFilms();
    return new Container(
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            //new SliverPadding(
              //padding: const EdgeInsets.symmetric(vertical: 24.0),
              //sliver:
              new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (context, index) => getFilmItem(index),
                  childCount: items.length,
                ),
              ),
            //),
          ],
        ),
    );
  }
}