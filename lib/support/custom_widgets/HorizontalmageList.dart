import 'package:flutter/material.dart';
import 'package:pelis_busta/support/utils/ImageUtils.dart';

class HorizontalImageList extends StatelessWidget {
  final List<String> inputList;
  final String imagePathFormat;
  final double height;
  final double spaced;
  final MainAxisAlignment mainAxisAlignment;

  HorizontalImageList(
      this.inputList, this.imagePathFormat, this.height, this.spaced,
      {Key key, this.mainAxisAlignment = MainAxisAlignment.start})
      : super(key: key);

  List<Widget> _fillImageList() {
    var list = new List<Widget>();
    for (var g in inputList) {
      list.add(new Container(
        margin: new EdgeInsets.symmetric(horizontal: spaced),
        child: new Image.asset(
          getPathForImage(imagePathFormat, g),
          height: height,
          width: height,
        ),
      ));
    }
    return list;
  }

  @override
  build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment,
      children: _fillImageList(),
    );
  }
}
