import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'style.design.dart';

/// A set of miscellaneous tokens that are part of a [FThemeData].
class const FStyle._({
  /// The style for the form field.
  @override required final FFormFieldStyle formFieldStyle,

  /// The focused outline style.
  @override required final FFocusedOutlineStyle focusedOutlineStyle,

  /// The icon style.
  @override required final IconThemeData iconStyle,

  /// The size tokens.
  @override required final FSizes sizes,

  /// The tappable style.
  @override required final FTappableStyle tappableStyle,

  /// The border radius.
  @override final FBorderRadius borderRadius = const FBorderRadius(),

  /// The border width. Defaults to 1.
  @override final double borderWidth = 1,

  /// The page's padding. Defaults to `EdgeInsets.symmetric(vertical: 8, horizontal: 12)`.
  @override final EdgeInsets pagePadding = const .symmetric(vertical: 8, horizontal: 12),

  /// The shadow used for elevated widgets.
  @override
  final List<BoxShadow> shadow = const [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 1), blurRadius: 2)],

  final Map<Object, ThemeExtension<dynamic>> _extensions = const {},
}) with Diagnosticable, _$FStyleFunctions {
  /// Creates an [FStyle].
  ///
  /// **Note:**
  /// Unless you are creating a completely new style, modifying a predefined [FThemeData]'s style should be preferred.
  new({
    required FFormFieldStyle formFieldStyle,
    required FFocusedOutlineStyle focusedOutlineStyle,
    required IconThemeData iconStyle,
    required FSizes sizes,
    required FTappableStyle tappableStyle,
    FBorderRadius borderRadius = const FBorderRadius(),
    double borderWidth = 1,
    EdgeInsets pagePadding = const .symmetric(vertical: 8, horizontal: 12),
    List<BoxShadow> shadow = const [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 1), blurRadius: 2)],
    Iterable<ThemeExtension<dynamic>> extensions = const [],
  }) : this._(
         formFieldStyle: formFieldStyle,
         focusedOutlineStyle: focusedOutlineStyle,
         iconStyle: iconStyle,
         sizes: sizes,
         tappableStyle: tappableStyle,
         borderRadius: borderRadius,
         borderWidth: borderWidth,
         pagePadding: pagePadding,
         shadow: shadow,
         extensions: extensions.isEmpty ? const {} : {for (final extension in extensions) extension.type: extension},
       );

  /// Creates an [FStyle] that inherits its properties.
  factory inherit({required FColors colors, required FTypography typography, required bool touch}) {
    const borderRadius = FBorderRadius();
    return FStyle(
      formFieldStyle: .inherit(colors: colors, typography: typography, touch: touch),
      focusedOutlineStyle: FFocusedOutlineStyle(color: colors.primary, borderRadius: borderRadius.md),
      sizes: FSizes.inherit(touch: touch),
      iconStyle: IconThemeData(color: colors.foreground, size: typography.body.lg.fontSize),
      tappableStyle: FTappableStyle(),
    );
  }

  /// Obtains a particular [ThemeExtension].
  ///
  /// {@template forui.theme.FStyle.extension}
  /// ## Creating and passing a [ThemeExtension] to [FStyle]
  /// ```dart
  /// class BrandStyle extends ThemeExtension<BrandStyle> {
  ///   final double cardRadius;
  ///
  ///   const BrandStyle({required this.cardRadius});
  ///
  ///   @override
  ///   BrandStyle copyWith({double? cardRadius}) => BrandStyle(cardRadius: cardRadius ?? this.cardRadius);
  ///
  ///   @override
  ///   BrandStyle lerp(BrandStyle? other, double t) {
  ///     if (other is! BrandStyle) return this;
  ///     return BrandStyle(cardRadius: lerpDouble(cardRadius, other.cardRadius, t)!);
  ///   }
  /// }
  /// ```
  ///
  /// Passing it via constructor:
  /// ```dart
  /// final style = FStyle(
  ///   extensions: [BrandStyle(cardRadius: 12)],
  ///   ... // other fields omitted for brevity
  /// );
  /// ```
  ///
  /// Passing it via `copyWith`:
  /// ```dart
  /// style.copyWith(extensions: [BrandStyle(cardRadius: 12)]);
  /// ```
  ///
  /// ## Accessing the extension
  /// ```dart
  /// final brand = context.theme.style.extension<BrandStyle>();
  /// ```
  ///
  /// It is recommended to define a getter for your [ThemeExtension]:
  /// ```dart
  /// extension FStyleBrandStyle on FStyle {
  ///   BrandStyle get brand => extension<BrandStyle>();
  ///
  ///   // Alternatively
  ///   double get cardRadius => extension<BrandStyle>().cardRadius;
  /// }
  ///
  /// final brand = context.theme.style.brand;
  ///
  /// final cardRadius = context.theme.style.cardRadius;
  /// ```
  /// {@endtemplate}
  T extension<T extends Object>() => _extensions[T]! as T;

  /// All [ThemeExtension]s defined in this style.
  ///
  /// {@macro forui.theme.FStyle.extension}
  @override
  Set<ThemeExtension<dynamic>> get extensions => _extensions.values.toSet();
}

/// Provides function to access common visual properties from a [Decoration].
///
/// This is a best-effort conversion. Only [BoxDecoration] and [ShapeDecoration] are supported, all other [Decoration]s
/// will always return null.
extension Decorations on Decoration {
  /// The background color, or null if the decoration doesn't define one.
  Color? get color => switch (this) {
    BoxDecoration(:final color) || ShapeDecoration(:final color) => color,
    _ => null,
  };

  /// The [DecorationImage], or null if the decoration doesn't define one.
  DecorationImage? get image => switch (this) {
    BoxDecoration(:final image) || ShapeDecoration(:final image) => image,
    _ => null,
  };

  /// The shape border, or null if one can't be derived.
  ShapeBorder? get border => switch (this) {
    BoxDecoration(shape: .circle, :final border) => CircleBorder(side: border?.top ?? .none),
    BoxDecoration(:final borderRadius, :final border) => RoundedRectangleBorder(
      borderRadius: borderRadius ?? .zero,
      side: border?.top ?? .none,
    ),
    ShapeDecoration(:final shape) => shape,
    _ => null,
  };

  /// The [BorderRadiusGeometry], or null if the decoration doesn't define one.
  BorderRadiusGeometry? get borderRadius => switch (this) {
    BoxDecoration(:final borderRadius) => borderRadius,
    ShapeDecoration(:final shape) => switch (shape) {
      BeveledRectangleBorder(:final borderRadius) ||
      ContinuousRectangleBorder(:final borderRadius) ||
      RoundedRectangleBorder(:final borderRadius) ||
      RoundedSuperellipseBorder(:final borderRadius) => borderRadius,
      _ => null,
    },
    _ => null,
  };

  /// The list of shadows, or null if the decoration doesn't define one.
  List<BoxShadow>? get shadows => switch (this) {
    BoxDecoration(:final boxShadow) => boxShadow,
    ShapeDecoration(:final shadows) => shadows,
    _ => null,
  };

  /// The [Gradient], or null if the decoration doesn't define one.
  Gradient? get gradient => switch (this) {
    BoxDecoration(:final gradient) || ShapeDecoration(:final gradient) => gradient,
    _ => null,
  };

  /// The [BlendMode] applied to the color or gradient background, or null if the decoration doesn't define one.
  BlendMode? get backgroundBlendMode => switch (this) {
    BoxDecoration(:final backgroundBlendMode) => backgroundBlendMode,
    _ => null,
  };
}
