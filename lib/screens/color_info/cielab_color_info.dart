import 'package:color/color.dart' hide Color;
import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';
import '../../widgets/color_preview.dart';

class CielabColorInfo extends StatelessWidget {
  const CielabColorInfo({Key key, @required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    CielabColor color = this.color == null
        ? null
        : RgbColor(this.color.red, this.color.green, this.color.blue)
            .toCielabColor();
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
                  CielabName(
                    text: '${lang.lightness}: ',
                    value: color?.l?.toStringAsFixed(2) ?? '?',
                    color: Colors.redAccent,
                  ),
                  CielabName(
                    text: 'A: ',
                    value: color?.a?.toStringAsFixed(2) ?? '?',
                    color: Colors.green,
                  ),
                  CielabName(
                    text: 'B: ',
                    value: color?.b?.toStringAsFixed(2) ?? '?',
                    color: Colors.blue,
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

class CielabName extends StatelessWidget {
  const CielabName(
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
