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
        ),
        ColorPreview(
          color: this.color,
          onCopyToClipboard: () => showCopiedToClipboard(
            context,
            '#' + alpha + color.toString(),
          ),
        ),
      ],
    );
  }
}
