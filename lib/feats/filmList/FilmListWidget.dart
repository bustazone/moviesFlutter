import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filmList/FilmRow.dart';
import 'package:pelis_busta/models/Film.dart';

class FilmListWidget extends StatefulWidget {
  final List<Film> filmList;
  final Function() getFilms;
  final Function() resetList;
  final Function(int) selectFilm;
  final bool canQueryMore;
  final Function() getMoreFilms;

  FilmListWidget(this.filmList, this.getFilms, this.resetList, this.selectFilm,
      this.canQueryMore, this.getMoreFilms,
      {Key key})
      : super(key: key);

  @override
  State<FilmListWidget> createState() {
    return new FilmListWidgetState();
  }
}

class FilmListWidgetState extends State<FilmListWidget> {
  initState() {
    super.initState();
    widget.getFilms();
  }

  Widget getFilmItem(index, list) {
    if (widget.canQueryMore && list.length > 3 && index > list.length - 10) {
      widget.getMoreFilms();
    }
    if (index == 0) {
      return new FirstRow();
    } else if (index == list.length - 1) {
      return new LastRow();
    } else {
      if (list[index] == null) {
        return new NoResultsRow();
      } else {
        return new FilmRow(index, list[index], widget.selectFilm);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var list = List.from(widget.filmList);
    if (list.length == 0) {
      list.addAll([null, null, null]);
    } else {
      list = [null];
      list.addAll(widget.filmList);
      list.add(null);
    }
    return new CustomScrollView(
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      slivers: <Widget>[
        new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (context, index) => getFilmItem(index, list),
            childCount: list.length,
          ),
        ),
      ],
    );
  }
}
