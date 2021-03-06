import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pelis_busta/components/dialogs/AddFilmToListDialog.dart';
import 'package:pelis_busta/components/loading_screen_component/LoadingScaffoldWrapperWidget.dart';
import 'package:pelis_busta/feats/detail/DetailFilmScreenContainer.dart';
import 'package:pelis_busta/feats/detail/components/ImageListData.dart';
import 'package:pelis_busta/feats/detail/components/TextData.dart';
import 'package:pelis_busta/navigation/OnNavigateRouteCustom/CustomNavigator.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final ViewModel vm;

  DetailScreen(this.vm, {Key key, this.title}) : super(key: key);

  @override
  State createState() => new DetailScreenState();
}

class DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  double kExpandedHeight = 300.0;

  @override
  dispose() {
    super.dispose();
  }

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    widget.vm.getFilm();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
  }

  reload() {
    print("reload");
    widget.vm.getFilm();
  }

  goBack() {
    //widget.vm.resetList();
    Navigator.of(context).pop();
  }

  Color get _appBarTextColor {
    if (_scrollController.hasClients) {
      var minValue = (kExpandedHeight / 2);
      var maxValue = kExpandedHeight - kToolbarHeight;
      var totalRange = maxValue - minValue;
      var currentPoint = _scrollController.offset;
      if (currentPoint < minValue) {
        return Color(0xFFFFFFFF);
      } else if (currentPoint > maxValue) {
        return Color(0xFF564C19);
      } else {
        double percentage =
            (totalRange - (currentPoint - minValue)) / totalRange;
        return Color.lerp(Color(0xFF564C19), Color(0xFFFFFFFF), percentage);
      }
    } else {
      return Color(0xFFFFFFFF);
    }
  }

  double get _scrollLikeProportion {
    if (_scrollController.hasClients) {
      var minValue = (kExpandedHeight / 2);
      var maxValue = kExpandedHeight - kToolbarHeight;
      var totalRange = maxValue - minValue;
      var currentPoint = _scrollController.offset;
      if (currentPoint < minValue) {
        return 1;
      } else if (currentPoint > maxValue) {
        return 0;
      } else {
        double percentage =
            (totalRange - (currentPoint - minValue)) / totalRange;
        return percentage;
      }
    } else {
      return 1;
    }
  }

  Function(String, String) get _getShortedTitle {
    return (String title, String year) {
      final kCharsInTitle = (widget.vm.randomFilmFilter) ? 4 : 10;
      if (title.length > kCharsInTitle && _scrollController.hasClients) {
        var minValue = (kExpandedHeight / 2);
        var maxValue = kExpandedHeight - kToolbarHeight;
        var totalRange = maxValue - minValue;
        var currentPoint = _scrollController.offset;
        if (currentPoint < minValue) {
          return "$title ${year == null ? "" : "(${year})"}".trim();
        } else if (currentPoint > maxValue) {
          return "${title.substring(0, kCharsInTitle)}... ${year == null ? "" : "($year)"}"
              .trim();
        } else {
          double percentage =
              (totalRange - (currentPoint - minValue)) / totalRange;
          return "${title.substring(0, kCharsInTitle + ((title.length - kCharsInTitle) * percentage).round())}... ${year == null ? "" : "(${year})"}"
              .trim();
        }
      } else {
        return "$title ${year == null ? "" : "($year)"}".trim();
      }
    };
  }

  Container _getGradient() {
    final topOffset = kExpandedHeight * 0.7;
    final height = kExpandedHeight - topOffset;
    var top = MediaQuery.of(context).padding.top + topOffset;
    if (_scrollController.hasClients) {
      top = MediaQuery.of(context).padding.top +
          topOffset -
          (_scrollController.offset * (3 / 4));
    }
    return new Container(
      margin: new EdgeInsets.only(top: top < 0 ? 0 : top),
      height: height < 0 ? 0 : height,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[new Color(0x00CC9900), new Color(0xFFCC9900)],
          stops: [0.0, 1.0],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget _getReloadButton() {
    if (widget.vm.randomFilmFilter) {
      return new Container(
          margin: new EdgeInsets.symmetric(horizontal: 4.0),
          child: new IconButton(
              color: _appBarTextColor,
              icon: new Icon(Icons.repeat),
              onPressed: () {
                reload();
              }));
    } else {
      return new Container();
    }
  }

  Widget _getEditButton() {
    return new Container(
        margin: new EdgeInsets.symmetric(horizontal: 4.0),
        child: new IconButton(
            color: _appBarTextColor,
            icon: new Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(EditRouteName);
            }));
  }

  Widget _getAddToListButton() {
    return new Container(
        margin: new EdgeInsets.symmetric(horizontal: 4.0),
        child: new IconButton(
            color: _appBarTextColor,
            icon: new Icon(Icons.playlist_add),
            onPressed: () {
              AddFilmToListDialogContainer.showAddFilmToListDialog(
                  context, widget.vm.film.filmId);
            }));
  }

  List<Widget> _getDataWidgetList() {
    List<Widget> listOutput = <Widget>[];
    if (widget.vm.film != null) {
      if (widget.vm.film.duration != null) {
        listOutput.add(TextData("Time", widget.vm.film.duration.toString()));
      }
      if (widget.vm.film.punctuation != null) {
        listOutput.add(TextData("Rate", widget.vm.film.punctuation.toString()));
      }
      if (widget.vm.film.location != null) {
        listOutput.add(TextData("Location", widget.vm.film.location));
      }
      if (!isNullOrEmpty(widget.vm.film.languages)) {
        List<String> h = widget.vm.film.languages.map((lang) {
          return lang.code;
        }).toList();
        listOutput.add(ImageListData("Languages", h, 'assets/languages/'));
      }
      if (!isNullOrEmpty(widget.vm.film.subtitles)) {
        List<String> h = widget.vm.film.subtitles.map((lang) {
          return lang.code;
        }).toList();
        listOutput.add(ImageListData("Subtitles", h, 'assets/languages/'));
      }
      if (!isNullOrEmpty(widget.vm.film.genres)) {
        List<String> h = widget.vm.film.genres.where((genre) {
          return genre.type == 'principal';
        }).map((genre) {
          return genre.id.toString();
        }).toList();
        listOutput.add(ImageListData(
          "Genres",
          h,
          'assets/genderIcon/genderIcon_',
          sizeItem: 48.0,
        ));
      }
      if (widget.vm.film.director != null) {
        listOutput.add(TextData("Director", widget.vm.film.director));
      }
      if (widget.vm.film.director != null) {
        listOutput.add(TextData("Cast", widget.vm.film.mainCast));
      }
      if (widget.vm.film.plot != null) {
        listOutput.add(TextData("Plot", widget.vm.film.plot));
      }
    }
    return listOutput;
  }

  _getBody() {
    return new Container(
        color: const Color(0xFFEAEAEA),
        child: new Stack(children: <Widget>[
          new CustomScrollView(controller: _scrollController, slivers: <Widget>[
            SliverAppBar(
                forceElevated: true,
                pinned: true,
                backgroundColor: new Color(0x80CC9900),
                expandedHeight: kExpandedHeight,
                leading: new Container(
                  child: new IconButton(
                      color: _appBarTextColor,
                      icon: new Icon(Icons.arrow_back),
                      onPressed: () {
                        goBack();
                      }),
                ),
                actions: <Widget>[
                  _getAddToListButton(),
                  _getEditButton(),
                  _getReloadButton()
                ],
                flexibleSpace: FlexibleSpaceBar(
                    title: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width -
                            (190 * _scrollLikeProportion),
                      ),
                      child: Text(
                        _getShortedTitle(
                          widget.vm.film != null ? widget.vm.film.title : "",
                          widget.vm.film != null
                              ? widget.vm.film.year.toString()
                              : "",
                        ),
                        style: new TextStyle(color: _appBarTextColor),
                      ),
                    ),
                    background: new Stack(children: <Widget>[
                      new Positioned.fill(
                        child: (widget.vm.film != null &&
                                widget.vm.film.imageUrl != null)
                            ? new Image.network(
                                widget.vm.film.imageUrl,
                                fit: BoxFit.cover,
                                //height: DesignConstants.imageFilmRowHeight * transformProportion,
                              )
                            : new Container(),
                      ),
                      _getGradient()
                    ]))),
            SliverList(
              delegate: SliverChildListDelegate(_getDataWidgetList()),
            )
          ]),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    kExpandedHeight = MediaQuery.of(context).size.height * 0.7;
    return new LoadingScaffoldWrapperWidget(
        showLoader: widget.vm.showLoader, body: _getBody);
  }
}
