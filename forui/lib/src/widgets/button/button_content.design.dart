// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'button_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FButtonContentStyleTransformations on FButtonContentStyle {
  /// Returns a copy of this [FButtonContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FButtonContentStyle.textStyle] - The [TextStyle].
  /// * [FButtonContentStyle.iconStyle] - The icon's style.
  /// * [FButtonContentStyle.circularProgressStyle] - The circular progress's style.
  /// * [FButtonContentStyle.padding] - The padding.
  /// * [FButtonContentStyle.spacing] - The spacing between prefix, child, and suffix.
  @useResult
  FButtonContentStyle copyWith({
    FWidgetStateMap<TextStyle>? textStyle,
    FWidgetStateMap<IconThemeData>? iconStyle,
    FWidgetStateMap<FCircularProgressStyle>? circularProgressStyle,
    EdgeInsetsGeometry? padding,
    double? spacing,
  }) => .new(
    textStyle: textStyle ?? this.textStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    circularProgressStyle: circularProgressStyle ?? this.circularProgressStyle,
    padding: padding ?? this.padding,
    spacing: spacing ?? this.spacing,
  );

  /// Linearly interpolate between this and another [FButtonContentStyle] using the given factor [t].
  @useResult
  FButtonContentStyle lerp(FButtonContentStyle other, double t) => .new(
    textStyle: .lerpTextStyle(textStyle, other.textStyle, t),
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    circularProgressStyle: t < 0.5 ? circularProgressStyle : other.circularProgressStyle,
    padding: .lerp(padding, other.padding, t) ?? padding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
  );
}

mixin _$FButtonContentStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get textStyle;
  FWidgetStateMap<IconThemeData> get iconStyle;
  FWidgetStateMap<FCircularProgressStyle> get circularProgressStyle;
  EdgeInsetsGeometry get padding;
  double get spacing;

  /// Returns itself.
  ///
  /// Allows [FButtonContentStyle] to replace functions that accept and return a [FButtonContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FButtonContentStyle Function(FButtonContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FButtonContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FButtonContentStyle(...));
  /// ```
  @useResult
  FButtonContentStyle call(Object? _) => this as FButtonContentStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('circularProgressStyle', circularProgressStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonContentStyle &&
          runtimeType == other.runtimeType &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          circularProgressStyle == other.circularProgressStyle &&
          padding == other.padding &&
          spacing == other.spacing);

  @override
  int get hashCode =>
      textStyle.hashCode ^ iconStyle.hashCode ^ circularProgressStyle.hashCode ^ padding.hashCode ^ spacing.hashCode;
}

/// A delta that applies modifications to a [FButtonContentStyle].
sealed class FButtonContentStyleDelta with Delta<FButtonContentStyle> {
  /// Creates a complete replacement for a [FButtonContentStyle].
  const factory FButtonContentStyleDelta.replace(FButtonContentStyle replacement) = _FButtonContentStyleReplace;

  /// Creates a partial modification of a [FButtonContentStyle].
  const factory FButtonContentStyleDelta.merge({
    FWidgetStateMap<TextStyle>? textStyle,
    FWidgetStateMap<IconThemeData>? iconStyle,
    FWidgetStateMap<FCircularProgressStyle>? circularProgressStyle,
    EdgeInsetsGeometry? padding,
    double? spacing,
  }) = _FButtonContentStyleMerge;
}

class _FButtonContentStyleReplace implements FButtonContentStyleDelta {
  const _FButtonContentStyleReplace(this._replacement);

  final FButtonContentStyle _replacement;

  @override
  FButtonContentStyle call(FButtonContentStyle _) => _replacement;
}

class _FButtonContentStyleMerge implements FButtonContentStyleDelta {
  const _FButtonContentStyleMerge({
    this.textStyle,
    this.iconStyle,
    this.circularProgressStyle,
    this.padding,
    this.spacing,
  });

  final FWidgetStateMap<TextStyle>? textStyle;

  final FWidgetStateMap<IconThemeData>? iconStyle;

  final FWidgetStateMap<FCircularProgressStyle>? circularProgressStyle;

  final EdgeInsetsGeometry? padding;

  final double? spacing;

  @override
  FButtonContentStyle call(FButtonContentStyle original) => FButtonContentStyle(
    textStyle: textStyle ?? original.textStyle,
    iconStyle: iconStyle ?? original.iconStyle,
    circularProgressStyle: circularProgressStyle ?? original.circularProgressStyle,
    padding: padding ?? original.padding,
    spacing: spacing ?? original.spacing,
  );
}

/// Provides [copyWith] and [lerp] methods.
extension $FButtonIconContentStyleTransformations on FButtonIconContentStyle {
  /// Returns a copy of this [FButtonIconContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FButtonIconContentStyle.iconStyle] - The icon's style.
  /// * [FButtonIconContentStyle.padding] - The padding.
  @useResult
  FButtonIconContentStyle copyWith({FWidgetStateMap<IconThemeData>? iconStyle, EdgeInsetsGeometry? padding}) =>
      .new(iconStyle: iconStyle ?? this.iconStyle, padding: padding ?? this.padding);

  /// Linearly interpolate between this and another [FButtonIconContentStyle] using the given factor [t].
  @useResult
  FButtonIconContentStyle lerp(FButtonIconContentStyle other, double t) => .new(
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
  );
}

mixin _$FButtonIconContentStyleFunctions on Diagnosticable {
  FWidgetStateMap<IconThemeData> get iconStyle;
  EdgeInsetsGeometry get padding;

  /// Returns itself.
  ///
  /// Allows [FButtonIconContentStyle] to replace functions that accept and return a [FButtonIconContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FButtonIconContentStyle Function(FButtonIconContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FButtonIconContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FButtonIconContentStyle(...));
  /// ```
  @useResult
  FButtonIconContentStyle call(Object? _) => this as FButtonIconContentStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonIconContentStyle &&
          runtimeType == other.runtimeType &&
          iconStyle == other.iconStyle &&
          padding == other.padding);

  @override
  int get hashCode => iconStyle.hashCode ^ padding.hashCode;
}

/// A delta that applies modifications to a [FButtonIconContentStyle].
sealed class FButtonIconContentStyleDelta with Delta<FButtonIconContentStyle> {
  /// Creates a complete replacement for a [FButtonIconContentStyle].
  const factory FButtonIconContentStyleDelta.replace(FButtonIconContentStyle replacement) =
      _FButtonIconContentStyleReplace;

  /// Creates a partial modification of a [FButtonIconContentStyle].
  const factory FButtonIconContentStyleDelta.merge({
    FWidgetStateMap<IconThemeData>? iconStyle,
    EdgeInsetsGeometry? padding,
  }) = _FButtonIconContentStyleMerge;
}

class _FButtonIconContentStyleReplace implements FButtonIconContentStyleDelta {
  const _FButtonIconContentStyleReplace(this._replacement);

  final FButtonIconContentStyle _replacement;

  @override
  FButtonIconContentStyle call(FButtonIconContentStyle _) => _replacement;
}

class _FButtonIconContentStyleMerge implements FButtonIconContentStyleDelta {
  const _FButtonIconContentStyleMerge({this.iconStyle, this.padding});

  final FWidgetStateMap<IconThemeData>? iconStyle;

  final EdgeInsetsGeometry? padding;

  @override
  FButtonIconContentStyle call(FButtonIconContentStyle original) =>
      FButtonIconContentStyle(iconStyle: iconStyle ?? original.iconStyle, padding: padding ?? original.padding);
}
