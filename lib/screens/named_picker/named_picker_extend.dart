import 'package:flutter/material.dart';

import '../../lang/lang.dart';
import '../../widgets/expansion_tile.dart';
import '../color_info/color_info.dart';

class NamedPickerTile extends StatelessWidget {
  NamedPickerTile({
    @required this.color,
    @required this.title,
    @required this.first,
  });

  final Color color;
  final String title;
  final bool first;

  Color get shadowColor => Colors.black87;
  double get shadowWidth => 0.3;

  TextStyle get borderStyle => TextStyle(
        color: color.computeLuminance() <= 0.5 ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      );

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    return ControllableExpansionTile(
      title: Text(title, style: borderStyle),
      backgroundColor: color,
      initiallyExpanded: false,
      first: first,
      trailing: IconButton(
        icon: Icon(Icons.info_outline, color: Colors.white),
        tooltip: lang.seeColorInfo,
        onPressed: () => showColorInfoDialog(context, title, color),
      ),
      children: List<Widget>.generate(11, (index) {
        double opacity = 50;
        if (index > 0) opacity = index.toDouble() * 100;
        Color color = this.color.withOpacity(opacity / 1000);
        return Container(
          height: 45,
          width: double.infinity,
          color: color,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.only(top: 10),
          child: Text(
            lang.colorWithOpacity(title, opacity ~/ 10),
            style: TextStyle(
              color: color.opacity >= 0.5 ? Colors.black : Colors.white,
            ),
          ),
        );
      }),
    );
  }
}
