import 'dart:convert';

import 'package:flutter/services.dart';

/// Loads the app's bundled fonts so text measures what users actually see.
Future<void> loadAppFonts() async {
  final manifest = jsonDecode(utf8.decode((await rootBundle.load('FontManifest.json')).buffer.asUint8List().toList()));
  for (final font in manifest as List<dynamic>) {
    final loader = FontLoader(font['family'] as String);
    for (final asset in font['fonts'] as List<dynamic>) {
      loader.addFont(rootBundle.load(asset['asset'] as String));
    }
    await loader.load();
  }
}
