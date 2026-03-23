import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// The typographical tokens.
///
/// A [FTypography] contains scalar values for scaling a [TextStyle]'s corresponding properties. It also contains labelled
/// font sizes, such as [FTypography.xs], which are based on [Tailwind CSS](https://tailwindcss.com/docs/font-size).
///
/// The scaling is applied automatically in all Forui widgets while the labelled font sizes are used as the defaults
/// for the corresponding properties of widget styles configured via `inherit(...)` constructors.
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
  /// The default font family. Defaults to [`packages/forui/Inter`](https://fonts.google.com/specimen/Inter).
  static const String defaultFontFamily = 'packages/forui/Inter';

  /// The font family. Defaults to [defaultFontFamily].
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if empty.
  final String fontFamily;

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

  /// Creates a [FTypography] that defaults to touch font sizes.
  FTypography({
    this.fontFamily = defaultFontFamily,
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
  }) : xs3 = xs3 ?? TextStyle(fontFamily: fontFamily, fontSize: 10, height: 1, leadingDistribution: .even),
       xs2 = xs2 ?? TextStyle(fontFamily: fontFamily, fontSize: 12, height: 1, leadingDistribution: .even),
       xs = xs ?? TextStyle(fontFamily: fontFamily, fontSize: 14, height: 1.25, leadingDistribution: .even),
       sm = sm ?? TextStyle(fontFamily: fontFamily, fontSize: 16, height: 1.5, leadingDistribution: .even),
       md = md ?? TextStyle(fontFamily: fontFamily, fontSize: 18, height: 1.75, leadingDistribution: .even),
       lg = lg ?? TextStyle(fontFamily: fontFamily, fontSize: 20, height: 1.75, leadingDistribution: .even),
       xl = xl ?? TextStyle(fontFamily: fontFamily, fontSize: 22, height: 2, leadingDistribution: .even),
       xl2 = xl2 ?? TextStyle(fontFamily: fontFamily, fontSize: 30, height: 2.25, leadingDistribution: .even),
       xl3 = xl3 ?? TextStyle(fontFamily: fontFamily, fontSize: 36, height: 2.5, leadingDistribution: .even),
       xl4 = xl4 ?? TextStyle(fontFamily: fontFamily, fontSize: 48, height: 1, leadingDistribution: .even),
       xl5 = xl5 ?? TextStyle(fontFamily: fontFamily, fontSize: 60, height: 1, leadingDistribution: .even),
       xl6 = xl6 ?? TextStyle(fontFamily: fontFamily, fontSize: 72, height: 1, leadingDistribution: .even),
       xl7 = xl7 ?? TextStyle(fontFamily: fontFamily, fontSize: 96, height: 1, leadingDistribution: .even),
       xl8 = xl8 ?? TextStyle(fontFamily: fontFamily, fontSize: 108, height: 1, leadingDistribution: .even),
       assert(fontFamily.isNotEmpty, 'fontFamily ($fontFamily) should not be empty.');

  /// Creates a [FTypography] that inherits its properties.
  factory FTypography.inherit({
    required FColors colors,
    required bool touch,
    String fontFamily = defaultFontFamily,
  }) {
    assert(fontFamily.isNotEmpty, 'fontFamily ($fontFamily) should not be empty.');
    final color = colors.foreground;
    final font = fontFamily;

    if (touch) {
      return FTypography(
        fontFamily: fontFamily,
        xs3: TextStyle(color: color, fontFamily: font, fontSize: 10, height: 1, leadingDistribution: .even),
        xs2: TextStyle(color: color, fontFamily: font, fontSize: 12, height: 1, leadingDistribution: .even),
        xs: TextStyle(color: color, fontFamily: font, fontSize: 14, height: 1.25, leadingDistribution: .even),
        sm: TextStyle(color: color, fontFamily: font, fontSize: 16, height: 1.5, leadingDistribution: .even),
        md: TextStyle(color: color, fontFamily: font, fontSize: 18, height: 1.75, leadingDistribution: .even),
        lg: TextStyle(color: color, fontFamily: font, fontSize: 20, height: 1.75, leadingDistribution: .even),
        xl: TextStyle(color: color, fontFamily: font, fontSize: 22, height: 2, leadingDistribution: .even),
        xl2: TextStyle(color: color, fontFamily: font, fontSize: 30, height: 2.25, leadingDistribution: .even),
        xl3: TextStyle(color: color, fontFamily: font, fontSize: 36, height: 2.5, leadingDistribution: .even),
        xl4: TextStyle(color: color, fontFamily: font, fontSize: 48, height: 1, leadingDistribution: .even),
        xl5: TextStyle(color: color, fontFamily: font, fontSize: 60, height: 1, leadingDistribution: .even),
        xl6: TextStyle(color: color, fontFamily: font, fontSize: 72, height: 1, leadingDistribution: .even),
        xl7: TextStyle(color: color, fontFamily: font, fontSize: 96, height: 1, leadingDistribution: .even),
        xl8: TextStyle(color: color, fontFamily: font, fontSize: 108, height: 1, leadingDistribution: .even),
      );
    } else {
      return FTypography(
        fontFamily: fontFamily,
        xs3: TextStyle(color: color, fontFamily: font, fontSize: 8, height: 1, leadingDistribution: .even),
        xs2: TextStyle(color: color, fontFamily: font, fontSize: 10, height: 1, leadingDistribution: .even),
        xs: TextStyle(color: color, fontFamily: font, fontSize: 12, height: 1, leadingDistribution: .even),
        sm: TextStyle(color: color, fontFamily: font, fontSize: 14, height: 1.25, leadingDistribution: .even),
        md: TextStyle(color: color, fontFamily: font, fontSize: 16, height: 1.5, leadingDistribution: .even),
        lg: TextStyle(color: color, fontFamily: font, fontSize: 18, height: 1.75, leadingDistribution: .even),
        xl: TextStyle(color: color, fontFamily: font, fontSize: 20, height: 1.75, leadingDistribution: .even),
        xl2: TextStyle(color: color, fontFamily: font, fontSize: 22, height: 2, leadingDistribution: .even),
        xl3: TextStyle(color: color, fontFamily: font, fontSize: 30, height: 2.25, leadingDistribution: .even),
        xl4: TextStyle(color: color, fontFamily: font, fontSize: 36, height: 2.5, leadingDistribution: .even),
        xl5: TextStyle(color: color, fontFamily: font, fontSize: 48, height: 1, leadingDistribution: .even),
        xl6: TextStyle(color: color, fontFamily: font, fontSize: 60, height: 1, leadingDistribution: .even),
        xl7: TextStyle(color: color, fontFamily: font, fontSize: 72, height: 1, leadingDistribution: .even),
        xl8: TextStyle(color: color, fontFamily: font, fontSize: 96, height: 1, leadingDistribution: .even),
      );
    }
  }

  /// Creates a linear interpolation between two [FTypography]s using the given factor [t].
  factory FTypography.lerp(FTypography a, FTypography b, double t) => .new(
    fontFamily: t < 0.5 ? a.fontFamily : b.fontFamily,
    xs3: .lerp(a.xs3, b.xs3, t)!,
    xs2: .lerp(a.xs2, b.xs2, t)!,
    xs: .lerp(a.xs, b.xs, t)!,
    sm: .lerp(a.sm, b.sm, t)!,
    md: .lerp(a.md, b.md, t)!,
    lg: .lerp(a.lg, b.lg, t)!,
    xl: .lerp(a.xl, b.xl, t)!,
    xl2: .lerp(a.xl2, b.xl2, t)!,
    xl3: .lerp(a.xl3, b.xl3, t)!,
    xl4: .lerp(a.xl4, b.xl4, t)!,
    xl5: .lerp(a.xl5, b.xl5, t)!,
    xl6: .lerp(a.xl6, b.xl6, t)!,
    xl7: .lerp(a.xl7, b.xl7, t)!,
    xl8: .lerp(a.xl8, b.xl8, t)!,
  );

  /// Scales the fields of this [FTypography] by the given fields.
  ///
  /// ```dart
  /// const typography = FTypography(
  ///   sm: TextStyle(fontSize: 10),
  ///   md: TextStyle(fontSize: 20),
  /// );
  ///
  /// final scaled = typography.scale(sizeScalar: 1.5);
  ///
  /// print(scaled.sm.fontSize); // 15
  /// print(scaled.md.fontSize); // 30
  /// ```
  @useResult
  FTypography scale({double sizeScalar = 1}) => .new(
    fontFamily: fontFamily,
    xs3: _scaleTextStyle(style: xs3, sizeScalar: sizeScalar),
    xs2: _scaleTextStyle(style: xs2, sizeScalar: sizeScalar),
    xs: _scaleTextStyle(style: xs, sizeScalar: sizeScalar),
    sm: _scaleTextStyle(style: sm, sizeScalar: sizeScalar),
    md: _scaleTextStyle(style: md, sizeScalar: sizeScalar),
    lg: _scaleTextStyle(style: lg, sizeScalar: sizeScalar),
    xl: _scaleTextStyle(style: xl, sizeScalar: sizeScalar),
    xl2: _scaleTextStyle(style: xl2, sizeScalar: sizeScalar),
    xl3: _scaleTextStyle(style: xl3, sizeScalar: sizeScalar),
    xl4: _scaleTextStyle(style: xl4, sizeScalar: sizeScalar),
    xl5: _scaleTextStyle(style: xl5, sizeScalar: sizeScalar),
    xl6: _scaleTextStyle(style: xl6, sizeScalar: sizeScalar),
    xl7: _scaleTextStyle(style: xl7, sizeScalar: sizeScalar),
    xl8: _scaleTextStyle(style: xl8, sizeScalar: sizeScalar),
  );

  // default font size: https://api.flutter.dev/flutter/painting/TextStyle/fontSize.html
  TextStyle _scaleTextStyle({required TextStyle style, required double sizeScalar}) =>
      style.copyWith(fontSize: (style.fontSize ?? 14) * sizeScalar);

  /// Returns a copy of this [FTypography] with the given properties replaced.
  ///
  /// To change the [fontFamily], create a [FTypography] via its constructors instead.
  ///
  /// ```dart
  /// const typography = FTypography(
  ///   fontFamily: 'packages/forui/my-font',
  ///   sm: TextStyle(fontSize: 10),
  ///   md: TextStyle(fontSize: 20),
  /// );
  ///
  /// final copy = typography.copyWith(fontFamily: 'packages/forui/another-font');
  ///
  /// print(copy.fontFamily); // 'packages/forui/another-font'
  /// print(copy.sm.fontSize); // 10
  /// print(copy.md.fontSize); // 20
  /// ```
  @useResult
  FTypography copyWith({
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
  }) => FTypography(
    fontFamily: fontFamily,
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
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('fontFamily', fontFamily, defaultValue: defaultFontFamily))
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
      ..add(DiagnosticsProperty('xl8', xl8));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTypography &&
          runtimeType == other.runtimeType &&
          fontFamily == other.fontFamily &&
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
          xl8 == other.xl8;

  @override
  int get hashCode =>
      fontFamily.hashCode ^
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
      xl8.hashCode;
}
