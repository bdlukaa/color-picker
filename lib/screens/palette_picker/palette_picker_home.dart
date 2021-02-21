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
  HSVColor color = HSVColor.fromColor(initialColor);
  bool showIndicator = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MinHeight(
      minScreenHeight: 350,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 6),
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: PaletteHuePicker(
                showIndicator: showIndicator,
                onShowIndicatorChanged: (value) =>
                    setState(() => showIndicator = value),
                color: color,
                onChanged: (c) => setState(() => color = c),
              ),
            ),
            Divider(height: 16),
            LimitedBox(
              child: ColorInfo(
                color: color.toColor(),
                slider: OpacitySlider(
                  onChanged: (v) => setState(() => color = color.withAlpha(v)),
                  value: color.alpha,
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
