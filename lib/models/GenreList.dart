import 'dart:collection';

import 'package:pelis_busta/models/Genre.dart';

class GenreList extends ListBase<Genre> {
  final List<Genre> l = [];

  GenreList();

  set length(int newLength) {
    l.length = newLength;
  }

  int get length => l.length;

  Genre operator [](int index) => l[index];

  void operator []=(int index, Genre value) {
    l[index] = value;
  }

  void removeByValues(Genre g) {
    for (Genre gList in l) {
      if (gList.equals(g)) {
        l.remove(gList);
        return;
      }
    }
  }

  bool hasByValues(Genre g) {
    for (Genre gList in l) {
      if (gList.equals(g)) {
        return true;
      }
    }
    return false;
  }
}
