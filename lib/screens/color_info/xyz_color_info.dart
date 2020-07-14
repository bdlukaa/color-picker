import 'package:color/color.dart' hide Color;
import 'package:flutter/material.dart';
import '../../widgets/color_preview.dart';

class XYZColorInfo extends StatelessWidget {
  const XYZColorInfo({Key key, @required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    XyzColor color = this.color == null
        ? null
        : RgbColor(this.color.red, this.color.green, this.color.blue)
            .toXyzColor();
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
                  XYZName(
                    text: 'X: ',
                    value: color?.x?.toStringAsFixed(2) ?? '?',
                    color: Colors.redAccent,
                  ),
                  XYZName(
                    text: 'Y: ',
                    value: color?.y?.toStringAsFixed(2) ?? '?',
                    color: Colors.green,
                  ),
                  XYZName(
                    text: 'Z: ',
                    value: color?.z?.toStringAsFixed(2) ?? '?',
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

class XYZName extends StatelessWidget {
  const XYZName(
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
