import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// The typographical tokens grouped by their semantic roles.
///
/// ## CJK Text Alignment
///
/// When using CJK (Chinese, Japanese, Korean) scripts, text may appear vertically misaligned. This is a
/// [known Flutter issue](https://github.com/flutter/flutter/issues/22625).
///
/// As a temporary workaround, wrap the affected widget in a [DefaultTextStyle] with the appropriate [TextHeightBehavior]:
/// ```dart
/// DefaultTextStyle.merge(
///   textHeightBehavior: const TextHeightBehavior(
///     applyHeightToFirstAscent: false,
///     applyHeightToLastDescent: false,
///   ),
///   child: FButton(
///     onPressed: () {},
///     child: const Text('按钮'),
///   ),
/// )
/// ```
final class FTypography with Diagnosticable {
  /// The typographical tokens used for prominent text such as headings.
  final FTypeface display;

  /// The typographical tokens for content and UI text.
  final FTypeface body;

  final Map<Object, FScalableExtension<dynamic>> _extensions;

  /// Creates a [FTypography].
  FTypography({required this.display, required this.body, Iterable<FScalableExtension<dynamic>> extensions = const []})
    : _extensions = {for (final extension in extensions) extension.type: extension};

  /// Creates a [FTypography] that inherits its properties.
  factory FTypography.inherit({
    required FColors colors,
    required bool touch,
    Iterable<FScalableExtension<dynamic>> extensions = const [],
  }) {
    final typeface = FTypeface.inherit(colors: colors, touch: touch);
    return FTypography(display: typeface, body: typeface, extensions: extensions);
  }

  /// Creates a linear interpolation between two [FTypography]s using the given factor [t].
  factory FTypography.lerp(FTypography a, FTypography b, double t) => .new(
    display: a.display.lerp(b.display, t),
    body: a.body.lerp(b.body, t),
    extensions: (a._extensions.map(
      (id, extensionA) => MapEntry(id, extensionA.lerp(b._extensions[id], t)),
    )..addEntries(b._extensions.entries.where((entry) => !a._extensions.containsKey(entry.key)))).values,
  );

  /// Returns a copy of this [FTypography] with the given properties replaced.
  @useResult
  FTypography copyWith({FTypeface? display, FTypeface? body, Iterable<FScalableExtension<dynamic>>? extensions}) =>
      FTypography(
        display: display ?? this.display,
        body: body ?? this.body,
        extensions: extensions ?? _extensions.values,
      );

  /// Scales this [FTypography] by [sizeScalar].
  @useResult
  FTypography scale({double sizeScalar = 1}) => .new(
    display: display.scale(sizeScalar: sizeScalar),
    body: body.scale(sizeScalar: sizeScalar),
    extensions: [for (final extension in _extensions.values) extension.scale(sizeScalar: sizeScalar)],
  );

  /// Obtains a particular [FScalableExtension], such as an app's additional text styles.
  ///
  /// {@template forui.theme.FTypography.extension}
  /// ## Creating and passing a [FScalableExtension] to [FTypography]
  /// ```dart
  /// class AppTypography extends FScalableExtension<AppTypography> {
  ///   final TextStyle code;
  ///
  ///   const AppTypography({required this.code});
  ///
  ///   @override
  ///   AppTypography copyWith({TextStyle? code}) => AppTypography(code: code ?? this.code);
  ///
  ///   @override
  ///   AppTypography lerp(covariant AppTypography? other, double t) =>
  ///       other == null ? this : AppTypography(code: TextStyle.lerp(code, other.code, t)!);
  ///
  ///   @override
  ///   AppTypography scale({double sizeScalar = 1.0}) =>
  ///       AppTypography(code: code.copyWith(fontSize: (code.fontSize ?? 14) * sizeScalar));
  /// }
  ///
  /// final code = context.theme.typography.extension<AppTypography>().code;
  /// ```
  /// {@endtemplate}
  T extension<T extends Object>() => _extensions[T]! as T;

