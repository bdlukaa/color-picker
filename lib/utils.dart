import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences;

Color get initialColor => _initialColor(preferences.getString('initialColor'));
Color _initialColor(String iColorMap) {
  if (iColorMap == null) return Colors.blue;
  Map<String, dynamic> map = jsonDecode(iColorMap);
  int red = map['red'];
  int green = map['green'];
  int blue = map['blue'];
  int alpha = map['alpha'];
  return Color.fromARGB(alpha, red, green, blue);
}

extension colorEncode on Color {
  String get encoded => json.encode({
        'red': red,
        'green': green,
        'blue': blue,
        'alpha': alpha,
      });
}

Widget buildCompactIconButton({
  @required Widget icon,
  @required VoidCallback onPressed,
  String tooltip,
}) {
  return IconButton(
    icon: icon,
    tooltip: tooltip,
    onPressed: onPressed,
    padding: EdgeInsets.zero,
    visualDensity: VisualDensity.compact,
    splashRadius: 25,
    constraints: BoxConstraints(maxWidth: 28),
  );
}
