import 'package:flutter/material.dart';

import 'colors.dart';
import 'named_picker_extend.dart';

class NamedPickerHome extends StatelessWidget {
  NamedPickerHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = primaries(context);
    return ListView.builder(
      itemCount: colors.length,
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
        bottom: 35,
      ),
      itemBuilder: (context, index) {
        final name = colors.keys.toList()[index];
        final color = colors.values.toList()[index];
        return NamedPickerTile(
          color: color,
          title: name,
          first: index == 0,
        );
      },
    );
  }
}
