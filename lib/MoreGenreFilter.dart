import 'package:flutter/material.dart';
import 'package:pelis_busta/CustomCheckbox.dart';
import 'package:pelis_busta/DesignConstants.dart';
import 'package:pelis_busta/FilmModel.dart';
import 'package:pelis_busta/MainFilter.dart';
import 'package:pelis_busta/PressingButton.dart';
import 'package:pelis_busta/Services.dart';
import 'package:pelis_busta/Utils.dart';

class MoreGenresFilter extends StatefulWidget {
  final String title;
  final double gearWidth;

  MoreGenresFilter(this.gearWidth, this.title, {Key key}) : super(key: key);

  @override
  State createState() => new MoreGenresFilterState();
}

class MoreGenresFilterState extends State<MoreGenresFilter>
    with TickerProviderStateMixin {
  List<GenreListItemData> itemsGeneral = new List();
  List<GenreListItemData> itemsSelected = new List();
  List<Gender> resp = new List();

  getItem(int index) {
    if (itemsSelected.length > 0) {
      if (index < itemsSelected.length) {
        return new MoreGenresListItem(itemsSelected[index], widget.gearWidth,
            (selected) {
          changeSelectedValue(itemsSelected[index].id, selected);
          setState(() {});
        });
      } else if (itemsSelected.length > 0 && index == itemsSelected.length) {
        return new MoreGenresListDivisor(widget.gearWidth);
      } else {
        return new MoreGenresListItem(
            itemsGeneral[index - itemsSelected.length - 1], widget.gearWidth,
            (selected) {
          changeSelectedValue(
              itemsGeneral[index - itemsSelected.length - 1].id, selected);
          setState(() {});
        });
      }
    } else {
      return new MoreGenresListItem(itemsGeneral[index], widget.gearWidth,
          (selected) {
        changeSelectedValue(itemsGeneral[index].id, selected);
        setState(() {});
      });
    }
  }

  changeSelectedValue(id, selected) {
    var generos = new MainFilter().filter.generos;
    for (int i = 0; i < generos.length; i++) {
      if (generos[i].id == id) {
        if (!selected) {
          new MainFilter().filter.generos.removeByValues(new Gender(id: id));
        } else {
          return;
        }
      }
    }
    if (selected) {
      new MainFilter().filter.generos.add(new Gender(id: id));
    }
  }

  transformItems(List<Gender> genderList) {
    itemsSelected.clear();
    itemsGeneral.clear();
    var generos = new MainFilter().filter.generos;
    List<int> jj = new List();
    for (Gender g in generos) {
      jj.add(g.id);
    }
    for (Gender g in genderList) {
      bool selected = (jj.indexOf(g.id) != -1);
      if (selected) {
        itemsSelected.add(new GenreListItemData(selected, g));
      }
      itemsGeneral.add(new GenreListItemData(selected, g));
    }
  }

  _reset() {
    for (GenreListItemData g in itemsSelected) {
      new MainFilter().filter.generos.removeByValues(new Gender(id: g.id));
    }
  }

  _getItems() async {
    itemsGeneral.clear();
    itemsSelected.clear();
    resp = await getSubGenresList();
    transformItems(resp);
    setState(() {});
  }

  int _getLenght() {
    if (itemsSelected.length > 0) {
      return itemsSelected.length + 1 + itemsGeneral.length;
    }
    return itemsGeneral.length;
  }

  initState() {
    super.initState();
    _getItems();
  }

  @override
  Widget build(BuildContext context) {
    transformItems(resp);
    return new Positioned(
      child: new Container(
        width: 220.0 * (widget.gearWidth / DesignConstants.gearWidth),
        height: 300.0 * (widget.gearWidth / DesignConstants.gearWidth),
        child: new Column(children: <Widget>[
          new Container(
              width: 137.0 * (widget.gearWidth / DesignConstants.gearWidth),
              height: 24.0 * (widget.gearWidth / DesignConstants.gearWidth),
              child: new Center(
                  child: new Text(
                widget.title,
                style: Theme.of(context).textTheme.display1.copyWith(
                    textBaseline: TextBaseline.alphabetic,
                    color: new Color(0xFF564C19),
                    fontSize:
                        16.0 * (widget.gearWidth / DesignConstants.gearWidth),
                    fontWeight: FontWeight.bold),
              )),
              decoration: new BoxDecoration(
                color: new Color(0xFFCC9900),
                border:
                    new Border.all(color: new Color(0xFF564C19), width: 2.0),
              )),
          new Container(
              margin: new EdgeInsets.only(
                  top: 5.0 * (widget.gearWidth / DesignConstants.gearWidth)),
              padding: new EdgeInsets.only(
                  top: 2.0 * (widget.gearWidth / DesignConstants.gearWidth)),
              width: 207.0 * (widget.gearWidth / DesignConstants.gearWidth),
              height: 207.0 * (widget.gearWidth / DesignConstants.gearWidth),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                      child: new Container(
                    child: new CustomScrollView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        new SliverList(
                          delegate: new SliverChildBuilderDelegate(
                            (context, index) => getItem(index),
                            childCount: _getLenght(),
                          ),
                        ),
                      ],
                    ),
                  )),
                  new Container(
                    height:
                        30.0 * (widget.gearWidth / DesignConstants.gearWidth),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new PressingButton(
                            'assets/imgs/return.png',
                            'assets/imgs/return_selected.png',
                            28.0 *
                                (widget.gearWidth / DesignConstants.gearWidth),
                            28.0 *
                                (widget.gearWidth / DesignConstants.gearWidth),
                            () {
                          Navigator.of(context).pop();
                        }),
                        new PressingButton(
                            'assets/imgs/reset_small.png',
                            'assets/imgs/reset_small_selected.png',
                            28.0 *
                                (widget.gearWidth / DesignConstants.gearWidth),
                            28.0 *
                                (widget.gearWidth / DesignConstants.gearWidth),
                            () {
                          _reset();
                          setState((){});
                        }),
                      ],
                    ),
                  )
                ],
              ),
              decoration: new BoxDecoration(
                color: new Color(0xFFEAEAEA),
                border:
                    new Border.all(color: new Color(0xFF564C19), width: 2.0),
              )),
        ]),
      ),
      left: (widget.gearWidth -
              ((widget.gearWidth * 220.0) / DesignConstants.gearWidth)) /
          2.0,
      top: (widget.gearWidth * 27.0) / DesignConstants.gearWidth,
    );
  }
}

