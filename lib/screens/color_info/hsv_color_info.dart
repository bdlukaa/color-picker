import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';
import '../../widgets/color_preview.dart';

class HSVColorInfo extends StatelessWidget {
  const HSVColorInfo({Key key, @required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final color = this.color == null ? null : HSVColor.fromColor(this.color);
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
                  HSVName(
                    text: '${lang.hue}: ',
                    value: color?.hue?.toStringAsFixed(2) ?? '?',
                    color: Colors.redAccent,
                  ),
                  HSVName(
                    text: '${lang.saturation}: ',
                    value: color?.saturation?.toStringAsFixed(2) ?? '?',
                    color: Colors.green,
                  ),
                  HSVName(
                    text: '${lang.value}: ',
                    value: color?.value?.toStringAsFixed(2) ?? '?',
                    color: Colors.blue,
                  ),
                  HSVName(
                    text: '${lang.alpha}: ',
                    value: color?.alpha?.toStringAsFixed(2) ?? '?',
                    color: Colors.amber,
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

class HSVName extends StatelessWidget {
  const HSVName(
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
