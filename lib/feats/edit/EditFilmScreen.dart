import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/edit/EditFilmScreenContainer.dart';
import 'package:pelis_busta/feats/edit/components/CheckBoxInputWithLabel.dart';
import 'package:pelis_busta/feats/edit/components/TextInputWithLabel.dart';
import 'package:pelis_busta/feats/filter/components/LanguagesMultiselectionList.dart';
import 'package:pelis_busta/components/loading_screen_component/LoadingScaffoldWrapperWidget.dart';
import 'package:pelis_busta/models/LanguageList.dart';

class EditFilmScreen extends StatefulWidget {
  final String title;
  final ViewModel vm;

  EditFilmScreen(this.vm, {Key key, this.title}) : super(key: key);

  @override
  State createState() => new EditFilmScreenState();
}

class EditFilmScreenState extends State<EditFilmScreen>
    with TickerProviderStateMixin {
  initState() {
    super.initState();
  }

  goBack() {
    //widget.vm.resetList();
    Navigator.of(context).pop();
  }

  _getBody() {
    return new Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
                new TextInputWithLabel("location", (text) {
                  widget.vm.setLocation(text);
                }, widget.vm.location),
                new CheckBoxInputWithLabel("vista", (selected) {
                  widget.vm.setVista(selected);
                }, widget.vm.vista), //<---------------------------
                new TextInputWithLabel("formato", (text) {
                  widget.vm.setFormato(text);
                }, widget.vm.formato),
                new TextInputWithLabel("size", (amount) {
                  widget.vm.setSize(int.parse(amount));
                }, widget.vm.size == null
                        ? ""
                        : widget.vm.size.toString()),
                new TextInputWithLabel("imdbId", (text) {
                  widget.vm.setImdbId(text);
                }, widget.vm.imdbId),
                new TextInputWithLabel("filmaffinityId", (text) {
                  widget.vm.setFilmaffinityId(text);
                }, widget.vm.filmaffinityId),
                new CheckBoxInputWithLabel("serie", (selected) {
                  widget.vm.setSerie(selected);
                }, widget.vm.serie), //
                new CheckBoxInputWithLabel("serie completa", (selected) {
                  widget.vm.setCompleted(selected);
                }, widget.vm.completed),
                new TextInputWithLabel("nombreArchivo", (text) {
                  widget.vm.setNombreArchivo(text);
                }, widget.vm.nombreArchivo),
                new TextInputWithLabel("comentarios", (text) {
                  widget.vm.setComentarios(text);
                }, widget.vm.comentarios),
                new Container(
                  margin: new EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 40.0),
                  height: 200,
                  width: 300,
                  child: new Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          new Container(
                            margin: new EdgeInsets.symmetric(vertical: 8),
                            child: new Center(
                                child: new Text(
                              "languages",
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                      textBaseline: TextBaseline.alphabetic,
                                      color: new Color(0xFF564C19),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                            )),
                          ),
                          Expanded(
                              child: new Container(
                            decoration: BoxDecoration(
                              border: new Border.all(
                                  color: new Color(0xffcc9900), width: 2.0),
                            ),
                            width: 70,
                            child: LanguagesMultiselectionList(
                                LanguageList(l: widget.vm.idiomas), (values) {
                              widget.vm.setIdiomas(values);
                            }, widget.vm.allLangs),
                          ))
                        ],
                      ),
                      Expanded(child: new Container()),
                      Column(
                        children: <Widget>[
                          new Container(
                            margin: new EdgeInsets.symmetric(vertical: 8),
                            child: new Center(
                                child: new Text(
                              "subtitles",
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                      textBaseline: TextBaseline.alphabetic,
                                      color: new Color(0xFF564C19),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                            )),
                          ),
                          Expanded(
                              child: new Container(
                            decoration: BoxDecoration(
                              border: new Border.all(
                                  color: new Color(0xffcc9900), width: 2.0),
                            ),
                            width: 70,
                            child: LanguagesMultiselectionList(
                                LanguageList(l: widget.vm.subtitulos),
                                (values) {
                              widget.vm.setSubtitulos(values);
                            }, widget.vm.allSubs),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new LoadingScaffoldWrapperWidget(
        showLoader: widget.vm.showLoader,
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
          actions: <Widget>[
            new IconButton(
                color: Color(0xFF564C19),
                icon: new Icon(Icons.done),
                onPressed: () {
                  widget.vm.uploadChanges((response) {
                    goBack();
                  });
                })
          ],
        ),
        body: _getBody);
  }
}
