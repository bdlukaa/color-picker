part of 'color_info.dart';

class RGBColorInfo extends StatelessWidget {
  const RGBColorInfo({Key key, @required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
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
          Spacer(),
          ColorPreview(color: color),
        ],
      ),
    );
  }
}
