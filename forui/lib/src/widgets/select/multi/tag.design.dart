// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tag.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FMultiSelectTagStyleTransformations on FMultiSelectTagStyle {
  /// Returns a copy of this [FMultiSelectTagStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FMultiSelectTagStyle.decoration] - The decoration.
  /// * [FMultiSelectTagStyle.padding] - The padding.
  /// * [FMultiSelectTagStyle.spacing] - The spacing between the label and the icon.
  /// * [FMultiSelectTagStyle.labelTextStyle] - The label's text style.
  /// * [FMultiSelectTagStyle.iconStyle] - The icon's style.
  /// * [FMultiSelectTagStyle.tappableStyle] - The tappable style.
  /// * [FMultiSelectTagStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FMultiSelectTagStyle copyWith({
    FWidgetStateMap<Decoration>? decoration,
    EdgeInsets? padding,
    double? spacing,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<IconThemeData>? iconStyle,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
  }) => .new(
    decoration: decoration ?? this.decoration,
    padding: padding ?? this.padding,
    spacing: spacing ?? this.spacing,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FMultiSelectTagStyle] using the given factor [t].
  @useResult
  FMultiSelectTagStyle lerp(FMultiSelectTagStyle other, double t) => .new(
    decoration: t < 0.5 ? decoration : other.decoration,
    padding: .lerp(padding, other.padding, t) ?? padding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FMultiSelectTagStyleFunctions on Diagnosticable {
  FWidgetStateMap<Decoration> get decoration;
  EdgeInsets get padding;
  double get spacing;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<IconThemeData> get iconStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FMultiSelectTagStyle] to replace functions that accept and return a [FMultiSelectTagStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FMultiSelectTagStyle Function(FMultiSelectTagStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FMultiSelectTagStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FMultiSelectTagStyle(...));
  /// ```
  @useResult
  FMultiSelectTagStyle call(Object? _) => this as FMultiSelectTagStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FMultiSelectTagStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding &&
          spacing == other.spacing &&
          labelTextStyle == other.labelTextStyle &&
          iconStyle == other.iconStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      spacing.hashCode ^
      labelTextStyle.hashCode ^
      iconStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}

/// A delta that applies modifications to a [FMultiSelectTagStyle].
sealed class FMultiSelectTagStyleDelta with Delta<FMultiSelectTagStyle> {
  /// Creates a complete replacement for a [FMultiSelectTagStyle].
  const factory FMultiSelectTagStyleDelta.replace(FMultiSelectTagStyle replacement) = _FMultiSelectTagStyleReplace;

  /// Creates a partial modification of a [FMultiSelectTagStyle].
  const factory FMultiSelectTagStyleDelta.merge({
    FWidgetStateMap<Decoration>? decoration,
    EdgeInsets? padding,
    double? spacing,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<IconThemeData>? iconStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) = _FMultiSelectTagStyleMerge;
}

class _FMultiSelectTagStyleReplace implements FMultiSelectTagStyleDelta {
  const _FMultiSelectTagStyleReplace(this._replacement);

  final FMultiSelectTagStyle _replacement;

  @override
  FMultiSelectTagStyle call(FMultiSelectTagStyle _) => _replacement;
}

class _FMultiSelectTagStyleMerge implements FMultiSelectTagStyleDelta {
  const _FMultiSelectTagStyleMerge({
    this.decoration,
    this.padding,
    this.spacing,
    this.labelTextStyle,
    this.iconStyle,
    this.tappableStyle,
    this.focusedOutlineStyle,
  });

  final FWidgetStateMap<Decoration>? decoration;

  final EdgeInsets? padding;

  final double? spacing;

  final FWidgetStateMap<TextStyle>? labelTextStyle;

  final FWidgetStateMap<IconThemeData>? iconStyle;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  @override
  FMultiSelectTagStyle call(FMultiSelectTagStyle original) => FMultiSelectTagStyle(
    decoration: decoration ?? original.decoration,
    padding: padding ?? original.padding,
    spacing: spacing ?? original.spacing,
    labelTextStyle: labelTextStyle ?? original.labelTextStyle,
    iconStyle: iconStyle ?? original.iconStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
  );
}
