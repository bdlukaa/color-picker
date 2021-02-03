import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../lang/lang.dart';

class SupportedPlatform extends StatelessWidget {
  const SupportedPlatform({
    Key key,
    @required this.child,
    this.supportedPlatforms,
    this.supportWeb = true,
  }) : super(key: key);

  final Widget child;
  final List<TargetPlatform> supportedPlatforms;
  final bool supportWeb;

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);

    final supportedPlatforms = [TargetPlatform.android, TargetPlatform.iOS];
    // Local image is not supported because Web does not support files
    //
    // Network image is not supported because [RepaintBoundary.toImage()] was
    // not implemented on web yet.
    if (!supportedPlatforms.contains(defaultTargetPlatform) || (kIsWeb && !supportWeb)) {
      return Center(
        child: Text(
          lang.supportedPlatforms(supportedPlatforms),
          textAlign: TextAlign.center,
        ),
      );
    }
    return child;
  }
}
