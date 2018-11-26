import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/list/FilmRow.dart';
import 'package:pelis_busta/feats/list/ListScreenContainer.dart';
import 'package:pelis_busta/loading_screen_component/LoadingScaffoldWrapperWidget.dart';

class ListScreen extends StatefulWidget {
  ListScreen(this.vm, {Key key}) : super(key: key);

  final ViewModel vm;

  @override
  State<ListScreen> createState() {
    return new ListScreenState();
  }
}

class ListScreenState extends State<ListScreen> {
  initState() {
    super.initState();
    widget.vm.getFilms(widget.vm.randomFilmFilter);
  }

  reload() {
    widget.vm.resetList();
    widget.vm.getFilms(widget.vm.randomFilmFilter);
  }

  Widget getFilmItem(index, list) {
    if (widget.vm.canQueryMore &&
        list.length > 3 &&
        index > list.length - 10 &&
        !widget.vm.loadingData) {
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

  @override
  Widget build(BuildContext context) {
    var list = List.from(widget.vm.filmList);
    if (list.length == 0) {
      list.addAll([null, null, null]);
    } else {
      list = [null];
      list.addAll(widget.vm.filmList);
      list.add(null);
    }
    return new WillPopScope(
        onWillPop: () {
          _handleBack();
        },
        child: new LoadingScaffoldWrapperWidget(
            showLoader: widget.vm.showLoader,
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
                            (context, index) => getFilmItem(index, list),
                            childCount: list.length,
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
                                      goBack();
                                    }),
                              ),
                              new Expanded(child: new Container()),
                            ],
                          )),
                      top: MediaQuery.of(context).padding.top,
                    ),
                  ],
                ))));
  }
}
