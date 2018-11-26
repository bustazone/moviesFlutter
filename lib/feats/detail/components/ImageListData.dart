import 'package:flutter/material.dart';
import 'package:pelis_busta/support/custom_widgets/HorizontalmageList.dart';

class ImageListData extends StatelessWidget {
  final String name;
  final List<String> inputList;
  final String imagePathFormat;
  final double sizeItem;
  final double spaceBetween;

  const ImageListData(this.name, this.inputList, this.imagePathFormat,
      {Key key, this.sizeItem = 30.0, this.spaceBetween = 8.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: new EdgeInsets.all(16.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                name,
                style: new TextStyle(color: Color(0xFFCC9900), fontSize: 14),
              ),
              Container(
                  margin: new EdgeInsets.only(top: 8.0),
                  child: HorizontalImageList(
                      inputList, imagePathFormat, sizeItem, spaceBetween)),
            ]));
  }
}