  /// All [FScalableExtension]s defined in this typography.
  ///
  /// {@macro forui.theme.FTypography.extension}
  Set<ThemeExtension<dynamic>> get extensions => _extensions.values.toSet();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('display', display))
      ..add(DiagnosticsProperty('body', body))
      ..add(IterableProperty('extensions', extensions));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTypography &&
          runtimeType == other.runtimeType &&
          display == other.display &&
          body == other.body &&
          mapEquals(_extensions, other._extensions);

  @override
  int get hashCode => display.hashCode ^ body.hashCode ^ Object.hashAllUnordered(_extensions.values);
}

/// Typographical tokens across different sizes, which are based on [Tailwind CSS](https://tailwindcss.com/docs/font-size).
///
/// A [FTypeface] is itself a [FScalableExtension], so it can be registered directly on a [FTypography] (e.g. a
/// monospace code typeface) and retrieved via `typography.extension<FTypeface>()`.
final class FTypeface extends FScalableExtension<FTypeface> with Diagnosticable {
  /// The default font family. Defaults to [`packages/forui/Inter`](https://fonts.google.com/specimen/Inter).
  static const String defaultFontFamily = 'packages/forui/Inter';

  /// The font family. Defaults to [defaultFontFamily].
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if empty.
  final String fontFamily;

  /// The font families to use as fallbacks when a glyph is not found in [fontFamily]. Defaults to an empty list.
  final List<String> fontFamilyFallback;

  /// The font size for extra extra extra small text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 8, `height` = 1.
  /// * Touch — `fontSize` = 10, `height` = 1.
  final TextStyle xs3;

  /// The font size for extra extra small text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 10, `height` = 1.
  /// * Touch — `fontSize` = 12, `height` = 1.
  final TextStyle xs2;

  /// The font size for extra small text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 12, `height` = 1.
  /// * Touch — `fontSize` = 14, `height` = 1.25.
  final TextStyle xs;

  /// The font size for small text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 14, `height` = 1.25.
  /// * Touch — `fontSize` = 16, `height` = 1.5.
  final TextStyle sm;

  /// The font size for medium text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 16, `height` = 1.5.
  /// * Touch — `fontSize` = 18, `height` = 1.75.
  final TextStyle md;

  /// The font size for large text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 18, `height` = 1.75.
  /// * Touch — `fontSize` = 20, `height` = 1.75.
  final TextStyle lg;

  /// The font size for extra large text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 20, `height` = 1.75.
  /// * Touch — `fontSize` = 22, `height` = 2.
  final TextStyle xl;

  /// The font size for extra large text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 22, `height` = 2.
  /// * Touch — `fontSize` = 30, `height` = 2.25.
  final TextStyle xl2;

  /// The font size for extra large text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 30, `height` = 2.25.
  /// * Touch — `fontSize` = 36, `height` = 2.5.
  final TextStyle xl3;

  /// The font size for extra large text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 36, `height` = 2.5.
  /// * Touch — `fontSize` = 48, `height` = 1.
  final TextStyle xl4;

  /// The font size for extra large text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 48, `height` = 1.
  /// * Touch — `fontSize` = 60, `height` = 1.
  final TextStyle xl5;

  /// The font size for extra large text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 60, `height` = 1.
  /// * Touch — `fontSize` = 72, `height` = 1.
  final TextStyle xl6;

  /// The font size for extra large text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 72, `height` = 1.
  /// * Touch — `fontSize` = 96, `height` = 1.
  final TextStyle xl7;

  /// The font size for extra large text.
  ///
  /// Defaults to:
  /// * Desktop — `fontSize` = 96, `height` = 1.
  /// * Touch — `fontSize` = 108, `height` = 1.
  final TextStyle xl8;

  final Map<Object, FScalableExtension<dynamic>> _extensions;

