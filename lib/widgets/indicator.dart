import 'package:flutter/material.dart';

const double kIndicatorSize = 25;
const double kIndicatorPreviewSize = 40;
const double kIndicatorPreviewPadding = 6;

class ColorIndicator extends StatelessWidget {
  const ColorIndicator({
    Key? key,
    this.currentColor,
    this.show = false,
    this.below = false,
  }) : super(key: key);

  final Color? currentColor;
  final bool show;
  final bool below;

  @override
  Widget build(BuildContext context) {
    double padding = kIndicatorPreviewPadding;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        if (currentColor != null)
          Positioned(
            top: !below ? -kIndicatorPreviewSize - padding : null,
            bottom: below ? -kIndicatorPreviewSize - padding : null,
            left: -(kIndicatorPreviewSize / 3),
            right: -(kIndicatorPreviewSize / 3),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: !show
                  ? const SizedBox()
                  : Container(
                      height: kIndicatorPreviewSize,
                      width: kIndicatorPreviewSize,
                      decoration: BoxDecoration(
                        color: currentColor,
                        border: Border.all(
                          color: currentColor!.computeLuminance() >= 0.5
                              ? Colors.black
                              : Colors.white,
                          width: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
            ),
          ),
        Container(
          height: kIndicatorSize,
          width: kIndicatorSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(width: 1, color: Colors.white),
          ),
          alignment: Alignment.center,
          child: Container(height: 3, width: 3, color: Colors.red),
        ),
      ],
    );
  }
}
