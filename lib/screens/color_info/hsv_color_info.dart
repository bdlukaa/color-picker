part of 'color_info.dart';

class HSVColorInfo extends StatelessWidget {
  const HSVColorInfo({Key key, @required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final color = this.color == null ? null : HSVColor.fromColor(this.color);
    final lang = Language.of(context);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ColorName(
                text: '${lang.hue}: ',
                value: color?.hue?.toStringAsFixed(2) ?? '?',
                color: Colors.redAccent,
              ),
              ColorName(
                text: '${lang.saturation}: ',
                value: color?.saturation?.toStringAsFixed(2) ?? '?',
                color: Colors.green,
              ),
              ColorName(
                text: '${lang.value}: ',
                value: color?.value?.toStringAsFixed(2) ?? '?',
                color: Colors.blue,
              ),
              ColorName(
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
    );
  }
}
