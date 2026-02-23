import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'style.design.dart';

/// A set of miscellaneous properties that is part of a [FThemeData].
///
/// These properties are not used directly by Forui widgets. Instead, they are the defaults for the corresponding
/// properties of widget styles configured via `inherit(...)` constructors.
class FStyle with Diagnosticable, _$FStyleFunctions {
  /// The style for the form field.
  @override
  final FFormFieldStyle formFieldStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The icon style.
  @override
  final IconThemeData iconStyle;

  /// The border radius.
  @override
  final FBorderRadius borderRadius;

  /// The border width. Defaults to 1.
  @override
  final double borderWidth;

  /// The page's padding. Defaults to `EdgeInsets.symmetric(vertical: 8, horizontal: 12)`.
  @override
  final EdgeInsets pagePadding;

  /// The shadow used for elevated widgets.
  @override
  final List<BoxShadow> shadow;

  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// Creates an [FStyle].
  ///
  /// **Note:**
  /// Unless you are creating a completely new style, modifying [FThemes]' predefined styles should be preferred.
  const FStyle({
    required this.formFieldStyle,
    required this.focusedOutlineStyle,
    required this.iconStyle,
    required this.tappableStyle,
    this.borderRadius = const FBorderRadius(),
    this.borderWidth = 1,
    this.pagePadding = const .symmetric(vertical: 8, horizontal: 12),
    this.shadow = const [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 1), blurRadius: 2)],
  });

  /// Creates an [FStyle] that inherits its properties.
  FStyle.inherit({required FColors colors, required FTypography typography})
    : this(
        formFieldStyle: .inherit(colors: colors, typography: typography),
        focusedOutlineStyle: FFocusedOutlineStyle(color: colors.primary, borderRadius: const .all(.circular(8))),
        iconStyle: IconThemeData(color: colors.foreground, size: 20),
        tappableStyle: FTappableStyle(),
      );
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
