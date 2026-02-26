// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'card_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCardContentStyleTransformations on FCardContentStyle {
  /// Returns a copy of this [FCardContentStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCardContentStyle.imageSpacing] - The spacing between the image and the title, subtitle, and child if any of them is provided.
  /// * [FCardContentStyle.subtitleSpacing] - The spacing between the title/subtitle and the child if an image is provided.
  /// * [FCardContentStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FCardContentStyle.subtitleTextStyle] - The subtitle's [TextStyle].
  /// * [FCardContentStyle.padding] - The padding.
  @useResult
  FCardContentStyle copyWith({
    double? imageSpacing,
    double? subtitleSpacing,
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? subtitleTextStyle,
    EdgeInsetsGeometryDelta? padding,
  }) => .new(
    imageSpacing: imageSpacing ?? this.imageSpacing,
    subtitleSpacing: subtitleSpacing ?? this.subtitleSpacing,
    titleTextStyle: titleTextStyle?.call(this.titleTextStyle) ?? this.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle?.call(this.subtitleTextStyle) ?? this.subtitleTextStyle,
    padding: padding?.call(this.padding) ?? this.padding,
  );

  /// Linearly interpolate between this and another [FCardContentStyle] using the given factor [t].
  @useResult
  FCardContentStyle lerp(FCardContentStyle other, double t) => .new(
    imageSpacing: lerpDouble(imageSpacing, other.imageSpacing, t) ?? imageSpacing,
    subtitleSpacing: lerpDouble(subtitleSpacing, other.subtitleSpacing, t) ?? subtitleSpacing,
    titleTextStyle: .lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    subtitleTextStyle: .lerp(subtitleTextStyle, other.subtitleTextStyle, t) ?? subtitleTextStyle,
    padding: .lerp(padding, other.padding, t) ?? padding,
  );
}

mixin _$FCardContentStyleFunctions on Diagnosticable implements FCardContentStyleDelta {
  /// Returns itself.
  @override
  FCardContentStyle call(Object _) => this as FCardContentStyle;

  double get imageSpacing;
  double get subtitleSpacing;
  TextStyle get titleTextStyle;
  TextStyle get subtitleTextStyle;
  EdgeInsetsGeometry get padding;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('imageSpacing', imageSpacing, level: .debug))
      ..add(DoubleProperty('subtitleSpacing', subtitleSpacing, level: .debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCardContentStyle &&
          runtimeType == other.runtimeType &&
          imageSpacing == other.imageSpacing &&
          subtitleSpacing == other.subtitleSpacing &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle &&
          padding == other.padding);

  @override
  int get hashCode =>
      imageSpacing.hashCode ^
      subtitleSpacing.hashCode ^
      titleTextStyle.hashCode ^
      subtitleTextStyle.hashCode ^
      padding.hashCode;
}

/// A delta that applies modifications to a [FCardContentStyle].
///
/// A [FCardContentStyle] is itself a [FCardContentStyleDelta].
abstract class FCardContentStyleDelta with Delta {
  /// Creates a partial modification of a [FCardContentStyle].
  ///
  /// ## Parameters
  /// * [FCardContentStyle.imageSpacing] - The spacing between the image and the title, subtitle, and child if any of them is provided.
  /// * [FCardContentStyle.subtitleSpacing] - The spacing between the title/subtitle and the child if an image is provided.
  /// * [FCardContentStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FCardContentStyle.subtitleTextStyle] - The subtitle's [TextStyle].
  /// * [FCardContentStyle.padding] - The padding.
  const factory FCardContentStyleDelta.delta({
    double? imageSpacing,
    double? subtitleSpacing,
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? subtitleTextStyle,
    EdgeInsetsGeometryDelta? padding,
  }) = _FCardContentStyleDelta;

  /// Creates a delta that returns the [FCardContentStyle] in the current context.
  const factory FCardContentStyleDelta.context() = _FCardContentStyleContext;

  @override
  FCardContentStyle call(covariant FCardContentStyle value);
}

class _FCardContentStyleDelta implements FCardContentStyleDelta {
  const _FCardContentStyleDelta({
    this.imageSpacing,
    this.subtitleSpacing,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.padding,
  });

  final double? imageSpacing;

  final double? subtitleSpacing;

  final TextStyleDelta? titleTextStyle;

  final TextStyleDelta? subtitleTextStyle;

  final EdgeInsetsGeometryDelta? padding;

  @override
  FCardContentStyle call(FCardContentStyle original) => FCardContentStyle(
    imageSpacing: imageSpacing ?? original.imageSpacing,
    subtitleSpacing: subtitleSpacing ?? original.subtitleSpacing,
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle?.call(original.subtitleTextStyle) ?? original.subtitleTextStyle,
    padding: padding?.call(original.padding) ?? original.padding,
  );
}

class _FCardContentStyleContext implements FCardContentStyleDelta {
  const _FCardContentStyleContext();

  @override
  FCardContentStyle call(FCardContentStyle original) => original;
}
