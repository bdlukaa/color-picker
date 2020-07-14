import 'package:flutter/material.dart';
import '../../widgets/expansion_tile.dart';
import '../../dialogs.dart';

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
        color: Colors.white,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            offset: Offset(-shadowWidth, -shadowWidth),
            color: shadowColor,
          ),
          Shadow(
            offset: Offset(shadowWidth, -shadowWidth),
            color: shadowColor,
          ),
          Shadow(
            offset: Offset(shadowWidth, shadowWidth),
            color: shadowColor,
          ),
          Shadow(
            offset: Offset(-shadowWidth, shadowWidth),
            color: shadowColor,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return ControllableExpansionTile(
      title: Text(title, style: borderStyle),
      backgroundColor: color,
      initiallyExpanded: false,
      first: first,
      trailing: IconButton(
        icon: Icon(Icons.info_outline, color: Colors.white),
        tooltip: 'See color info',
        onPressed: () => showColorInfoDialog(context, title, color),
      ),
      children: List<Widget>.generate(11, (index) {
        double opacity = 50;
        if (index > 0) opacity = index.toDouble() * 100;
        return Container(
          height: 45,
          width: double.infinity,
          color: color.withOpacity(opacity / 1000),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.only(top: 10),
          child: Text('$title with ${opacity ~/ 10}% of opacity'),
        );
      }),
    );
  }
}
