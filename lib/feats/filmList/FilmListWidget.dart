import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filmList/FilmRow.dart';
import 'package:pelis_busta/models/Film.dart';

class FilmListWidget extends StatelessWidget {
  final List<Film> filmList;
  final Function() getFilms;
  final Function() resetList;
  final Function(int) selectFilm;
  final bool canQueryMore;
  final Function() getMoreFilms;
  final bool withOptions;
  final Function(int) deleteFilmFromList;

  FilmListWidget(
      this.filmList,
      this.getFilms,
      this.resetList,
      this.selectFilm,
      this.canQueryMore,
      this.getMoreFilms,
      this.withOptions,
      this.deleteFilmFromList,
      {Key key})
      : super(key: key);

  Widget getFilmItem(index, list) {
    if (canQueryMore && list.length > 3 && index > list.length - 10) {
      getMoreFilms();
    }
    return new FilmRow(index, list[index], selectFilm,
        withOptions, deleteFilmFromList);
  }

  @override
  Widget build(BuildContext context) {
    return new CustomScrollView(
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      slivers: <Widget>[
        new FirstRow(),
        (filmList.isEmpty)
            ? new NoResultsRow()
            : new SliverList(
                delegate: new SliverChildBuilderDelegate(
                  (context, index) => getFilmItem(index, filmList),
                  childCount: filmList.length,
                ),
              ),
        new LastRow()
      ],
    );
  }
}
