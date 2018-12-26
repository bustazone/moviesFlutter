import 'package:flutter/material.dart';
import 'package:pelis_busta/components/loading_screen_component/LoadingScaffoldWrapperWidget.dart';
import 'package:pelis_busta/feats/filmList/FilmListViewModel.dart';
import 'package:pelis_busta/feats/filmList/FilmListWidget.dart';
import 'package:pelis_busta/navigation/OnNavigateRouteCustom/CustomNavigator.dart';

class FilmListScreen extends StatefulWidget {
  FilmListScreen(this.vm, {Key key}) : super(key: key);

  final ViewModel vm;

  @override
  State<FilmListScreen> createState() {
    return new FilmListScreenState();
  }
}

class FilmListScreenState extends State<FilmListScreen> {

  BuildContext context;

  initState() {
    super.initState();
    widget.vm.getFilms();
  }

  goBack() {
    widget.vm.resetList();
    Navigator.of(context).pop();
  }

  Future<bool> _handleBack() async {
    goBack();
    return false;
  }

  _body() => new Scaffold(
      body: Container(
          color: const Color(0xFFCC9900),
          child: new Stack(
            children: <Widget>[
              FilmListWidget(
                  widget.vm.filmList,
                      () {
                    if (widget.vm.loadingData) {
                      widget.vm.getFilms();
                    }
                  },
                      () {
                    widget.vm.resetList();
                  },
                      (id) {
                    widget.vm.selectFilm(id);
                    Navigator.of(context).pushNamed(DetailRouteName);
                  },
                  widget.vm.canQueryMore,
                      () {
                    if (!widget.vm.loadingData) {
                      widget.vm.getMoreFilms();
                    }
                  },
                  widget.vm.dismissable,
                  widget.vm.onDismiss),
              new Positioned(
                child: new Container(
                    color: new Color(0x80CC9900),
                    width: MediaQuery.of(context).size.width,
                    height: new AppBar().preferredSize.height,
                    child: new Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
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
          )));

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new WillPopScope(
        onWillPop: () {
          _handleBack();
        },
//        child: Stack(
//          children: <Widget>[
//            _body()
////            Material(child: ProgressScreen()),
//          ],
//        ));
//  }
//}

      child: new LoadingScaffoldWrapperWidget(
        showLoader: widget.vm.showLoader,
        body: _body,
      ),
    );
  }
}
