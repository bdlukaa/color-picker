import 'package:color_picker/main.dart';
import 'package:color_picker/screens/color_info/color_info.dart';
import 'package:color_picker/widgets/opacity_slider.dart';
import 'package:color_picker/widgets/scroll_initial.dart';
import 'package:flutter/material.dart';

import 'color_picker_wheel.dart';

class WheelPickerHome extends StatefulWidget {
  WheelPickerHome({Key key}) : super(key: key);

  @override
  _WheelPickerHomeState createState() => _WheelPickerHomeState();
}

class _WheelPickerHomeState extends State<WheelPickerHome>
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 340,
                      minHeight: 245,
                    ),
                    child: WheelPicker(
                      color: HSVColor.fromColor(color),
                      onChanged: (color) =>
                          setState(() => this.color = color.toColor()),
                    ),
                  ),
                ),
              ),
              Divider(),
              ColorInfo(
                color: color,
                slider: OpacitySlider(
                  onChanged: (value) =>
                      setState(() => color = color.withOpacity(value)),
                  value: color.opacity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
