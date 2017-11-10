import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final width, height, onTap, selected;

  CustomCheckbox(this.selected, this.width, this.height, this.onTap);

  @override
  State createState() {
    return new _CustomCheckboxState();
  }
}

class _CustomCheckboxState extends State<CustomCheckbox>
    with TickerProviderStateMixin {
  var _highlighted = false;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap(!widget.selected);
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
        getCurrentImage(widget.selected, _highlighted),
        width: widget.width,
        height: widget.height,
      ),
    );
  }

  getCurrentImage(selected, highlighted) {
    if (highlighted) {
      if (selected) {
        return "assets/imgs/checkBox.png";
      } else {
        return "assets/imgs/checkBoxSelected.png";
      }
    } else {
      if (selected) {
        return "assets/imgs/checkBoxSelected.png";
      } else {
        return "assets/imgs/checkBox.png";
      }
    }
  }
}
