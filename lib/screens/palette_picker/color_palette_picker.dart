import "package:flutter/material.dart";

const double _kBorderRadius = 6;
const double _kBorderWidth = 0.2;
double kSliderHeight = 14;
double kThumbSize = kSliderHeight * 2;

class PalettePicker extends StatelessWidget {
  final Offset position;
  final ValueChanged<Offset> onChanged;

  final double leftPosition;
  final double rightPosition;
  final List<Color> leftRightColors;

  final double topPosition;
  final double bottomPosition;
  final List<Color> topBottomColors;

  PalettePicker({
    Key key,
    @required this.position,
    @required this.onChanged,
    @required this.leftRightColors,
    @required this.topBottomColors,
    this.leftPosition = 0.0,
    this.rightPosition = 1.0,
    this.topPosition = 0.0,
    this.bottomPosition = 1.0,
  })  : assert(position != null),
        super(key: key);

  Offset positionToRatio() {
    double ratioX = leftPosition < rightPosition
        ? positionToRatio2(position.dx, leftPosition, rightPosition)
        : 1.0 - positionToRatio2(position.dx, rightPosition, leftPosition);

    double ratioY = topPosition < bottomPosition
        ? positionToRatio2(position.dy, topPosition, bottomPosition)
        : 1.0 - positionToRatio2(position.dy, bottomPosition, topPosition);

    return Offset(ratioX, ratioY);
  }

  double positionToRatio2(
      double postiton, double minPostition, double maxPostition) {
    if (postiton < minPostition) return 0.0;
    if (postiton > maxPostition) return 1.0;
    return (postiton - minPostition) / (maxPostition - minPostition);
  }

  void ratioToPosition(BuildContext context, Offset ratio) {
    RenderBox renderBox = context.findRenderObject();
    Offset startposition = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;
    Offset updateOffset = ratio - startposition;

    double ratioX = updateOffset.dx / size.width;
    double ratioY = updateOffset.dy / size.height;

    double positionX = leftPosition < rightPosition
        ? ratioToPosition2(ratioX, leftPosition, rightPosition)
        : ratioToPosition2(1.0 - ratioX, rightPosition, leftPosition);

    double positionY = topPosition < bottomPosition
        ? ratioToPosition2(ratioY, topPosition, bottomPosition)
        : ratioToPosition2(1.0 - ratioY, bottomPosition, topPosition);

    Offset position = Offset(positionX, positionY);
    onChanged(position);
  }

  double ratioToPosition2(
      double ratio, double minposition, double maxposition) {
    if (ratio < 0.0) return minposition;
    if (ratio > 1.0) return maxposition;
    return ratio * maxposition + (1.0 - ratio) * minposition;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: _kBorderWidth),
              borderRadius: BorderRadius.all(Radius.circular(_kBorderRadius)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: leftRightColors,
              ),
            ),
          ), // Left right
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: _kBorderWidth),
              borderRadius: BorderRadius.all(Radius.circular(_kBorderRadius)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: topBottomColors,
              ),
            ),
          ), // Top bottom
          Positioned(
            left: size.biggest.width * positionToRatio().dx - (25 / 2),
            top: size.biggest.height * positionToRatio().dy - (25 / 2),
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
              ),
            ),
          ), // Indicator
          GestureDetector(
            onPanStart: (details) =>
                ratioToPosition(context, details.globalPosition),
            onPanUpdate: (details) =>
                ratioToPosition(context, details.globalPosition),
            onPanDown: (details) =>
                ratioToPosition(context, details.globalPosition),
          ), // Gestures
        ],
      );
    });
  }
}

class SliderPicker extends StatefulWidget {
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;
  final List<Color> colors;
  final Color color;

  SliderPicker({
    Key key,
    this.min = 0.0,
    this.max = 1.0,
    @required this.value,
    @required this.onChanged,
    @required this.color,
    this.colors,
  })  : assert(value != null),
        assert(value >= min && value <= max),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SliderPickerState();
}

