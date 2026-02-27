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
    const colors = FColors(
      brightness: .light,
      systemOverlayStyle: .dark,
      barrier: Color(0xFF03A9F4),
      background: Color(0xFF03A9F4),
      foreground: Color(0xFF03A9F4),

      primary: Color(0xFF03A9F4),
      primaryForeground: Color(0xFF03A9F4),
      secondary: Color(0xFF03A9F4),
      secondaryForeground: Color(0xFF03A9F4),
      muted: Color(0xFF03A9F4),
      mutedForeground: Color(0xFF03A9F4),
      destructive: Color(0xFF03A9F4),
      destructiveForeground: Color(0xFF03A9F4),
      error: Color(0xFF03A9F4),
      errorForeground: Color(0xFF03A9F4),
      card: Color(0xFF03A9F4),
      border: Color(0xFF03A9F4),
    );
    final typography = FTypography.inherit(colors: colors);
    final style = FStyle.inherit(colors: colors, typography: typography).copyWith(shadow: []);

    return FThemeData(colors: colors, typography: typography, style: style);
  }();

  static List<({String name, FThemeData data})> get themes => [
    (name: 'neutral-light', data: FThemes.neutral.light.touch),
    (name: 'neutral-dark', data: FThemes.neutral.dark.touch),
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
       theme = theme ?? FThemes.neutral.light.touch,
       background = switch (theme) {
         _ when theme == FThemes.neutral.light.touch => const Color(0xFFEEFFFF),
         _ when theme == FThemes.neutral.dark.touch => const Color(0xFF06111C),
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
  }) : theme = theme ?? FThemes.neutral.light.touch,
       background = switch (theme) {
         _ when theme == FThemes.neutral.light.touch => const Color(0xFFEEFFFF),
         _ when theme == FThemes.neutral.dark.touch => const Color(0xFF06111C),
         _ => null,
       },
       wrapped = true;

  TestScaffold.blue({required this.child, this.platform, this.alignment = .center, super.key})
    : theme = FThemes.neutral.light.touch,
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
