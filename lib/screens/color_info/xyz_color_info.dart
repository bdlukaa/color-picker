part of 'color_info.dart';

class XYZColorInfo extends StatelessWidget {
  const XYZColorInfo({Key key, @required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    XyzColor color = this.color == null
        ? null
        : RgbColor(this.color.red, this.color.green, this.color.blue)
            .toXyzColor();
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
                text: 'X: ',
                value: color?.x?.toStringAsFixed(2) ?? '?',
                color: Colors.redAccent,
              ),
              ColorName(
                text: 'Y: ',
                value: color?.y?.toStringAsFixed(2) ?? '?',
                color: Colors.green,
              ),
              ColorName(
                text: 'Z: ',
                value: color?.z?.toStringAsFixed(2) ?? '?',
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
