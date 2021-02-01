import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';

import '../theme_manager.dart';

class OpacitySlider extends StatelessWidget {
  const OpacitySlider({
    Key key,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  final double value;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    Language lang = Language.of(context);
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Slider(
              value: value,
              onChanged: onChanged,
              max: 1.0,
              min: 0,
              label: lang.opacity,
            ),
          ),
          Text(
            '${(value * 100.0).toInt()}%',
            style: TextStyle(
              color:
                  ThemeManager.isBright(context) ? Colors.black : Colors.white,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
