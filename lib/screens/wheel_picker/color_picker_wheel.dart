import "dart:math" as math;

import 'package:flutter/material.dart';

import '../../widgets/indicator.dart';

class Wheel {
  static double vectorToHue(Offset vector) =>
      (((math.atan2(vector.dy, vector.dx)) * 180.0 / math.pi) + 360.0) % 360.0;
  static double vectorToSaturation(double vectorX, double squareRadio) =>
      vectorX * 0.5 / squareRadio + 0.5;
  static double vectorToValue(double vectorY, double squareRadio) =>
      0.5 - vectorY * 0.5 / squareRadio;

  static Offset hueToVector(double h, double radio, Offset center) =>
      Offset(math.cos(h) * radio + center.dx, math.sin(h) * radio + center.dy);
  static double saturationToVector(
          double s, double squareRadio, double centerX) =>
      (s - 0.5) * squareRadio / 0.5 + centerX;
  static double valueToVector(double l, double squareRadio, double centerY) =>
      (0.5 - l) * squareRadio / 0.5 + centerY;
}

class WheelPicker extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor> onChanged;

  WheelPicker({
    Key? key,
    required this.color,
    required this.onChanged,
  }) : super(key: key);

  @override
  _WheelPickerState createState() => _WheelPickerState();
}

class _WheelPickerState extends State<WheelPicker> {
  HSVColor get color => widget.color;

  final GlobalKey paletteKey = GlobalKey();

  Offset getOffset(Offset ratio) {
    RenderBox renderBox =
        paletteKey.currentContext!.findRenderObject() as RenderBox;
    Offset startPosition = renderBox.localToGlobal(Offset.zero);
    return ratio - startPosition;
  }

  Size getSize() {
    RenderBox renderBox =
        paletteKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size;
  }

  bool showIndicator = false;

  bool isWheel = false;
  bool isPalette = false;

  void onPanStart(
    Offset offset,
    Size size,
  ) {
    showIndicator = true;
    onPanUpdate(offset, size, true);
  }

  void onPanUpdate(Offset offset, Size size, [bool start = false]) {
    double radio = _WheelPainter.radio(size);
    double squareRadio = _WheelPainter.squareRadio(radio);

    Offset startPosition = Offset.zero;
    Offset center = Offset(size.width / 2, size.height / 2);
    Offset vector = offset - startPosition - center;

    if (start) {
      bool isPalette =
          vector.dx.abs() < squareRadio && vector.dy.abs() < squareRadio;
      isWheel = !isPalette;
      this.isPalette = isPalette;
    }

    if (isWheel) {
      widget.onChanged(color.withHue(Wheel.vectorToHue(vector)));
    }
    if (isPalette) {
      widget.onChanged(
        HSVColor.fromAHSV(
          color.alpha,
          color.hue,
          Wheel.vectorToSaturation(vector.dx, squareRadio).clamp(0.0, 1.0),
          Wheel.vectorToValue(vector.dy, squareRadio).clamp(0.0, 1.0),
        ),
      );
    }
  }

  void onPanDown(Offset offset) => isWheel = isPalette = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.9,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: LayoutBuilder(builder: (context, consts) {
          final size = consts.biggest;
          final center = Offset(size.width / 2, size.height / 2);
          final squareRadio =
              _WheelPainter.squareRadio(_WheelPainter.radio(size * 1.1));
          final indicatorX = Wheel.saturationToVector(
            color.saturation,
            squareRadio,
            center.dx,
          );
          final indicatorY = Wheel.valueToVector(
            color.value,
            squareRadio,
            center.dy,
          );
          return GestureDetector(
            onPanStart: (details) => onPanStart(details.localPosition, size),
            onPanUpdate: (details) => onPanUpdate(details.localPosition, size),
            onPanDown: (details) => onPanDown(details.localPosition),
            onPanEnd: (details) => setState(() => showIndicator = false),
            child: Stack(key: paletteKey, children: [
              Positioned.fill(
                child: CustomPaint(painter: _WheelPainter(color: color)),
              ),
              Positioned(
                top: indicatorY - (kIndicatorSize / 2),
                left: indicatorX - (kIndicatorSize / 2),
                child: ColorIndicator(
                  currentColor: color.toColor(),
                  show: showIndicator,
                ),
              )
            ]),
          );
        }),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  static double get strokeWidth => 8;
  static double get doubleStrokeWidth => 16;
  static double radio(Size size) =>
      math.min(size.width, size.height).toDouble() / 2 -
      _WheelPainter.strokeWidth;
  static double squareRadio(double radio) =>
      (radio - _WheelPainter.strokeWidth) / 1.414213562373095;

  final HSVColor color;

  _WheelPainter({required this.color}) : super();

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radio = _WheelPainter.radio(size * 1.1);
    double squareRadio = _WheelPainter.squareRadio(radio);

    // Wheel

    double wheelRadio = radio;

    Shader sweepShader = SweepGradient(
      center: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 255, 0, 0),
        Color.fromARGB(255, 255, 255, 0),
        Color.fromARGB(255, 0, 255, 0),
        Color.fromARGB(255, 0, 255, 255),
        Color.fromARGB(255, 0, 0, 255),
        Color.fromARGB(255, 255, 0, 255),
        Color.fromARGB(255, 255, 0, 0),
      ],
    ).createShader(Rect.fromLTWH(0, 0, wheelRadio, wheelRadio));
    canvas.drawCircle(
      center,
      wheelRadio,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = _WheelPainter.doubleStrokeWidth
        ..shader = sweepShader,
    );

    Offset wheel = Wheel.hueToVector(
      ((color.hue + 360.0) * math.pi / 180.0),
      wheelRadio,
      center,
    );
    canvas.drawCircle(
      wheel,
      wheelRadio * 0.15,
      Paint()
        ..color = color.withSaturation(1).withValue(1).toColor().withOpacity(1)
        ..style = PaintingStyle.fill,
    );

    // Palette
    Rect rect = Rect.fromLTWH(
      center.dx - squareRadio,
      center.dy - squareRadio,
      squareRadio * 2,
      squareRadio * 2,
    );
    RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(2.0));

    Shader horizontal = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.white,
        HSVColor.fromAHSV(1.0, color.hue, 1.0, 1.0).toColor()
      ],
    ).createShader(rect);
    canvas.drawRRect(
      rRect,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = horizontal,
    );

    Shader vertical = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, Colors.black],
    ).createShader(rect);
    canvas.drawRRect(
      rRect,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = vertical,
    );
  }

  @override
  bool shouldRepaint(covariant _WheelPainter other) => color != other.color;
}