class _SliderPickerState extends State<SliderPicker> {
  double get value => widget.value;
  double get min => widget.min;
  double get max => widget.max;

  double getRatio() => ((value - min) / (max - min)).clamp(0.0, 1.0);

  void setRatio(double ratio) =>
      widget.onChanged((ratio * (max - min) + min).clamp(min, max));

  void onPanStart(DragStartDetails details, BoxConstraints box) {
    RenderBox renderBox = context.findRenderObject();
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    double ratio = offset.dx / box.maxWidth;
    setState(() => setRatio(ratio));
  }

  void onPanUpdate(DragUpdateDetails details, BoxConstraints box) {
    RenderBox renderBox = context.findRenderObject();
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    double ratio = offset.dx / box.maxWidth;
    setState(() => setRatio(ratio));
  }

  void onPanDown(DragDownDetails details, BoxConstraints box) {
    RenderBox renderBox = context.findRenderObject();
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    double ratio = offset.dx / box.maxWidth;
    setState(() => setRatio(ratio));
  }

  double trackWidth = 14;
  double getWidth(double value, double maxWidth) =>
      (maxWidth - trackWidth - trackWidth) * value + trackWidth;

  BorderRadius radius = BorderRadius.all(Radius.circular(20.0));

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        Widget gestureDetector = GestureDetector(
          child: Container(
            color: Colors.transparent,
            constraints: box,
          ),
          onPanStart: (detail) => onPanStart(detail, box),
          onHorizontalDragUpdate: (detail) => onPanUpdate(detail, box),
          onPanDown: (detail) => onPanDown(detail, box),
        );
        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.tightFor(
                width: box.maxWidth,
                height: kSliderHeight
              ),
              decoration: BoxDecoration(
                borderRadius: radius,
                border: Border.all(color: Colors.grey, width: _kBorderWidth),
                gradient: LinearGradient(colors: widget.colors),
              ),
              child: gestureDetector,
            ),
            // Thumb
            Positioned(
              top: -7,
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(
                    getWidth(getRatio(), box.maxWidth) - (kThumbSize / 2),
                  ),
                child: Container(
                  height: kThumbSize,
                  width: kThumbSize,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(1),
                    shape: BoxShape.circle,
                  ),
                  child: gestureDetector,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class PaletteHuePicker extends StatelessWidget {
  final HSVColor color;
  final ValueChanged<HSVColor> onChanged;

  PaletteHuePicker({
    Key key,
    @required this.color,
    @required this.onChanged,
  })  : assert(color != null),
        super(key: key);

  List<Color> get hueColors {
    final color = this.color.withSaturation(1).withValue(1);
    return <Color>[
      color.withHue(0.0).toColor(),
      color.withHue(60.0).toColor(),
      color.withHue(120.0).toColor(),
      color.withHue(180.0).toColor(),
      color.withHue(240.0).toColor(),
      color.withHue(300.0).toColor(),
      color.withHue(0.0).toColor()
    ].map((color) => color.withOpacity(1)).toList();
  }

  List<Color> get saturationColors => [
        Colors.white,
        HSVColor.fromAHSV(1.0, color.hue, 1.0, 1.0).toColor(),
      ];

  final List<Color> valueColors = [Colors.transparent, Colors.black];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            // fit: FlexFit.loose,
            child: PalettePicker(
              position: Offset(color.saturation, color.value),
              onChanged: (value) => onChanged(
                HSVColor.fromAHSV(color.alpha, color.hue, value.dx, value.dy),
              ),
              topPosition: 1.0,
              bottomPosition: 0.0,
              leftRightColors: saturationColors,
              topBottomColors: valueColors,
            ),
          ),
          SizedBox(height: 14),
          SliderPicker(
            min: 0.0,
            max: 360.0,
            value: color.hue,
            onChanged: (value) => onChanged(color.withHue(value)),
            colors: hueColors,
            color: color.toColor(),
          )
        ],
      ),
    );
  }
}
