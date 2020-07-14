import 'package:flutter/material.dart';
import 'dart:convert';
import 'main.dart' as main;

Color initialColor(String iColorMap) {
  if (iColorMap == null) return Colors.blue;
  Map<String, dynamic> map = jsonDecode(iColorMap);
  int red = map['red'];
  int green = map['green'];
  int blue = map['blue'];
  int alpha = map['alpha'];
  return Color.fromARGB(alpha, red, green, blue);
}

String get encodedInitialColor {
  Color color = main.initialColor;
  return jsonEncode({
    'red': color.red,
    'green': color.green,
    'blue': color.blue,
    'alpha': color.alpha,
  });
}
