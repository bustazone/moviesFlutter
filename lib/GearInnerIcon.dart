import 'package:flutter/material.dart';
import 'package:pelis_busta/DesignConstants.dart';

typedef void OnTap(bool selected);
typedef void ScalesCallback();

class GearInnerIcon extends StatefulWidget {
  final image,
      imageSelected,
      posX,
      posY,
      mainGearWidth,
      selectable,
      selected;
  final ScalesCallback scaleCallback;
  final OnTap onTap;
  final AnimationController controller;

  GearInnerIcon(this.image, this.imageSelected, this.posX,
      this.posY, this.mainGearWidth, this.controller,
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

  factory GearInnerIcon.selectableIcon(image, imageSelected, posX,
      posY, mainGearWidth, controller, OnTap onTap, selected) {
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
      animationIcons.addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          if (pushed) {
            //widget.scaleCallback();
          }
        }
      });
    }
  }

  @override
  build(BuildContext context) {
    bool iconIsActive = widget.selected != null ? widget.selected : false;
    bool iconIsSelectable = widget.selectable != null ? widget.selectable : false;
    return new Positioned(
      child: new ScaleTransition(
        scale: animationIcons,
        child: new IconGestureDetector(
            iconIsSelectable, iconIsActive, widget.image, widget.imageSelected, widget.mainGearWidth,
            (selected) {
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

class IconGestureDetector extends StatefulWidget {
  final iconIsSelectable, iconIsSelected, image, imageSelected, mainGearWidth;
  final OnTap onTap;

  IconGestureDetector(this.iconIsSelectable, this.iconIsSelected, this.image,
      this.imageSelected, this.mainGearWidth, this.onTap);

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
        width: (widget.mainGearWidth * DesignConstants.gearHoleWidth) /
            DesignConstants.gearWidth,
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

  @override
  dispose() {
    super.dispose();
  }
}

//class GearInnerIconTest extends StatefulWidget {
//  @override
//  State createState() => new GearInnerIconTestState();
//}
//
//class GearInnerIconTestState extends State<GearInnerIconTest>
//    with SingleTickerProviderStateMixin {
//  var controller;
//  var animation;
//
//  initState() {
//    super.initState();
//    controller = new AnimationController(
//        duration: const Duration(milliseconds: 1000), vsync: this);
//    Curve cur = new Cubic(.87,.75,.88,1.6);
//    final Animation curve = new CurvedAnimation(parent: controller, curve: cur);
//    animation = new Tween(begin: 0.0, end: 1.0).animate(curve);
//    controller.forward();
//  }
//
//  @override
//  build(BuildContext context) {
//    return new Column(children: <Widget>[
////      new pos('assets/imgs/romance.png', 'assets/imgs/action.png', 100, 100, 400, (){}, controller, () {
////      Dialog sb = new Dialog(child: new Text("Tapped UP!!!"));
////      showDialog(context: context, child: sb);
////    })
////    ]);
//    ]);
//  }
//
//dispose() {
//  controller.dispose();
//  super.dispose();
//}
//}
