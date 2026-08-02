import 'dart:async';

import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Without the real fonts, text falls back to a font that renders every glyph as a full em square. Widgets with
  // fixed-size layouts, i.e. FCalendar, overflow as a result.
  final inter = FontLoader('packages/forui/Inter')
    ..addFont(rootBundle.load('packages/forui/assets/fonts/inter/Inter.ttf'))
    ..addFont(rootBundle.load('packages/forui/assets/fonts/inter/Inter-Italic.ttf'));
  await inter.load();

  final lucide = FontLoader('packages/forui_assets/ForuiLucideIcons')
    ..addFont(rootBundle.load('packages/forui_assets/assets/lucide.ttf'));
  await lucide.load();

  await testMain();
}
