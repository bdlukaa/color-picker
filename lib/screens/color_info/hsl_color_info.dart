part of 'color_info.dart';

class HSLColorInfo extends StatelessWidget {
  const HSLColorInfo({Key key, @required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final color = this.color == null ? null : HSLColor.fromColor(this.color);
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
                text: '${lang.lightness}: ',
                value: color?.lightness?.toStringAsFixed(2) ?? '?',
                color: Colors.blue,
              ),
              ColorName(
                text: '${lang.alpha}: ',
                value: color?.alpha?.toStringAsFixed(2) ?? '?',
                color: Colors.amber,
              ),
            ],
          ),
        ),
        ColorPreview(
          color: this.color,
          onCopyToClipboard: () => showCopiedToClipboard(
            context,
            'hsl(${color.hue.toInt()}, ${(color.saturation * 100).toInt()}%, ${(color.lightness * 100).toInt()}%)',
          ),
        ),
      ],
    );
  }
}
