import 'package:flutter/material.dart';
import 'package:pelis_busta/models/Language.dart';
import 'package:pelis_busta/support/custom_widgets/CustomCheckbox.dart';

class LanguageListItem extends StatefulWidget {
  final LanguageListItemData item;
  final onTap;

  LanguageListItem(this.item, this.onTap, {Key key}) : super(key: key);

  @override
  State createState() => new LanguageListItemState();
}

class LanguageListItemState extends State<LanguageListItem>
    with TickerProviderStateMixin {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget image;
    try {
      //image = new Image(image: new ImageProvider<AssetImage>())
      image = new Image.asset(
        'assets/languages/' + widget.item.codigo + '.png',
        height: 30.0,
        width: 30.0,
      );
    } catch (Exception) {
      image = new Image.asset(
        'assets/languages/fake.png',
        height: 30.0,
        width: 30.0,
      );
    }
    return new Row(
      children: <Widget>[
        new Container(
            padding: new EdgeInsets.all(5.0),
            child: new CustomCheckbox(widget.item.selected, (selected) {
              widget.onTap(selected);
            })),
        new Container(
          margin: new EdgeInsets.symmetric(horizontal: 1.0),
          child: image,
        ),
      ],
    );
  }
}

class ListDivisor extends StatelessWidget {
  ListDivisor();

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(2.0),
      height: 2.0,
      color: new Color(0xFF564C19),
    );
  }
}

class LanguageListItemData extends Language {
  bool selected = false;

  LanguageListItemData(this.selected, Language language)
      : super(codigo: language.codigo, nombre: language.nombre);
}
