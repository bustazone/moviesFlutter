import 'dart:async';

import 'package:flutter/widgets.dart';

typedef void VoidFuncArgument();

runAfterDelay(int timeDelay, TickerProvider vsync, VoidFuncArgument function) {
  new Timer(new Duration(milliseconds: timeDelay), () {
    function();
  });
}
