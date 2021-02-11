part of 'color_info.dart';

class RGBColorInfo extends StatelessWidget {
  const RGBColorInfo({Key key, @required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
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
                text: '${lang.red}: ',
                value: color?.red?.toString() ?? '?',
                color: Colors.redAccent,
              ),
              ColorName(
                text: '${lang.green}: ',
                value: color?.green?.toString() ?? '?',
                color: Colors.green,
              ),
              ColorName(
                text: '${lang.blue}: ',
                value: color?.blue?.toString() ?? '?',
                color: Colors.blue,
              ),
              ColorName(
                text: '${lang.alpha}: ',
                value: color?.alpha?.toString() ?? '?',
                color: Colors.amber,
              ),
            ],
          ),
        ),
        ColorPreview(
          color: color,
          onCopyToClipboard: () => showCopiedToClipboard(
            context,
            'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.opacity})',
          ),
        ),
      ],
    );
  }
}
