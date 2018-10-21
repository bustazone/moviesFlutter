import 'package:flutter/material.dart';
import 'package:pelis_busta/support/constants/DesignConstants.dart';

typedef void OnTap(bool selected);

class IconGestureDetector extends StatefulWidget {
  final iconIsSelectable,
      iconIsSelected,
      image,
      imageSelected,
      mainGearWidth,
      width;
  final OnTap onTap;

  IconGestureDetector(this.iconIsSelectable, this.iconIsSelected, this.image,
      this.imageSelected, this.width, this.mainGearWidth, this.onTap);

  @override
  State createState() {
    return new _IconGestureDetectorState();
  }
}

class _IconGestureDetectorState extends State<IconGestureDetector>
    with TickerProviderStateMixin {
  var _highlighted = false;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          var futureIsSelested = widget.iconIsSelected;
          if (widget.iconIsSelectable) {
            futureIsSelested = !widget.iconIsSelected;
          }
          widget.onTap(futureIsSelested);
        }
      },
      onTapDown: (tapDetails) {
        setState(() {
          _highlighted = true;
        });
      },
      onTapUp: (tapDetails) {
        setState(() {
          _highlighted = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _highlighted = false;
        });
      },
      child: new Image.asset(
        getCurrentImage(widget.iconIsSelected, _highlighted),
        width:
            (widget.mainGearWidth * widget.width) / DesignConstants.gearWidth,
      ),
    );
  }

  getCurrentImage(selected, highlighted) {
    if (highlighted) {
      return 'assets/imgs/pressedIcon.png';
    } else {
      if (widget.iconIsSelected) {
        return widget.imageSelected;
      } else {
        return widget.image;
      }
    }
  }
}
