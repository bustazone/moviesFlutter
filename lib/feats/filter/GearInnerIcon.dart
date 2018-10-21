import 'package:flutter/material.dart';
import 'package:pelis_busta/support/constants/DesignConstants.dart';
import 'package:pelis_busta/support/custom_widgets/IconGestureDetector.dart';

typedef void ScalesCallback();

class GearInnerIcon extends StatefulWidget {
  final image, imageSelected, posX, posY, mainGearWidth, selectable, selected;
  final ScalesCallback scaleCallback;
  final OnTap onTap;
  final AnimationController controller;

  GearInnerIcon(this.image, this.imageSelected, this.posX, this.posY,
      this.mainGearWidth, this.controller,
      {this.selectable, this.selected, this.onTap, this.scaleCallback});

  factory GearInnerIcon.mainButton(image, imageSelected, posX, posY,
      mainGearWidth, controller, ScalesCallback scaleCallback, selected) {
    return new GearInnerIcon(
      image,
      imageSelected,
      posX,
      posY,
      mainGearWidth,
      controller,
      scaleCallback: scaleCallback,
      selectable: false,
      selected: selected,
    );
  }

  factory GearInnerIcon.selectableIcon(image, imageSelected, posX, posY,
      mainGearWidth, controller, OnTap onTap, selected) {
    return new GearInnerIcon(
      image,
      imageSelected,
      posX,
      posY,
      mainGearWidth,
      controller,
      onTap: onTap,
      selectable: true,
      selected: selected,
    );
  }

  @override
  State createState() {
    return new GearInnerIconState();
  }
}

class GearInnerIconState extends State<GearInnerIcon> {
  var animationIcons;
  var pushed = false;

  initState() {
    super.initState();
    if (widget.controller != null) {
      Curve curIcons = new Cubic(.87, .75, .88, 1.6);
      final Animation curveIcons =
          new CurvedAnimation(parent: widget.controller, curve: curIcons);
      animationIcons = new Tween(begin: 0.0, end: 1.0).animate(curveIcons);
    }
  }

  @override
  build(BuildContext context) {
    bool iconIsActive = widget.selected != null ? widget.selected : false;
    bool iconIsSelectable =
        widget.selectable != null ? widget.selectable : false;
    return new Positioned(
      child: new ScaleTransition(
        scale: animationIcons,
        child: new IconGestureDetector(
            iconIsSelectable,
            iconIsActive,
            widget.image,
            widget.imageSelected,
            DesignConstants.gearHoleWidth,
            widget.mainGearWidth, (selected) {
          if (widget.onTap != null) {
            widget.onTap(selected);
          }
          if (widget.controller != null && !iconIsSelectable) {
//            widget.animation.addStatusListener((status) {
//              if (status == AnimationStatus.dismissed) {
            widget.scaleCallback();
//              }
//            });
            pushed = true;
            widget.controller.reverse();
          }
        }),
      ),
      left: (widget.mainGearWidth * widget.posX) / DesignConstants.gearWidth,
      top: (widget.mainGearWidth * widget.posY) / DesignConstants.gearWidth,
    );
  }
}
