part of 'color_info.dart';

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
                text: '${lang.hex}: ',
                value: color != null ? alpha + color.toString() : '?',
                color: Colors.redAccent,
              ),
              ColorName(
                text: '${lang.cssHex}: ',
                value: color != null ? '#' + alpha + color.toString() : '?',
                color: Colors.redAccent,
              ),
            ],
          ),
          Spacer(),
          ColorPreview(
            color: this.color,
            onCopyToClipboard: () async {
              final text = '#' + alpha + color.toString();
              await FlutterClipboard.copy(text);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: lang.copiedToClipboard(text)),
              );
            },
          ),
        ],
      ),
    );
  }
}
