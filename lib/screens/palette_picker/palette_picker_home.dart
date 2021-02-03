import 'package:flutter/material.dart';

import '../../screens/color_info/color_info.dart';
import '../../widgets/opacity_slider.dart';
import '../../widgets/minHeight.dart';

import '../../utils.dart';

import 'color_palette_picker.dart';

class PalettePickerHome extends StatefulWidget {
  PalettePickerHome({Key key}) : super(key: key);

  @override
  _PalettePickerHomeState createState() => _PalettePickerHomeState();
}

class _PalettePickerHomeState extends State<PalettePickerHome>
    with AutomaticKeepAliveClientMixin {
  Color color = initialColor;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MinHeight(
      minScreenHeight: 350,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: PaletteHuePicker(
                color: HSVColor.fromColor(color),
                onChanged: (c) => setState(() => color = c.toColor()),
              ),
            ),
            Divider(height: 16),
            LimitedBox(
              child: ColorInfo(
                color: color,
                slider: OpacitySlider(
                  onChanged: (v) =>
                      setState(() => color = color.withOpacity(v)),
                  value: color.opacity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
