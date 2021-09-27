import 'package:flutter/material.dart';
import 'package:color/color.dart' hide Color;

import '../../widgets/opacity_slider.dart';
import '../../theme_manager.dart';

import '../color_info/color_info.dart';

class XYZValuePicker extends StatefulWidget {
  const XYZValuePicker({Key? key}) : super(key: key);

  @override
  _XYZValuePickerState createState() => _XYZValuePickerState();
}

class _XYZValuePickerState extends State<XYZValuePicker>
    with AutomaticKeepAliveClientMixin {
  double opacity = 1;
  final TextEditingController _xController = TextEditingController(text: '0');
  final TextEditingController _yController = TextEditingController(text: '0');
  final TextEditingController _zController = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    _xController.addListener(() => setState(() {}));
    _yController.addListener(() => setState(() {}));
    _zController.addListener(() => setState(() {}));
  }

  num parse(String text) {
    try {
      var n = num.parse(text);
      return n;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var x = parse(_xController.text);
    var y = parse(_yController.text);
    var z = parse(_zController.text);
    var rgb = XyzColor(x, y, z).toRgbColor();
    var color = Color.fromARGB(
      255,
      rgb.r.toInt(),
      rgb.g.toInt(),
      rgb.b.toInt(),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Field(
              controller: _xController,
              color: Colors.redAccent,
              label: 'X',
            ),
            Field(
              controller: _yController,
              color: Colors.green,
              label: 'Y',
            ),
            Field(
              controller: _zController,
              color: Colors.blue,
              label: 'Z',
            ),
            const SizedBox(height: 4),
          ],
        ),
        if (MediaQuery.of(context).orientation == Orientation.portrait)
          const Spacer(),
        const Divider(),
        ColorInfo(
          color: color,
          initial: 4,
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
    Key? key,
    required this.color,
    required this.label,
    required this.controller,
  }) : super(key: key);

  final Color color;
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var border = UnderlineInputBorder(borderSide: BorderSide(color: color));
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(children: <Widget>[
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
          icon: Icon(
            Icons.close,
            color: ThemeManager.isBright(context) ? null : Colors.black,
          ),
          tooltip: 'Clear',
          onPressed: () => controller.clear(),
        ),
      ]),
    );
  }
}
