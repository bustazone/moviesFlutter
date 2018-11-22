import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/edit/EditFilmScreenContainer.dart';
import 'package:pelis_busta/feats/edit/components/TextInputWithLabel.dart';
import 'package:pelis_busta/feats/filter/components/LanguageMultiselection.dart';
import 'package:pelis_busta/support/custom_widgets/IconGestureDetector.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class EditFilmScreen extends StatefulWidget {
  final String title;
  final ViewModel vm;

  EditFilmScreen(this.vm, {Key key, this.title}) : super(key: key);

  @override
  State createState() => new EditFilmScreenState();
}

class EditFilmScreenState extends State<EditFilmScreen>
    with TickerProviderStateMixin, RouteAware {
  final TextEditingController _textController = new TextEditingController();

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

  initState() {
    super.initState();
    widget.vm.getFilm();
  }

  goBack() {
    //widget.vm.resetList();
    Navigator.of(context).pop();
  }

  void _handleSubmitted(String text) {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: new Color(0x80CC9900),
          leading: new Container(
            child: new IconButton(
                color: Color(0xFF564C19),
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  goBack();
                }),
          ),
        ),
        body: new Container(
          padding: new EdgeInsets.all(24.0),
          color: const Color(0xFFEAEAEA),
          child: new Column(children: <Widget>[
            new TextInputWithLabel("location", (text){print("location $text");}),
            new TextInputWithLabel("vista", (text){print("vista $text");}),//<---------------------------
            new TextInputWithLabel("formato", (text){print("formato $text");}),
            new TextInputWithLabel("size", (text){print("size $text");}),
            new TextInputWithLabel("imdbId", (text){print("imdbId $text");}),
            new TextInputWithLabel("filmaffinityId", (text){print("filmaffinityId $text");}),
//            new TextInputWithLabel("serie", (text){print("serie $text");}),//<----------------------------
//            new TextInputWithLabel("nombreArchivo", (text){print("nombreArchivo $text");}),
//            new TextInputWithLabel("comentarios", (text){print("comentarios $text");}),
//            new Container(
//              margin: new EdgeInsets.only(top: 5.0),
//              child: new Row(
//                children: <Widget>[
//                  new LanguagesMultiselection(widget.gearWidth,
//                      widget.languages, widget.setLanguages),
//                  new Expanded(child: new Container()),
//                  new LanguagesMultiselection(widget.gearWidth,
//                      widget.subtitles, widget.setSubtitles),
//                ],
//              ),
//            ),
          ]),
        ));
  }
}
