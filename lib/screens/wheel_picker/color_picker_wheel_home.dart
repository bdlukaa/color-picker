import 'package:flutter/material.dart';

import '../../screens/color_info/color_info.dart';
import '../../widgets/opacity_slider.dart';
import '../../widgets/minHeight.dart';

import 'color_picker_wheel.dart';
import '../../utils.dart';

class WheelPickerHome extends StatefulWidget {
  WheelPickerHome({Key key}) : super(key: key);

  @override
  _WheelPickerHomeState createState() => _WheelPickerHomeState();
}

class _WheelPickerHomeState extends State<WheelPickerHome>
    with AutomaticKeepAliveClientMixin {
  HSVColor color = HSVColor.fromColor(initialColor);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MinHeight(
      minScreenHeight: 400,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 350,
                    minHeight: 255,
                    // maxHeight: 300,
                    // maxWidth: 400,
                  ),
                  child: WheelPicker(
                    color: color,
                    onChanged: (color) => setState(() => this.color = color),
                  ),
                ),
              ),
            ),
            Divider(),
            ColorInfo(
              color: color.toColor(),
              slider: OpacitySlider(
                onChanged: (value) =>
                    setState(() => color = color.withAlpha(value)),
                value: color.alpha,
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
