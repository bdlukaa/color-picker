import 'package:color_picker/lang/lang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/color_preview.dart';

class RGBColorInfo extends StatelessWidget {
  const RGBColorInfo({Key key, @required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
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
                  RGBName(
                    text: '${lang.red}: ',
                    value: color?.red?.toString() ?? '?',
                    color: Colors.redAccent,
                  ),
                  RGBName(
                    text: '${lang.green}: ',
                    value: color?.green?.toString() ?? '?',
                    color: Colors.green,
                  ),
                  RGBName(
                    text: '${lang.blue}: ',
                    value: color?.blue?.toString() ?? '?',
                    color: Colors.blue,
                  ),
                  RGBName(
                    text: '${lang.alpha}: ',
                    value: color?.alpha?.toString() ?? '?',
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

class RGBName extends StatelessWidget {
  const RGBName(
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
