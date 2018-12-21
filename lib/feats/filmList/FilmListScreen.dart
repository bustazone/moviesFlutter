import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filmList/FilmListViewModel.dart';
import 'package:pelis_busta/feats/filmList/FilmListWidget.dart';
import 'package:pelis_busta/feats/filmList/FilmRow.dart';
import 'package:pelis_busta/loading_screen_component/LoadingScaffoldWrapperWidget.dart';

class FilmListScreen extends StatefulWidget {
  FilmListScreen(this.vm, {Key key}) : super(key: key);

  final ViewModel vm;

  @override
  State<FilmListScreen> createState() {
    return new FilmListScreenState();
  }
}

class FilmListScreenState extends State<FilmListScreen> {
  bool loadingData;

  initState() {
    super.initState();
    loadingData = widget.vm.loadingData;
    widget.vm.getFilms();
  }

  reload() {
    widget.vm.resetList();
    widget.vm.getFilms();
  }

  Widget getFilmItem(index, list) {
    if (widget.vm.canQueryMore &&
        list.length > 3 &&
        index > list.length - 10 &&
        !loadingData) {
      widget.vm.getMoreFilms();
    }
    if (index == 0) {
      return new FirstRow();
    } else if (index == list.length - 1) {
      return new LastRow();
    } else {
      if (list[index] == null) {
        return new NoResultsRow();
      } else {
        return new FilmRow(index, list[index], widget.vm.selectFilm);
      }
    }
  }

  goBack() {
    widget.vm.resetList();
    Navigator.of(context).pop();
  }

  Future<bool> _handleBack() async {
    goBack();
    return false;
  }

  _getBody() {
    loadingData = widget.vm.loadingData;
    var list = List.from(widget.vm.filmList);
    if (list.length == 0) {
      list.addAll([null, null, null]);
    } else {
      list = [null];
      list.addAll(widget.vm.filmList);
      list.add(null);
    }
    return new Container(
        color: const Color(0xFFCC9900),
        child: new Stack(
          children: <Widget>[
            FilmListWidget(
                widget.vm.filmList,
                () {
                  if (loadingData) {
                    widget.vm.getFilms();
                  }
                },
                () {
                  widget.vm.resetList();
                },
                (id) {
                  widget.vm.selectFilm(id);
                },
                widget.vm.canQueryMore,
                () {
                  if (!loadingData) {
                    widget.vm.getMoreFilms();
                  }
                }),
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
                              goBack();
                            }),
                      ),
                      new Expanded(child: new Container()),
                    ],
                  )),
              top: MediaQuery.of(context).padding.top,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
          _handleBack();
        },
        child: new LoadingScaffoldWrapperWidget(
            showLoader: widget.vm.showLoader, body: _getBody));
  }
}
