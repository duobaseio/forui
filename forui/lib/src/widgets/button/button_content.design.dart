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
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FButtonContentStyle.textStyle] - The [TextStyle].
  /// * [FButtonContentStyle.iconStyle] - The icon's style.
  /// * [FButtonContentStyle.circularProgressStyle] - The circular progress's style.
  /// * [FButtonContentStyle.padding] - The padding.
  /// * [FButtonContentStyle.spacing] - The spacing between prefix, child, and suffix.
  @useResult
  FButtonContentStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, FCircularProgressStyle, FCircularProgressStyleDelta>?
    circularProgressStyle,
    EdgeInsetsGeometryDelta? padding,
    double? spacing,
  }) => .new(
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    circularProgressStyle: circularProgressStyle?.call(this.circularProgressStyle) ?? this.circularProgressStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    spacing: spacing ?? this.spacing,
  );

  /// Linearly interpolate between this and another [FButtonContentStyle] using the given factor [t].
  @useResult
  FButtonContentStyle lerp(FButtonContentStyle other, double t) => .new(
    textStyle: .lerpTextStyle(textStyle, other.textStyle, t),
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    circularProgressStyle: .lerpWhere(
      circularProgressStyle,
      other.circularProgressStyle,
      t,
      (a, b, t) => a!.lerp(b!, t),
    ),
    padding: .lerp(padding, other.padding, t) ?? padding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
  );
}

mixin _$FButtonContentStyleFunctions on Diagnosticable implements FButtonContentStyleDelta {
  /// Returns itself.
  @override
  FButtonContentStyle call(Object _) => this as FButtonContentStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get textStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get iconStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, FCircularProgressStyle, FCircularProgressStyleDelta>
  get circularProgressStyle;
  EdgeInsetsGeometry get padding;
  double get spacing;
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
///
/// A [FButtonContentStyle] is itself a [FButtonContentStyleDelta].
abstract class FButtonContentStyleDelta with Delta {
  /// Creates a partial modification of a [FButtonContentStyle].
  ///
  /// ## Parameters
  /// * [FButtonContentStyle.textStyle] - The [TextStyle].
  /// * [FButtonContentStyle.iconStyle] - The icon's style.
  /// * [FButtonContentStyle.circularProgressStyle] - The circular progress's style.
  /// * [FButtonContentStyle.padding] - The padding.
  /// * [FButtonContentStyle.spacing] - The spacing between prefix, child, and suffix.
  const factory FButtonContentStyleDelta.delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, FCircularProgressStyle, FCircularProgressStyleDelta>?
    circularProgressStyle,
    EdgeInsetsGeometryDelta? padding,
    double? spacing,
  }) = _FButtonContentStyleDelta;

  /// Creates a delta that returns the [FButtonContentStyle] in the current context.
  const factory FButtonContentStyleDelta.context() = _FButtonContentStyleContext;

  @override
  FButtonContentStyle call(covariant FButtonContentStyle value);
}

class _FButtonContentStyleDelta implements FButtonContentStyleDelta {
  const _FButtonContentStyleDelta({
    this.textStyle,
    this.iconStyle,
    this.circularProgressStyle,
    this.padding,
    this.spacing,
  });

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle;

  final FVariantsDelta<
    FTappableVariantConstraint,
    FTappableVariant,
    FCircularProgressStyle,
    FCircularProgressStyleDelta
  >?
  circularProgressStyle;

  final EdgeInsetsGeometryDelta? padding;

  final double? spacing;

  @override
  FButtonContentStyle call(FButtonContentStyle original) => FButtonContentStyle(
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    circularProgressStyle:
        circularProgressStyle?.call(original.circularProgressStyle) ?? original.circularProgressStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    spacing: spacing ?? original.spacing,
  );
}

class _FButtonContentStyleContext implements FButtonContentStyleDelta {
  const _FButtonContentStyleContext();

  @override
  FButtonContentStyle call(FButtonContentStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FButtonIconContentStyleTransformations on FButtonIconContentStyle {
  /// Returns a copy of this [FButtonIconContentStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FButtonIconContentStyle.iconStyle] - The icon's style.
  /// * [FButtonIconContentStyle.padding] - The padding.
  @useResult
  FButtonIconContentStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    EdgeInsetsGeometryDelta? padding,
  }) => .new(
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    padding: padding?.call(this.padding) ?? this.padding,
  );

  /// Linearly interpolate between this and another [FButtonIconContentStyle] using the given factor [t].
  @useResult
  FButtonIconContentStyle lerp(FButtonIconContentStyle other, double t) => .new(
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
  );
}

mixin _$FButtonIconContentStyleFunctions on Diagnosticable implements FButtonIconContentStyleDelta {
  /// Returns itself.
  @override
  FButtonIconContentStyle call(Object _) => this as FButtonIconContentStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get iconStyle;
  EdgeInsetsGeometry get padding;
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
///
/// A [FButtonIconContentStyle] is itself a [FButtonIconContentStyleDelta].
abstract class FButtonIconContentStyleDelta with Delta {
  /// Creates a partial modification of a [FButtonIconContentStyle].
  ///
  /// ## Parameters
  /// * [FButtonIconContentStyle.iconStyle] - The icon's style.
  /// * [FButtonIconContentStyle.padding] - The padding.
  const factory FButtonIconContentStyleDelta.delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    EdgeInsetsGeometryDelta? padding,
  }) = _FButtonIconContentStyleDelta;

  /// Creates a delta that returns the [FButtonIconContentStyle] in the current context.
  const factory FButtonIconContentStyleDelta.context() = _FButtonIconContentStyleContext;

  @override
  FButtonIconContentStyle call(covariant FButtonIconContentStyle value);
}

class _FButtonIconContentStyleDelta implements FButtonIconContentStyleDelta {
  const _FButtonIconContentStyleDelta({this.iconStyle, this.padding});

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle;

  final EdgeInsetsGeometryDelta? padding;

  @override
  FButtonIconContentStyle call(FButtonIconContentStyle original) => FButtonIconContentStyle(
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    padding: padding?.call(original.padding) ?? original.padding,
  );
}

class _FButtonIconContentStyleContext implements FButtonIconContentStyleDelta {
  const _FButtonIconContentStyleContext();

  @override
  FButtonIconContentStyle call(FButtonIconContentStyle original) => original;
}
