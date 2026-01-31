// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FItemStyleTransformations on FItemStyle {
  /// Returns a copy of this [FItemStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FItemStyle.backgroundColor] - The item's background color.
  /// * [FItemStyle.margin] - The margin around the item, including the [decoration].
  /// * [FItemStyle.decoration] - The item's decoration.
  /// * [FItemStyle.contentStyle] - The default item content's style.
  /// * [FItemStyle.rawItemContentStyle] - THe default raw item content's style.
  /// * [FItemStyle.tappableStyle] - The tappable style.
  /// * [FItemStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FItemStyle copyWith({
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

  /// Linearly interpolate between this and another [FItemStyle] using the given factor [t].
  @useResult
  FItemStyle lerp(FItemStyle other, double t) => .new(
    backgroundColor: .lerpWhere(backgroundColor, other.backgroundColor, t, Color.lerp),
    margin: .lerp(margin, other.margin, t) ?? margin,
    decoration: .lerpWhere(decoration, other.decoration, t, BoxDecoration.lerp),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    rawItemContentStyle: rawItemContentStyle.lerp(other.rawItemContentStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: t < 0.5 ? focusedOutlineStyle : other.focusedOutlineStyle,
  );
}

mixin _$FItemStyleFunctions on Diagnosticable {
  FWidgetStateMap<Color?> get backgroundColor;
  EdgeInsetsGeometry get margin;
  FWidgetStateMap<BoxDecoration?> get decoration;
  FItemContentStyle get contentStyle;
  FRawItemContentStyle get rawItemContentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle? get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FItemStyle] to replace functions that accept and return a [FItemStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FItemStyle Function(FItemStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FItemStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FItemStyle(...));
  /// ```
  @useResult
  FItemStyle call(Object? _) => this as FItemStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(DiagnosticsProperty('margin', margin, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug))
      ..add(DiagnosticsProperty('rawItemContentStyle', rawItemContentStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FItemStyle &&
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

/// A delta that applies modifications to a [FItemStyle].
sealed class FItemStyleDelta with Delta<FItemStyle> {
  /// Creates a complete replacement for a [FItemStyle].
  const factory FItemStyleDelta.replace(FItemStyle replacement) = _FItemStyleReplace;

  /// Creates a partial modification of a [FItemStyle].
  const factory FItemStyleDelta.merge({
    FWidgetStateMap<Color?>? backgroundColor,
    EdgeInsetsGeometry? margin,
    FWidgetStateMap<BoxDecoration?>? decoration,
    FItemContentStyleDelta? contentStyle,
    FRawItemContentStyleDelta? rawItemContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyle? Function()? focusedOutlineStyle,
  }) = _FItemStyleMerge;
}

class _FItemStyleReplace implements FItemStyleDelta {
  const _FItemStyleReplace(this._replacement);

  final FItemStyle _replacement;

  @override
  FItemStyle call(FItemStyle _) => _replacement;
}

class _FItemStyleMerge implements FItemStyleDelta {
  const _FItemStyleMerge({
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
  FItemStyle call(FItemStyle original) => FItemStyle(
    backgroundColor: backgroundColor ?? original.backgroundColor,
    margin: margin ?? original.margin,
    decoration: decoration ?? original.decoration,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
    rawItemContentStyle: rawItemContentStyle?.call(original.rawItemContentStyle) ?? original.rawItemContentStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle == null ? original.focusedOutlineStyle : focusedOutlineStyle!(),
  );
}
