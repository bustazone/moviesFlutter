import 'package:flutter/material.dart';

class PressingButton extends StatefulWidget {
  final image, imageSelected, width, height, onTap;

  PressingButton(this.image, this.imageSelected, this.width, this.height, this.onTap);

  @override
  State createState() {
    return new _PressingButtonState();
  }
}

class _PressingButtonState extends State<PressingButton>
    with TickerProviderStateMixin {
  var currentImage;

  initState() {
    super.initState();
    currentImage = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return //new Opacity(opacity: 0.0, child:
    new GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onTapDown: (tapDetails) {
        setState(() {
          currentImage = widget.imageSelected;
        });
      },
      onTapUp: (tapDetails) {
        setState(() {
          currentImage = widget.image;
        });
      },
      onTapCancel: () {
        setState(() {
          currentImage = widget.image;
        });
      },
      child: new Image.asset(
        currentImage,
        width: widget.width,
        height: widget.height,
      ),
    //)
    );
  }
}
