import "package:flutter/material.dart";
import '../../widgets/indicator.dart';

const double _kBorderRadius = 3;
const double _kBorderWidth = 0.01;
const double kSliderHeight = 14;

class PalettePicker extends StatefulWidget {
  final Offset position;
  final ValueChanged<Offset> onChanged;

  final double leftPosition;
  final double rightPosition;
  final List<Color> leftRightColors;

  final double topPosition;
  final double bottomPosition;
  final List<Color> topBottomColors;
  final HSVColor color;

  final bool showIndicator;
  final ValueChanged<bool> onShowIndicatorChanged;

  PalettePicker({
    Key key,
    @required this.position,
    @required this.onChanged,
    @required this.leftRightColors,
    @required this.topBottomColors,
    @required this.showIndicator,
    @required this.onShowIndicatorChanged,
    this.leftPosition = 0.0,
    this.rightPosition = 1.0,
    this.topPosition = 0.0,
    this.bottomPosition = 1.0,
    this.color,
  })  : assert(position != null),
        super(key: key);

  @override
  _PalettePickerState createState() => _PalettePickerState();
}

class _PalettePickerState extends State<PalettePicker> {
  Offset positionToRatio() {
    double ratioX = widget.leftPosition < widget.rightPosition
        ? positionToRatio2(
            widget.position.dx, widget.leftPosition, widget.rightPosition)
        : 1.0 -
            positionToRatio2(
                widget.position.dx, widget.rightPosition, widget.leftPosition);

    double ratioY = widget.topPosition < widget.bottomPosition
        ? positionToRatio2(
            widget.position.dy, widget.topPosition, widget.bottomPosition)
        : 1.0 -
            positionToRatio2(
                widget.position.dy, widget.bottomPosition, widget.topPosition);

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

    double positionX = widget.leftPosition < widget.rightPosition
        ? ratioToPosition2(ratioX, widget.leftPosition, widget.rightPosition)
        : ratioToPosition2(
            1.0 - ratioX, widget.rightPosition, widget.leftPosition);

    double positionY = widget.topPosition < widget.bottomPosition
        ? ratioToPosition2(ratioY, widget.topPosition, widget.bottomPosition)
        : ratioToPosition2(
            1.0 - ratioY, widget.bottomPosition, widget.topPosition);

    Offset position = Offset(positionX, positionY);
    widget.onChanged(position);
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
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: _kBorderWidth),
              borderRadius: BorderRadius.all(Radius.circular(_kBorderRadius)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: widget.leftRightColors,
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
                colors: widget.topBottomColors,
              ),
            ),
          ), // Top bottom
          Positioned(
            // 26 because of the border. 25 + 1
            left: size.biggest.width * positionToRatio().dx -
                (kIndicatorSize / 2),
            top: size.biggest.height * positionToRatio().dy -
                (kIndicatorSize / 2),
            child: ColorIndicator(
              currentColor: widget.color.toColor(),
              show: widget.showIndicator,
              below:
                  positionToRatio().dy <= ((kIndicatorPreviewSize * 0.8) / 100),
            ),
          ), // Indicator
          GestureDetector(
            onPanStart: (details) {
              widget.onShowIndicatorChanged(true);
              ratioToPosition(context, details.globalPosition);
            },
            onPanEnd: (_) => widget.onShowIndicatorChanged(false),
            onPanUpdate: (details) => ratioToPosition(
              context,
              details.globalPosition,
            ),
            onPanDown: (details) => ratioToPosition(
              context,
              details.globalPosition,
            ),
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
  final List<HSVColor> colors;
  final HSVColor color;
  final ValueChanged<bool> onShowIndicatorChanged;

  SliderPicker({
    Key key,
    this.min = 0.0,
    this.max = 1.0,
    @required this.value,
    @required this.onChanged,
    @required this.color,
    @required this.onShowIndicatorChanged,
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
    setRatio(ratio);
  }

  void onPanUpdate(DragUpdateDetails details, BoxConstraints box) {
    RenderBox renderBox = context.findRenderObject();
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    double ratio = offset.dx / box.maxWidth;
    setRatio(ratio);
  }

  void onPanDown(DragDownDetails details, BoxConstraints box) {
    RenderBox renderBox = context.findRenderObject();
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    double ratio = offset.dx / box.maxWidth;
    setRatio(ratio);
  }

  double trackWidth = 14;
  double getWidth(double value, double maxWidth) =>
      (maxWidth - trackWidth - trackWidth) * value + trackWidth;

  BorderRadius radius = BorderRadius.all(Radius.circular(20.0));

  @override
  Widget build(BuildContext context) {
    final double kIndicatorSize = kSliderHeight * 2.4;
    return LayoutBuilder(
      builder: (context, box) {
        Widget gestureDetector = GestureDetector(
          child: Container(
            color: Colors.transparent,
            constraints: box,
          ),
          onPanStart: (detail) => onPanStart(detail, box),
          onPanDown: (detail) => onPanDown(detail, box),
          onHorizontalDragStart: (_) =>  widget.onShowIndicatorChanged(true),
          onHorizontalDragUpdate: (detail) => onPanUpdate(detail, box),
          onHorizontalDragEnd: (_) =>  widget.onShowIndicatorChanged(false),
        );
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Material(
                type: MaterialType.transparency,
                elevation: 8,
                child: Container(
                  constraints: BoxConstraints.tightFor(
                    width: box.maxWidth,
                    height: kSliderHeight,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    gradient: LinearGradient(
                      colors: widget.colors.map((c) => c.toColor()).toList(),
                    ),
                  ),
                  child: gestureDetector,
                ),
              ),
            ),
            Positioned(
              top: -(kIndicatorSize / 4),
              left: getWidth(getRatio(), box.maxWidth) - (kIndicatorSize / 2),
              child: Container(
                height: kIndicatorSize,
                width: kIndicatorSize,
                decoration: BoxDecoration(
                  color: widget.color.withValue(1).withSaturation(1).toColor(),
                  shape: BoxShape.circle,
                ),
                child: gestureDetector,
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

  final bool showIndicator;
  final ValueChanged<bool> onShowIndicatorChanged;

  const PaletteHuePicker({
    Key key,
    @required this.color,
    @required this.onChanged,
    @required this.showIndicator,
    @required this.onShowIndicatorChanged,
  })  : assert(color != null),
        super(key: key);

  List<HSVColor> get hueColors {
    final color = this.color.withSaturation(1).withValue(1);
    return <HSVColor>[
      color.withHue(0.0),
      color.withHue(60.0),
      color.withHue(120.0),
      color.withHue(180.0),
      color.withHue(240.0),
      color.withHue(300.0),
      color.withHue(0.0)
    ];
  }

  List<Color> get saturationColors => [
        Colors.white,
        HSVColor.fromAHSV(1.0, color.hue, 1.0, 1.0).toColor(),
      ];

  List<Color> get valueColors => [Colors.transparent, Colors.black];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Material(
              elevation: 8,
              child: PalettePicker(
                position: Offset(color.saturation, color.value),
                onChanged: (value) => onChanged(
                  HSVColor.fromAHSV(color.alpha, color.hue, value.dx, value.dy),
                ),
                color: color,
                topPosition: 1.0,
                bottomPosition: 0.0,
                leftRightColors: saturationColors,
                topBottomColors: valueColors,
                showIndicator: showIndicator,
                onShowIndicatorChanged: onShowIndicatorChanged,
              ),
            ),
          ),
          SizedBox(height: 14),
          SliderPicker(
            min: 0.0,
            max: 360.0,
            value: color.hue,
            onChanged: (value) => onChanged(color.withHue(value)),
            colors: hueColors,
            color: color,
            onShowIndicatorChanged: onShowIndicatorChanged,
          )
        ],
      ),
    );
  }
}
