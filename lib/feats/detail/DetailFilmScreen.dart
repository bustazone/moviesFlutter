import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:pelis_busta/feats/detail/DetailFilmScreenContainer.dart';
import 'package:pelis_busta/feats/detail/components/TextData.dart';
import 'package:pelis_busta/navigation/OnNavigateRouteCustom/CustomNavigator.dart';
import 'package:pelis_busta/support/custom_widgets/ProgressScreen.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class DetailScreen extends StatefulWidget {
  final String title;
  final ViewModel vm;

  DetailScreen(this.vm, {Key key, this.title}) : super(key: key);

  @override
  State createState() => new DetailScreenState();
}

class DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin, RouteAware {
  double kExpandedHeight = 300.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    print("didPush");
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    print("didPopNext");
  }

  @override
  dispose() {
    routeObserver.unsubscribe(this);
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

  Color get _AppBarTextColor {
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
      return 0;
    }
  }

  bool get _showTitle {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  Function(String, int) get _getShortedTitle {
    return (String title, int year) {
      final kCharsInTitle = 10;
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
    if (_scrollController.hasClients) {
      final height = kExpandedHeight - topOffset;
      final top = MediaQuery.of(context).padding.top +
          topOffset -
          (_scrollController.offset * (3 / 4));
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
    } else {
      return new Container();
    }
  }

  Widget _getReloadButton() {
    if (widget.vm.randomFilmFilter) {
      return new Container(
          margin: new EdgeInsets.symmetric(horizontal: 4.0),
          child: new IconButton(
              color: _AppBarTextColor,
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
            color: _AppBarTextColor,
            icon: new Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(EditRouteName);
            }));
  }

  Widget _getLoadingScreen() {
    if (widget.vm.loadingData) {
      return new ProgressScreen();
    } else {
      return new Container();
    }
  }

  List<Widget> _getDataWidgetList() {
    List<Widget> listOutput = <Widget>[];
    if (widget.vm.film.director != null) {
      listOutput.add(TextData("Director", widget.vm.film.director));
    }
    if (widget.vm.film.director != null) {
      listOutput.add(TextData("Cast", widget.vm.film.casts));
    }
    if (widget.vm.film.plot != null) {
      listOutput.add(TextData("Plot", widget.vm.film.plot));
    }
    return listOutput;
  }

  @override
  Widget build(BuildContext context) {
    kExpandedHeight = MediaQuery.of(context).size.height * 0.7;

    if (widget.vm.film != null) {
      return new Scaffold(
          body: new Container(
              color: const Color(0xFFEAEAEA),
              child: new Stack(children: <Widget>[
                new CustomScrollView(controller: _scrollController, slivers: <
                    Widget>[
                  SliverAppBar(
                      forceElevated: true,
                      pinned: true,
                      backgroundColor: new Color(0x80CC9900),
                      expandedHeight: kExpandedHeight,
                      leading: new Container(
                        child: new IconButton(
                            color: _AppBarTextColor,
                            icon: new Icon(Icons.arrow_back),
                            onPressed: () {
                              goBack();
                            }),
                      ),
                      actions: <Widget>[_getEditButton(), _getReloadButton()],
                      flexibleSpace: FlexibleSpaceBar(
                          title: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width -
                                  (190 * _scrollLikeProportion),
                            ),
                            child: Text(
                              _getShortedTitle(
                                  widget.vm.film.titulo, widget.vm.film.year),
                              style: new TextStyle(color: _AppBarTextColor),
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
                new Positioned(
                  child: new Container(
                    color: new Color(0xFFCC9900),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).padding.top,
                  ),
                ),
                _getLoadingScreen()
              ])));
    } else {
      return _getLoadingScreen();
    }
  }

//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//        body: new Container(
//          color: const Color(0xFFEAEAEA),
//          child: new Center(
//            child: new Text(widget.vm.film != null ? widget.vm.film.toString() : ""),
//          ),
//        ));
//  }
}
