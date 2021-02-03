import 'package:flutter/material.dart';
import 'package:color/color.dart' hide Color;

import '../../lang/lang.dart';
import '../../widgets/opacity_slider.dart';

import '../color_info/color_info.dart';

class HEXValuePicker extends StatefulWidget {
  HEXValuePicker({Key key}) : super(key: key);

  @override
  _HEXValuePickerState createState() => _HEXValuePickerState();
}

class _HEXValuePickerState extends State<HEXValuePicker>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _hexController = TextEditingController();

  double opacity = 1;

  @override
  void initState() {
    super.initState();
    _hexController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Language lang = Language.of(context);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Field(
                controller: _hexController,
                color: Colors.amber,
                action: TextInputAction.done,
                label: lang.hexCode,
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => _hexController.clear(),
              tooltip: lang.clear,
            ),
          ],
        ),
        SizedBox(height: 6),
        Align(
          alignment: Alignment.center,
          child: Text(
            isNull
                ? lang.hexCodeMustNotBeEmpty
                : !isBounded
                    ? lang.hexCodeLengthMustBeSix
                    : !isWellFormatted
                        ? lang.hexCodeLimitedChars
                        : lang.hexCodeOpacity,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Spacer(),
        Divider(),
        ColorInfo(
          initial: 1,
          color: isNull || !isBounded || !isWellFormatted
              ? null
              : toColor(HexColor(
                  _hexController.text.replaceAll('#', ''),
                ).toRgbColor())
                  .withOpacity(opacity),
          slider: OpacitySlider(
            onChanged: (value) => setState(() => opacity = value),
            value: opacity,
          ),
        ),
      ],
    );
  }

  Color toColor(RgbColor color) {
    return Color.fromARGB(255, color.r, color.g, color.b);
  }

  bool get isNull => _hexController.text.isEmpty;

  bool get isBounded {
    if (!isNull) {
      return _hexController.text.replaceAll('#', '').length == 6;
    } else
      return false;
  }

  bool get isWellFormatted {
    if (!isNull) {
      // return _hexController.text.;
      try {
        HexColor(
          _hexController.text.replaceAll('#', ''),
        );
        return true;
      } catch (e) {
        return false;
      }
    } else
      return false;
  }

  @override
  bool get wantKeepAlive => true;
}

class Field extends StatelessWidget {
  const Field({
    Key key,
    @required this.color,
    @required this.action,
    @required this.label,
    @required this.controller,
  }) : super(key: key);

  final Color color;
  final TextInputAction action;
  final String label;
  final TextEditingController controller;
  // final Function updateS

  @override
  Widget build(BuildContext context) {
    var border = UnderlineInputBorder(borderSide: BorderSide(color: color));
    return TextFormField(
      controller: controller,
      cursorColor: color,
      style: TextStyle(color: color),
      textInputAction: action,
      maxLength: 6,
      maxLengthEnforced: true,
      onFieldSubmitted: (text) => action == TextInputAction.done
          ? FocusScope.of(context).unfocus()
          : FocusScope.of(context).nextFocus(),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: color),
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
