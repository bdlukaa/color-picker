part of 'color_info.dart';

class CielabColorInfo extends StatelessWidget {
  const CielabColorInfo({Key key, @required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    CielabColor color = this.color == null
        ? null
        : RgbColor(this.color.red, this.color.green, this.color.blue)
            .toCielabColor();
    final lang = Language.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ColorName(
                text: '${lang.lightness}: ',
                value: color?.l?.toStringAsFixed(2) ?? '?',
                color: Colors.redAccent,
              ),
              ColorName(
                text: 'A: ',
                value: color?.a?.toStringAsFixed(2) ?? '?',
                color: Colors.green,
              ),
              ColorName(
                text: 'B: ',
                value: color?.b?.toStringAsFixed(2) ?? '?',
                color: Colors.blue,
              ),
            ],
          ),
        ),
        ColorPreview(color: this.color),
      ],
    );
  }
}