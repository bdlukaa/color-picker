import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

// ignore: must_be_immutable
class ColorPickerWidget extends StatefulWidget {
  ColorPickerWidget({
    @required this.onUpdate,
    @required this.image,
  });

  final Function(Color) onUpdate;
  final ImageProvider image;

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  GlobalKey paintKey = GlobalKey();
  img.Image photo;

  Offset position = Offset(10, 10);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        RepaintBoundary(
          key: paintKey,
          // key: imageKey,
          child: GestureDetector(
            onPanStart: (details) {
              searchPixel(details.globalPosition);
              position = details.localPosition;
            },
            onPanDown: (details) {
              searchPixel(details.globalPosition);
              position = details.localPosition;
            },
            onPanUpdate: (details) {
              searchPixel(details.globalPosition);
              position = details.localPosition;
            },
            child: Center(
              child: Image(
                image: widget.image,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        Positioned(
          top: position.dy,
          left: position.dx,
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
        ),
      ],
    );
  }

  void searchPixel(Offset globalPosition) async {
    if (photo == null) await (loadSnapshotBytes());
    _calculatePixel(globalPosition);
  }

  void _calculatePixel(Offset globalPosition) {
    RenderBox box = paintKey.currentContext.findRenderObject();
    Offset localPosition = box.globalToLocal(globalPosition);

    double px = localPosition.dx;
    double py = localPosition.dy;

    // if (!useSnapshot) {
    //   double widgetScale = box.size.width / photo.width;
    //   // print(py);
    //   px = (px / widgetScale);
    //   py = (py / widgetScale);
    // }

    int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);

    widget.onUpdate(Color(hex));
  }

  // Future<void> loadImageBundleBytes() async {
  //   ByteData imageBytes = await rootBundle.load(imagePath);
  //   setImageBytes(imageBytes);
  // }

  Future<void> loadSnapshotBytes() async {
    RenderRepaintBoundary boxPaint = paintKey.currentContext.findRenderObject();
    ui.Image capture = await boxPaint.toImage();
    ByteData imageBytes =
        await capture.toByteData(format: ui.ImageByteFormat.png);
    setImageBytes(imageBytes);
    capture.dispose();
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
