import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

import '../../widgets/indicator.dart';

class ColorPickerWidget extends StatefulWidget {
  ColorPickerWidget({
    Key key,
    @required this.onUpdate,
    @required this.image,
  }) : super(key: key);

  final Function(Color) onUpdate;
  final Widget image;

  @override
  ColorPickerWidgetState createState() => ColorPickerWidgetState();
}

class ColorPickerWidgetState extends State<ColorPickerWidget> {
  final paintKey = GlobalKey();
  img.Image photo;

  Offset position = Offset(10, 10);

  Color color;
  bool showColor;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        key: paintKey,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onPanStart: (details) {
                showColor = true;
                searchPixel(details.globalPosition);
              },
              onPanEnd: (_) => setState(() => showColor = false),
              onPanDown: (details) {
                searchPixel(details.globalPosition);
              },
              onPanUpdate: (details) {
                searchPixel(details.globalPosition);
              },
              child: Center(
                // child: Image(
                //   image: widget.image,
                //   fit: BoxFit.contain,
                //   alignment: Alignment.center,
                // ),
                child: widget.image,
              ),
            ),
            Positioned(
              // divide by two so the collected color is in the center of the
              // bubble, not on the right top
              top: position.dy - (25 / 2),
              left: position.dx - (25 / 2),
              child: ColorIndicator(currentColor: color, show: showColor),
            ),
          ],
        ));
  }

  void searchPixel(Offset globalPosition) async {
    if (photo == null) await (loadSnapshotBytes());
    _calculatePixel(globalPosition);
  }

  void _calculatePixel(Offset globalPosition) {
    RenderBox box = paintKey.currentContext.findRenderObject();
    Offset localPosition = box.globalToLocal(globalPosition);
    position = localPosition;

    double px = position.dx;
    double py = position.dy;

    int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);

    color = Color(hex);
    widget.onUpdate(color);
  }

  Future<void> loadSnapshotBytes() async {
    RenderRepaintBoundary boxPaint = paintKey.currentContext.findRenderObject();
    ui.Image capture = await boxPaint.toImage();
    ByteData imageBytes =
        await capture.toByteData(format: ui.ImageByteFormat.png);
    setImageBytes(imageBytes);
    capture.dispose();
    widget.onUpdate(color);
  }

  void setImageBytes(ByteData imageBytes) {
    List<int> values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
  }
}

// image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
