// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tile.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTileStyleTransformations on FTileStyle {
  /// Returns a copy of this [FTileStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FTileStyle.backgroundColor] - The item's background color.
  /// * [FTileStyle.margin] - The margin around the item, including the [decoration].
  /// * [FTileStyle.decoration] - The item's decoration.
  /// * [FTileStyle.contentStyle] - The default item content's style.
  /// * [FTileStyle.rawItemContentStyle] - THe default raw item content's style.
  /// * [FTileStyle.tappableStyle] - The tappable style.
  /// * [FTileStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FTileStyle copyWith({
    FWidgetStateMap<Color?>? backgroundColor,
    EdgeInsetsGeometry? margin,
    FWidgetStateMap<BoxDecoration?>? decoration,
    FItemContentStyle Function(FItemContentStyle style)? contentStyle,
    FRawItemContentStyle Function(FRawItemContentStyle style)? rawItemContentStyle,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) => .new(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    margin: margin ?? this.margin,
    decoration: decoration ?? this.decoration,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
    rawItemContentStyle: rawItemContentStyle != null
        ? rawItemContentStyle(this.rawItemContentStyle)
        : this.rawItemContentStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FTileStyle] using the given factor [t].
  @useResult
  FTileStyle lerp(FTileStyle other, double t) => .new(
    backgroundColor: .lerpWhere(backgroundColor, other.backgroundColor, t, Color.lerp),
    margin: .lerp(margin, other.margin, t) ?? margin,
    decoration: .lerpWhere(decoration, other.decoration, t, BoxDecoration.lerp),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    rawItemContentStyle: rawItemContentStyle.lerp(other.rawItemContentStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: t < 0.5 ? focusedOutlineStyle : other.focusedOutlineStyle,
  );
}

mixin _$FTileStyleFunctions on Diagnosticable {
  FWidgetStateMap<Color?> get backgroundColor;
  EdgeInsetsGeometry get margin;
  FWidgetStateMap<BoxDecoration?> get decoration;
  FItemContentStyle get contentStyle;
  FRawItemContentStyle get rawItemContentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle? get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FTileStyle] to replace functions that accept and return a [FTileStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FTileStyle Function(FTileStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FTileStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FTileStyle(...));
  /// ```
  @useResult
  FTileStyle call(Object? _) => this as FTileStyle;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTileStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          margin == other.margin &&
          decoration == other.decoration &&
          contentStyle == other.contentStyle &&
          rawItemContentStyle == other.rawItemContentStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      margin.hashCode ^
      decoration.hashCode ^
      contentStyle.hashCode ^
      rawItemContentStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}

/// A delta that applies modifications to a [FTileStyle].
sealed class FTileStyleDelta with Delta<FTileStyle> {
  /// Creates a complete replacement for a [FTileStyle].
  const factory FTileStyleDelta.replace(FTileStyle replacement) = _FTileStyleReplace;

  /// Creates a partial modification of a [FTileStyle].
  const factory FTileStyleDelta.merge({
    FWidgetStateMap<Color?>? backgroundColor,
    EdgeInsetsGeometry? margin,
    FWidgetStateMap<BoxDecoration?>? decoration,
    FItemContentStyleDelta? contentStyle,
    FRawItemContentStyleDelta? rawItemContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyle? Function()? focusedOutlineStyle,
  }) = _FTileStyleMerge;
}

class _FTileStyleReplace implements FTileStyleDelta {
  const _FTileStyleReplace(this._replacement);

  final FTileStyle _replacement;

  @override
  FTileStyle call(FTileStyle _) => _replacement;
}

class _FTileStyleMerge implements FTileStyleDelta {
  const _FTileStyleMerge({
    this.backgroundColor,
    this.margin,
    this.decoration,
    this.contentStyle,
    this.rawItemContentStyle,
    this.tappableStyle,
    this.focusedOutlineStyle,
  });

  final FWidgetStateMap<Color?>? backgroundColor;

  final EdgeInsetsGeometry? margin;

  final FWidgetStateMap<BoxDecoration?>? decoration;

  final FItemContentStyleDelta? contentStyle;

  final FRawItemContentStyleDelta? rawItemContentStyle;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyle? Function()? focusedOutlineStyle;

  @override
  FTileStyle call(FTileStyle original) => FTileStyle(
    backgroundColor: backgroundColor ?? original.backgroundColor,
    margin: margin ?? original.margin,
    decoration: decoration ?? original.decoration,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
    rawItemContentStyle: rawItemContentStyle?.call(original.rawItemContentStyle) ?? original.rawItemContentStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle == null ? original.focusedOutlineStyle : focusedOutlineStyle!(),
  );
}
