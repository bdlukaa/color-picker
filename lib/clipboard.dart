// Adapted from https://github.com/samuelezedi/flutter_clipboard/blob/master/lib/clipboard.dart

import 'package:flutter/services.dart';

/// A Flutter Clipboard Plugin.
class FlutterClipboard {
  /// copy receives a string text and saves to Clipboard
  /// returns void
  static Future<void> copy(String text) {
    assert(text != null, 'The text can not be null');
    return Clipboard.setData(ClipboardData(text: text));
  }

  /// Paste retrieves the data from clipboard.
  static Future<String> paste() async {
    ClipboardData data = await Clipboard.getData('text/plain');
    return data.text;
  }
}
