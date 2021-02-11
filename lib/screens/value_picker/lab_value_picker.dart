import 'package:flutter/material.dart' hide TextField;
import 'package:color/color.dart' hide Color;

import '../../widgets/opacity_slider.dart';

import '../color_info/color_info.dart';

class LABValuePicker extends StatefulWidget {
  LABValuePicker({Key key}) : super(key: key);

  @override
  _LABValuePickerState createState() => _LABValuePickerState();
}

class _LABValuePickerState extends State<LABValuePicker>
    with AutomaticKeepAliveClientMixin {
  double opacity = 1;
  double lightness = 0;
  TextEditingController _aController = TextEditingController(text: '0');
  TextEditingController _bController = TextEditingController(text: '0');

  num parse(String text) {
    try {
      var n = num.parse(text);
      return n;
    } catch (e) {
      return 0;
    }
  }

  double initialHeight;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var a = parse(_aController.text);
    var b = parse(_bController.text);
    var rgb = CielabColor(lightness, a, b).toRgbColor();
    var color = Color.fromARGB(
      255,
      rgb.r.toInt(),
      rgb.g.toInt(),
      rgb.b.toInt(),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Field(
                value: lightness,
                onChanged: (value) => setState(() => lightness = value),
                color: Colors.redAccent,
                label: 'Lightness',
                max: 100,
              ),
              TextField(
                controller: _aController,
                color: Colors.green,
                label: 'A',
              ),
              TextField(
                controller: _bController,
                color: Colors.blue,
                label: 'B',
              ),
            ],
          ),
        ),
        Divider(),
        ColorInfo(
          color: color,
          initial: 5,
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
    this.min = 0,
  }) : super(key: key);

  final Color color;
  final String label;
  final double value;
  final Function(double) onChanged;
  final double max;
  final double min;

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
              min: min,
              label: label,
              divisions: max.toInt() * 100,
              activeColor: color,
              inactiveColor: color.withOpacity(0.2),
            ),
          ),
          Text(value.toStringAsFixed(2)),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}

class TextField extends StatelessWidget {
  const TextField({
    Key key,
    @required this.color,
    @required this.label,
    @required this.controller,
  }) : super(key: key);

  final Color color;
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var border = UnderlineInputBorder(borderSide: BorderSide(color: color));
    return Container(
      padding: EdgeInsets.only(left: 25),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: controller,
              style: TextStyle(color: color),
              decoration: InputDecoration(
                enabledBorder: border,
                disabledBorder: border,
                labelText: label,
                labelStyle: TextStyle(color: color),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            tooltip: 'Clear',
            onPressed: () => controller.clear(),
          ),
        ],
      ),
    );
  }
}
