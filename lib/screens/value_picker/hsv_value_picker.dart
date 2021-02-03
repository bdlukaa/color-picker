import 'package:flutter/material.dart';

import '../../lang/lang.dart';
import '../../widgets/opacity_slider.dart';

import '../color_info/color_info.dart';

class HSVValuePicker extends StatefulWidget {
  HSVValuePicker({Key key}) : super(key: key);

  @override
  _HSVValuePickerState createState() => _HSVValuePickerState();
}

class _HSVValuePickerState extends State<HSVValuePicker>
    with AutomaticKeepAliveClientMixin {
  double opacity = 1;
  double hue, saturation, value;

  @override
  void initState() {
    super.initState();
    hue = saturation = value = 0;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var color = HSVColor.fromAHSV(1, hue, saturation, value)
        .toColor()
        .withOpacity(opacity);
    final lang = Language.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Spacer(),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Field(
              value: hue,
              onChanged: (value) => setState(() => hue = value),
              color: Colors.redAccent,
              label: lang.hue,
              max: 360,
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
              value: value,
              onChanged: (value) => setState(() => this.value = value),
              color: Colors.blue,
              label: lang.value,
            ),
          ],
        ),
        Spacer(),
        Divider(),
        ColorInfo(
          color: color,
          initial: 3,
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
  }) : super(key: key);

  final Color color;
  final String label;
  final double value;
  final Function(double) onChanged;
  final double max;

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
