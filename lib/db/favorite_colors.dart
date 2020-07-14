import 'package:flutter/material.dart';

class FavoriteColors {
  static List<Color> colors = [];

  static bool hasColor(Color color) {
    for (Color c in colors)
      if (c.red == color.red &&
          c.green == color.green &&
          c.blue == color.blue &&
          c.alpha == color.alpha) return true;
    return false;
  }

}
