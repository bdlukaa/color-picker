import 'package:flutter/material.dart';

import '../../lang/lang.dart';

Map<String, MaterialColor> primaries(BuildContext context) {
  final lang = Language.of(context);
  return {
    lang.redColor: Colors.red,
    lang.pink: Colors.pink,
    lang.purple: Colors.purple,
    lang.deepPurple: Colors.deepPurple,
    lang.indigo: Colors.indigo,
    lang.blueColor: Colors.blue,
    lang.lightBlue: Colors.lightBlue,
    lang.cyan: Colors.cyan,
    lang.teal: Colors.teal,
    lang.grey: Colors.grey,
    lang.blueGrey: Colors.blueGrey,
    lang.green: Colors.green,
    lang.lightGreen: Colors.lightGreen,
    lang.lime: Colors.lime,
    lang.yellow: Colors.yellow,
    lang.amber: Colors.amber,
    lang.orange: Colors.orange,
    lang.deepOrange: Colors.deepOrange,
    lang.brown: Colors.brown,
  };
}
