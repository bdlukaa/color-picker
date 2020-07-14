import 'package:color_picker/screens/color_info/color_info.dart';
import 'package:color_picker/widgets/opacity_slider.dart';
import 'package:color_picker/widgets/scroll_initial.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
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
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: SafeArea(
        child: ScrollInitial(
          child: Container(
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: PaletteHuePicker(
                    color: HSVColor.fromColor(color),
                    onChanged: (color) =>
                        setState(() => this.color = color.toColor()),
                  ),
                ),
                Divider(height: 16),
                LimitedBox(
                  child: ColorInfo(
                    color: color,
                    slider: OpacitySlider(
                      onChanged: (value) =>
                          setState(() => color = color.withOpacity(value)),
                      value: color.opacity,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
