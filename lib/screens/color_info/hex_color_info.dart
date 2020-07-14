import 'package:color/color.dart' hide Color;
import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';
import '../../widgets/color_preview.dart';

class HEXColorInfo extends StatelessWidget {
  const HEXColorInfo({Key key, @required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    HexColor color = this.color == null
        ? null
        : HexColor.fromRgb(this.color.red, this.color.green, this.color.blue);
    String alpha =
        this.color?.alpha?.toInt()?.toRadixString(16)?.padLeft(2, '0') ?? '';
    Language lang = Language.of(context);
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  HEXName(
                    text: '${lang.hex}: ',
                    value: color != null ? alpha + color.toString() : '?',
                    color: Colors.redAccent,
                  ),
                  HEXName(
                    text: '${lang.cssHex}: ',
                    value: color != null ? '#' + alpha + color.toString() : '?',
                    color: Colors.redAccent,
                  ),
                ],
              ),
              Spacer(),
              ColorPreview(color: this.color),
            ],
          ),
        ],
      ),
    );
  }
}

class HEXName extends StatelessWidget {
  const HEXName(
      {Key key,
      @required this.text,
      @required this.value,
      @required this.color})
      : super(key: key);

  final String text;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        children: [
          TextSpan(
            text: value,
            style: TextStyle(color: color),
          ),
        ],
        style: DefaultTextStyle.of(context).style,
      ),
    );
  }
}