  /// Creates a [FTypeface] that defaults to touch font sizes.
  FTypeface({
    this.fontFamily = FTypeface.defaultFontFamily,
    List<String>? fontFamilyFallback,
    TextStyle? xs3,
    TextStyle? xs2,
    TextStyle? xs,
    TextStyle? sm,
    TextStyle? md,
    TextStyle? lg,
    TextStyle? xl,
    TextStyle? xl2,
    TextStyle? xl3,
    TextStyle? xl4,
    TextStyle? xl5,
    TextStyle? xl6,
    TextStyle? xl7,
    TextStyle? xl8,
    Iterable<FScalableExtension<dynamic>> extensions = const [],
  }) : fontFamilyFallback = fontFamilyFallback ?? const [],
       xs3 =
           xs3 ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 10,
             height: 1,
             leadingDistribution: .even,
           ),
       xs2 =
           xs2 ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 12,
             height: 1,
             leadingDistribution: .even,
           ),
       xs =
           xs ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 14,
             height: 1.25,
             leadingDistribution: .even,
           ),
       sm =
           sm ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 16,
             height: 1.5,
             leadingDistribution: .even,
           ),
       md =
           md ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 18,
             height: 1.75,
             leadingDistribution: .even,
           ),
       lg =
           lg ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 20,
             height: 1.75,
             leadingDistribution: .even,
           ),
       xl =
           xl ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 22,
             height: 2,
             leadingDistribution: .even,
           ),
       xl2 =
           xl2 ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 30,
             height: 2.25,
             leadingDistribution: .even,
           ),
       xl3 =
           xl3 ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 36,
             height: 2.5,
             leadingDistribution: .even,
           ),
       xl4 =
           xl4 ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 48,
             height: 1,
             leadingDistribution: .even,
           ),
       xl5 =
           xl5 ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 60,
             height: 1,
             leadingDistribution: .even,
           ),
       xl6 =
           xl6 ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 72,
             height: 1,
             leadingDistribution: .even,
           ),
       xl7 =
           xl7 ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 96,
             height: 1,
             leadingDistribution: .even,
           ),
       xl8 =
           xl8 ??
           TextStyle(
             fontFamily: fontFamily,
             fontFamilyFallback: fontFamilyFallback,
             fontSize: 108,
             height: 1,
             leadingDistribution: .even,
           ),
       _extensions = {for (final extension in extensions) extension.type: extension},
       assert(fontFamily.isNotEmpty, 'fontFamily ($fontFamily) should not be empty.');

  /// Creates a [FTypeface] that inherits its properties.
  factory FTypeface.inherit({
    required FColors colors,
    required bool touch,
    String fontFamily = FTypeface.defaultFontFamily,
    List<String>? fontFamilyFallback,
  }) {
    assert(fontFamily.isNotEmpty, 'fontFamily ($fontFamily) should not be empty.');
    final color = colors.foreground;
    if (touch) {
      return FTypeface(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        xs3: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 10,
          height: 1,
          leadingDistribution: .even,
        ),
        xs2: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 12,
          height: 1,
          leadingDistribution: .even,
        ),
        xs: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 14,
          height: 1.25,
          leadingDistribution: .even,
        ),
        sm: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 16,
          height: 1.5,
          leadingDistribution: .even,
        ),
        md: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 18,
          height: 1.75,
          leadingDistribution: .even,
        ),
        lg: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 20,
          height: 1.75,
          leadingDistribution: .even,
        ),
        xl: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 22,
          height: 2,
          leadingDistribution: .even,
        ),
        xl2: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 30,
          height: 2.25,
          leadingDistribution: .even,
        ),
        xl3: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 36,
          height: 2.5,
          leadingDistribution: .even,
        ),
        xl4: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 48,
          height: 1,
          leadingDistribution: .even,
        ),
        xl5: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 60,
          height: 1,
          leadingDistribution: .even,
        ),
        xl6: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 72,
          height: 1,
          leadingDistribution: .even,
        ),
        xl7: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 96,
          height: 1,
          leadingDistribution: .even,
        ),
        xl8: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 108,
          height: 1,
          leadingDistribution: .even,
        ),
      );
    } else {
      return FTypeface(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        xs3: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 8,
          height: 1,
          leadingDistribution: .even,
        ),
        xs2: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 10,
          height: 1,
          leadingDistribution: .even,
        ),
        xs: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 12,
          height: 1,
          leadingDistribution: .even,
        ),
        sm: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 14,
          height: 1.25,
          leadingDistribution: .even,
        ),
        md: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 16,
          height: 1.5,
          leadingDistribution: .even,
        ),
        lg: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 18,
          height: 1.75,
          leadingDistribution: .even,
        ),
        xl: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 20,
          height: 1.75,
          leadingDistribution: .even,
        ),
        xl2: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 22,
          height: 2,
          leadingDistribution: .even,
        ),
        xl3: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 30,
          height: 2.25,
          leadingDistribution: .even,
        ),
        xl4: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 36,
          height: 2.5,
          leadingDistribution: .even,
        ),
        xl5: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 48,
          height: 1,
          leadingDistribution: .even,
        ),
        xl6: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 60,
          height: 1,
          leadingDistribution: .even,
        ),
        xl7: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 72,
          height: 1,
          leadingDistribution: .even,
        ),
        xl8: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 96,
          height: 1,
          leadingDistribution: .even,
        ),
      );
    }
  }

  /// Linearly interpolates between this [FTypeface] and [other] using the given factor [t].
  @override
  FTypeface lerp(covariant FTypeface? other, double t) {
    if (other == null) {
      return this;
    }

    return FTypeface(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
      fontFamilyFallback: t < 0.5 ? fontFamilyFallback : other.fontFamilyFallback,
      xs3: .lerp(xs3, other.xs3, t)!,
      xs2: .lerp(xs2, other.xs2, t)!,
      xs: .lerp(xs, other.xs, t)!,
      sm: .lerp(sm, other.sm, t)!,
      md: .lerp(md, other.md, t)!,
      lg: .lerp(lg, other.lg, t)!,
      xl: .lerp(xl, other.xl, t)!,
      xl2: .lerp(xl2, other.xl2, t)!,
      xl3: .lerp(xl3, other.xl3, t)!,
      xl4: .lerp(xl4, other.xl4, t)!,
      xl5: .lerp(xl5, other.xl5, t)!,
      xl6: .lerp(xl6, other.xl6, t)!,
      xl7: .lerp(xl7, other.xl7, t)!,
      xl8: .lerp(xl8, other.xl8, t)!,
      extensions: (_extensions.map(
        (id, extension) => MapEntry(id, extension.lerp(other._extensions[id], t)),
      )..addEntries(other._extensions.entries.where((entry) => !_extensions.containsKey(entry.key)))).values,
    );
  }

  /// Returns a copy of this [FTypeface] with the given properties replaced.
  ///
  /// To change the [fontFamily] or [fontFamilyFallback], create a [FTypeface] via its constructors instead.
  ///
  /// ```dart
  /// const typeface = FTypeface(
  ///   sm: TextStyle(fontSize: 10),
  ///   md: TextStyle(fontSize: 20),
  /// );
  ///
  /// final copy = typeface.copyWith(sm: TextStyle(fontSize: 12));
  ///
  /// print(copy.sm.fontSize); // 12
  /// print(copy.md.fontSize); // 20
  /// ```
  @override
  @useResult
  FTypeface copyWith({
    TextStyle? xs3,
    TextStyle? xs2,
    TextStyle? xs,
    TextStyle? sm,
    TextStyle? md,
    TextStyle? lg,
    TextStyle? xl,
    TextStyle? xl2,
    TextStyle? xl3,
    TextStyle? xl4,
    TextStyle? xl5,
    TextStyle? xl6,
    TextStyle? xl7,
    TextStyle? xl8,
    Iterable<FScalableExtension<dynamic>>? extensions,
  }) => FTypeface(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    xs3: xs3 ?? this.xs3,
    xs2: xs2 ?? this.xs2,
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
    xl2: xl2 ?? this.xl2,
    xl3: xl3 ?? this.xl3,
    xl4: xl4 ?? this.xl4,
    xl5: xl5 ?? this.xl5,
    xl6: xl6 ?? this.xl6,
    xl7: xl7 ?? this.xl7,
    xl8: xl8 ?? this.xl8,
    extensions: extensions ?? _extensions.values,
  );

  /// Scales this [FTypeface] by [sizeScalar].
  ///
  /// ```dart
  /// const typeface = FTypeface(
  ///   sm: TextStyle(fontSize: 10),
  ///   md: TextStyle(fontSize: 20),
  /// );
  ///
  /// final scaled = typeface.scale(sizeScalar: 1.5);
  ///
  /// print(scaled.sm.fontSize); // 15
  /// print(scaled.md.fontSize); // 30
  /// ```
  @override
  @useResult
  FTypeface scale({double sizeScalar = 1}) => .new(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    xs3: _scale(style: xs3, sizeScalar: sizeScalar),
    xs2: _scale(style: xs2, sizeScalar: sizeScalar),
    xs: _scale(style: xs, sizeScalar: sizeScalar),
    sm: _scale(style: sm, sizeScalar: sizeScalar),
    md: _scale(style: md, sizeScalar: sizeScalar),
    lg: _scale(style: lg, sizeScalar: sizeScalar),
    xl: _scale(style: xl, sizeScalar: sizeScalar),
    xl2: _scale(style: xl2, sizeScalar: sizeScalar),
    xl3: _scale(style: xl3, sizeScalar: sizeScalar),
    xl4: _scale(style: xl4, sizeScalar: sizeScalar),
    xl5: _scale(style: xl5, sizeScalar: sizeScalar),
    xl6: _scale(style: xl6, sizeScalar: sizeScalar),
    xl7: _scale(style: xl7, sizeScalar: sizeScalar),
    xl8: _scale(style: xl8, sizeScalar: sizeScalar),
    extensions: [for (final extension in _extensions.values) extension.scale(sizeScalar: sizeScalar)],
  );

  // Default font size: https://api.flutter.dev/flutter/painting/TextStyle/fontSize.html
  TextStyle _scale({required TextStyle style, required double sizeScalar}) =>
      style.copyWith(fontSize: (style.fontSize ?? 14) * sizeScalar);

  /// Obtains a particular [FScalableExtension].
  ///
  /// {@template forui.theme.FTypeface.extension}
  /// ## Creating and passing a [FScalableExtension] to [FTypeface]
  /// ```dart
  /// class BrandTypeface extends FScalableExtension<BrandTypeface> {
  ///   final TextStyle display;
  ///
  ///   const BrandTypeface({required this.display});
  ///
  ///   @override
  ///   BrandTypeface copyWith({TextStyle? display}) => BrandTypeface(display: display ?? this.display);
  ///
  ///   @override
  ///   BrandTypeface lerp(BrandTypeface? other, double t) {
  ///     if (other is! BrandTypeface) return this;
  ///     return BrandTypeface(display: TextStyle.lerp(display, other.display, t)!);
  ///   }
  ///
  ///   @override
  ///   BrandTypeface scale({double sizeScalar = 1.0}) =>
  ///       BrandTypeface(display: display.copyWith(fontSize: (display.fontSize ?? 14) * sizeScalar));
  /// }
  /// ```
  ///
  /// Passing it via constructor:
  /// ```dart
  /// final body = FTypeface(
  ///   extensions: [BrandTypeface(display: TextStyle(fontSize: 32, fontWeight: .bold))],
  ///   ... // other fields omitted for brevity
  /// );
  /// ```
  ///
  /// Passing it via [copyWith]:
  /// ```dart
  /// body.copyWith(extensions: [
  ///   BrandTypeface(display: TextStyle(fontSize: 32, fontWeight: .bold)),
  /// ]);
  /// ```
  ///
  /// ## Accessing the extension
  /// ```dart
  /// final brand = context.theme.typography.body.extension<BrandTypeface>();
  /// ```
  ///
  /// It is recommended to define a getter for your [FScalableExtension]:
  /// ```dart
  /// extension FTypefaceBrandTypeface on FTypeface {
  ///   BrandTypeface get brand => extension<BrandTypeface>();
  ///
  ///   // Alternatively
  ///   TextStyle get display => extension<BrandTypeface>().display;
  /// }
  ///
  /// final brand = context.theme.typography.body.brand;
  ///
  /// final display = context.theme.typography.body.display;
  /// ```
  /// {@endtemplate}
  T extension<T extends Object>() => _extensions[T]! as T;

  /// All [FScalableExtension]s defined in this typeface.
  ///
  /// {@macro forui.theme.FTypeface.extension}
  Set<ThemeExtension<dynamic>> get extensions => _extensions.values.toSet();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('fontFamily', fontFamily, defaultValue: defaultFontFamily))
      ..add(IterableProperty('fontFamilyFallback', fontFamilyFallback, defaultValue: const []))
      ..add(DiagnosticsProperty('xs3', xs3))
      ..add(DiagnosticsProperty('xs2', xs2))
      ..add(DiagnosticsProperty('xs', xs))
      ..add(DiagnosticsProperty('sm', sm))
      ..add(DiagnosticsProperty('md', md))
      ..add(DiagnosticsProperty('lg', lg))
      ..add(DiagnosticsProperty('xl', xl))
      ..add(DiagnosticsProperty('xl2', xl2))
      ..add(DiagnosticsProperty('xl3', xl3))
      ..add(DiagnosticsProperty('xl4', xl4))
      ..add(DiagnosticsProperty('xl5', xl5))
      ..add(DiagnosticsProperty('xl6', xl6))
      ..add(DiagnosticsProperty('xl7', xl7))
      ..add(DiagnosticsProperty('xl8', xl8))
      ..add(IterableProperty('extensions', extensions));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTypeface &&
          runtimeType == other.runtimeType &&
          fontFamily == other.fontFamily &&
          listEquals(fontFamilyFallback, other.fontFamilyFallback) &&
          xs3 == other.xs3 &&
          xs2 == other.xs2 &&
          xs == other.xs &&
          sm == other.sm &&
          md == other.md &&
          lg == other.lg &&
          xl == other.xl &&
          xl2 == other.xl2 &&
          xl3 == other.xl3 &&
          xl4 == other.xl4 &&
          xl5 == other.xl5 &&
          xl6 == other.xl6 &&
          xl7 == other.xl7 &&
          xl8 == other.xl8 &&
          mapEquals(_extensions, other._extensions);

  @override
  int get hashCode =>
      fontFamily.hashCode ^
      Object.hashAll(fontFamilyFallback) ^
      xs3.hashCode ^
      xs2.hashCode ^
      xs.hashCode ^
      sm.hashCode ^
      md.hashCode ^
      lg.hashCode ^
      xl.hashCode ^
      xl2.hashCode ^
      xl3.hashCode ^
      xl4.hashCode ^
      xl5.hashCode ^
      xl6.hashCode ^
      xl7.hashCode ^
      xl8.hashCode ^
      Object.hashAllUnordered(_extensions.values);
}

/// A [ThemeExtension] that scales with the font size scalar, used for typographical tokens in a [FTypography] and
/// [FTypeface].
abstract class FScalableExtension<T extends FScalableExtension<T>> extends ThemeExtension<T> {
  /// Creates a [FScalableExtension].
  const FScalableExtension();

  @override
  FScalableExtension<T> lerp(FScalableExtension<T>? other, double t);

  @override
  FScalableExtension<T> copyWith();

  /// Scales this [FScalableExtension] by [sizeScalar].
  FScalableExtension<T> scale({double sizeScalar = 1.0});
}
