// ignore_for_file: diagnostic_describe_all_properties

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

final relativePath = Directory.current.path.contains('forui${Platform.pathSeparator}forui')
    ? '.'
    : '${Directory.current.path}/forui';

Future<void> expectBlueScreen([Object? actual]) =>
    expectLater(actual ?? find.byType(TestScaffold), matchesGoldenFile('blue-screen.png'));

List<FlutterErrorDetails> onFlutterError() {
  final original = FlutterError.onError;

  final errors = <FlutterErrorDetails>[];
  FlutterError.onError = errors.add;

  addTearDown(() => FlutterError.onError = original);

  return errors;
}

T autoDispose<T>(T disposable) {
  // We cast this to dynamic as there isn't a standard Disposable interface.
  addTearDown((disposable as dynamic).dispose);
  return disposable;
}

extension WidgetTesters on WidgetTester {
  Future<TestGesture> createPointerGesture({PointerDeviceKind kind = .mouse}) async {
    final gesture = await createGesture(kind: kind);
    await gesture.addPointer(location: .zero);
    addTearDown(gesture.removePointer);

    return gesture;
  }
}

class TestScaffold extends StatelessWidget {
  static final blueScreen = () {
    final colors = FColors(
      brightness: .light,
      systemOverlayStyle: .dark,
      barrier: const Color(0xFF03A9F4),
      background: const Color(0xFF03A9F4),
      foreground: const Color(0xFF03A9F4),

      primary: const Color(0xFF03A9F4),
      primaryForeground: const Color(0xFF03A9F4),
      secondary: const Color(0xFF03A9F4),
      secondaryForeground: const Color(0xFF03A9F4),
      muted: const Color(0xFF03A9F4),
      mutedForeground: const Color(0xFF03A9F4),
      destructive: const Color(0xFF03A9F4),
      destructiveForeground: const Color(0xFF03A9F4),
      error: const Color(0xFF03A9F4),
      errorForeground: const Color(0xFF03A9F4),
      card: const Color(0xFF03A9F4),
      border: const Color(0xFF03A9F4),
    );
    final typography = FTypography.inherit(colors: colors, touch: true);
    return FThemeData(
      colors: colors,
      typography: typography,
      style: .inherit(colors: colors, typography: typography, touch: true).copyWith(shadow: []),
      touch: true,
    );
  }();

  static final FThemeData greenOverride = FThemeData(
    touch: true,
    debugLabel: 'Test Green Override',
    colors: FColors.neutralDark.copyWith(
      background: const Color(0xFF0F2A18),
      card: const Color(0xFF15331F),
      border: const Color(0xFF2FA866),
      foreground: const Color(0xFFB7F5CE),
      mutedForeground: const Color(0xFF6FBE8E),
      primary: const Color(0xFF34C177),
      secondary: const Color(0xFF1C4A2E),
      secondaryForeground: const Color(0xFFB7F5CE),
    ),
  );

  static final FThemeData blueOverride = FThemeData(
    touch: true,
    debugLabel: 'Test Blue Override',
    colors: FColors.neutralDark.copyWith(
      background: const Color(0xFF0E1E3A),
      card: const Color(0xFF14284C),
      border: const Color(0xFF3B82F6),
      foreground: const Color(0xFFBBD5FF),
      mutedForeground: const Color(0xFF7FA8E0),
      primary: const Color(0xFF4C8DFF),
      secondary: const Color(0xFF1B3768),
      secondaryForeground: const Color(0xFFBBD5FF),
    ),
  );

  static final _default = FTheme.neutral;

  static List<({String name, FThemeData data})> get themes => [
    (name: 'neutral-light', data: _default.light.touch),
    (name: 'neutral-dark', data: _default.dark.touch),
  ];

  final FThemeData theme;
  final FPlatformVariant? platform;
  final Color? background;
  final Locale? locale;
  final TextDirection? textDirection;
  final Duration tooltipGroupActiveDuration;
  final Widget child;
  final Alignment alignment;
  final bool padded;
  final bool wrapped;

  TestScaffold({
    required this.child,
    this.platform,
    this.textDirection,
    this.alignment = .center,
    this.padded = true,
    this.tooltipGroupActiveDuration = const Duration(milliseconds: 300),
    FThemeData? theme,
    super.key,
  }) : locale = null,
       theme = theme ?? _default.light.touch,
       background = switch (theme) {
         _ when theme == _default.light.touch || theme == _default.light.desktop => const Color(0xFFEEFFFF),
         _ when theme == _default.dark.touch || theme == _default.dark.desktop => const Color(0xFF06111C),
         _ => null,
       },
       wrapped = false;

  TestScaffold.app({
    required this.child,
    this.platform,
    this.locale,
    this.textDirection,
    this.alignment = .center,
    this.padded = true,
    this.tooltipGroupActiveDuration = const Duration(milliseconds: 300),
    FThemeData? theme,
    super.key,
  }) : theme = theme ?? _default.light.touch,
       background = switch (theme) {
         _ when theme == _default.light.touch || theme == _default.light.desktop => const Color(0xFFEEFFFF),
         _ when theme == _default.dark.touch || theme == _default.dark.desktop => const Color(0xFF06111C),
         _ => null,
       },
       wrapped = true;

  TestScaffold.blue({required this.child, this.platform, this.alignment = .center, super.key})
    : theme = _default.light.touch,
      background = blueScreen.colors.background,
      locale = null,
      textDirection = null,
      tooltipGroupActiveDuration = const Duration(milliseconds: 300),
      padded = false,
      wrapped = true;

  @override
  Widget build(BuildContext context) {
    if (wrapped) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: locale,
        localizationsDelegates: FLocalizations.localizationsDelegates,
        supportedLocales: FLocalizations.supportedLocales,
        builder: (context, child) => FTheme(
          platform: platform,
          data: theme,
          textDirection: textDirection,
          child: Container(
            color: background ?? theme.colors.background,
            padding: padded ? const .all(16) : null,
            child: child!,
          ),
        ),
        home: Align(alignment: alignment, child: child),
      );
    } else {
      return FTheme(
        platform: platform,
        data: theme,
        textDirection: textDirection,
        child: Container(
          color: background ?? theme.colors.background,
          padding: padded ? const .all(16) : null,
          child: Align(alignment: alignment, child: child),
        ),
      );
    }
  }
}
