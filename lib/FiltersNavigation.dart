import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pelis_busta/FilterScreen.dart';

Future goToFilter(context, title, filterState, onReturn) async {
  await Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return new FilterScreen(title: title, currentState: filterState);
      },
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return new FadeTransition(
          opacity: animation,
          child: child,
        );
      }));
  onReturn();
}
