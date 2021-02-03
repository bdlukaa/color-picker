import 'package:flutter/material.dart';

import '../../lang/lang.dart';
import '../../widgets/opacity_slider.dart';

import '../color_info/color_info.dart';

class HSLValuePicker extends StatefulWidget {
  HSLValuePicker({Key key}) : super(key: key);

  @override
  _HSLValuePickerState createState() => _HSLValuePickerState();
}

class _HSLValuePickerState extends State<HSLValuePicker>
    with AutomaticKeepAliveClientMixin {
  double opacity = 1;
  double hue, saturation, lightness;

  @override
  void initState() {
    super.initState();
    hue = saturation = lightness = 0;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var color = HSLColor.fromAHSL(1, hue, saturation, lightness)
        .toColor()
        .withOpacity(opacity);
    Language lang = Language.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Field(
              value: hue,
              onChanged: (value) => setState(() => hue = value),
              color: Colors.purple,
              label: lang.hue,
              max: 360,
              colors: [Colors.red, Colors.yellow],
            ),
            Field(
              max: 1,
              value: saturation,
              onChanged: (value) => setState(() => saturation = value),
              color: Colors.green,
              label: lang.saturation,
            ),
            Field(
              max: 1,
              value: lightness,
              onChanged: (value) => setState(() => lightness = value),
              color: Colors.yellow,
              label: lang.lightness,
            ),
          ],
        ),
        Spacer(),
        Divider(),
        ColorInfo(
          color: color,
          initial: 2,
          slider: OpacitySlider(
            onChanged: (value) => setState(() => opacity = value),
            value: opacity,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Field extends StatelessWidget {
  const Field({
    Key key,
    @required this.color,
    @required this.label,
    @required this.value,
    @required this.max,
    @required this.onChanged,
    this.colors,
  }) : super(key: key);

  final Color color;
  final String label;
  final double value;
  final Function(double) onChanged;
  final double max;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Slider(
              value: value,
              onChanged: onChanged,
              max: max,
              min: 0,
              label: label,
              activeColor: color,
              inactiveColor: color.withOpacity(0.2),
            ),
          ),
          Text(
            value.toStringAsFixed(2),
            style: DefaultTextStyle.of(context).style,
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