class MoreGenresListDivisor extends StatelessWidget {
  final double gearWidth;

  MoreGenresListDivisor(this.gearWidth);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(2.0 * (gearWidth / DesignConstants.gearWidth)),
      height: 2.0 * (gearWidth / DesignConstants.gearWidth),
      color: new Color(0xFF564C19),
    );
  }
}

class MoreGenresListItem extends StatefulWidget {
  final double gearWidth;
  final GenreListItemData item;
  final onTap;

  MoreGenresListItem(this.item, this.gearWidth, this.onTap, {Key key})
      : super(key: key);

  @override
  State createState() => new MoreGenresListItemState();
}

class MoreGenresListItemState extends State<MoreGenresListItem>
    with TickerProviderStateMixin {
  MoreGenresListItemState();

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(
            padding: new EdgeInsets.all(5.0),
            child: new CustomCheckbox(
                widget.item.selected,
                20.0 * (widget.gearWidth / DesignConstants.gearWidth),
                20.0 * (widget.gearWidth / DesignConstants.gearWidth),
                (selected) {
              widget.onTap(selected);
            })),
        new Flexible(
          child: new Text(
            widget.item.nombre,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.display1.copyWith(
                textBaseline: TextBaseline.alphabetic,
                color: new Color(0xFF564C19),
                fontSize: 14.0 * (widget.gearWidth / DesignConstants.gearWidth),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class GenreListItemData extends Gender {
  bool selected = false;

  GenreListItemData(this.selected, Gender genre)
      : super(id: genre.id, nombre: genre.nombre, tipo: genre.tipo);
}
