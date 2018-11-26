import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/edit/EditFilmScreenContainer.dart';
import 'package:pelis_busta/feats/edit/components/CheckBoxInputWithLabel.dart';
import 'package:pelis_busta/feats/edit/components/TextInputWithLabel.dart';
import 'package:pelis_busta/feats/filter/components/LanguagesMultiselectionList.dart';
import 'package:pelis_busta/loading_screen_component/LoadingScaffoldWrapperWidget.dart';
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
        body: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
                new TextInputWithLabel("location", (text) {
                  widget.vm.setLocation(text);
                }, value: widget.vm.location),
                new CheckBoxInputWithLabel("vista", (selected) {
                  widget.vm.setVista(selected);
                }, value: widget.vm.vista), //<---------------------------
                new TextInputWithLabel("formato", (text) {
                  widget.vm.setFormato(text);
                }, value: widget.vm.formato),
                new TextInputWithLabel("size", (amount) {
                  widget.vm.setSize(int.parse(amount));
                },
                    value: widget.vm.size == null
                        ? ""
                        : widget.vm.size.toString()),
                new TextInputWithLabel("imdbId", (text) {
                  widget.vm.setImdbId(text);
                }, value: widget.vm.imdbId),
                new TextInputWithLabel("filmaffinityId", (text) {
                  widget.vm.setFilmaffinityId(text);
                }, value: widget.vm.filmaffinityId),
                new CheckBoxInputWithLabel("serie", (selected) {
                  widget.vm.setSerie(selected);
                }, value: widget.vm.serie), //<----------------------------
                new TextInputWithLabel("nombreArchivo", (text) {
                  widget.vm.setNombreArchivo(text);
                }, value: widget.vm.nombreArchivo),
                new TextInputWithLabel("comentarios", (text) {
                  widget.vm.setComentarios(text);
                }, value: widget.vm.comentarios),
                new Container(
                  decoration: BoxDecoration(color: Color(0xffffff00)),
                  margin: new EdgeInsets.only(top: 5.0),
                  height: 200,
                  width: 300,
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                          child: new Container(
                        decoration: BoxDecoration(color: Color(0xffff0000)),
                        width: 70,
                        child: LanguagesMultiselectionList(
                            LanguageList(l: widget.vm.idiomas), (values) {
                          widget.vm.setIdiomas(values);
                        }, widget.vm.allLangs),
                      )),
                      Expanded(
                          child: new Container(
                        decoration: BoxDecoration(color: Color(0xff00ff00)),
                      )),
                      Expanded(
                          child: new Container(
                        decoration: BoxDecoration(color: Color(0xff0000ff)),
                        width: 70,
                        child: LanguagesMultiselectionList(
                            LanguageList(l: widget.vm.subtitulos), (values) {
                          widget.vm.setSubtitulos(values);
                        }, widget.vm.allSubs),
                      )),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}
