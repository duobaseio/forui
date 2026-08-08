// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'card.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCardStyleTransformations on FCardStyle {
  /// Returns a copy of this [FCardStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCardStyle.decoration] - The decoration.
  /// * [FCardStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FCardStyle.subtitleTextStyle] - The subtitle's [TextStyle].
  /// * [FCardStyle.padding] - The padding.
  @useResult
  FCardStyle copyWith({
    DecorationDelta? decoration,
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? subtitleTextStyle,
    EdgeInsetsGeometryDelta? padding,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    titleTextStyle: titleTextStyle?.call(this.titleTextStyle) ?? this.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle?.call(this.subtitleTextStyle) ?? this.subtitleTextStyle,
    padding: padding?.call(this.padding) ?? this.padding,
  );

  /// Linearly interpolate between this and another [FCardStyle] using the given factor [t].
  @useResult
  FCardStyle lerp(FCardStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    titleTextStyle: .lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    subtitleTextStyle: .lerp(subtitleTextStyle, other.subtitleTextStyle, t) ?? subtitleTextStyle,
    padding: .lerp(padding, other.padding, t) ?? padding,
  );
}

mixin _$FCardStyleFunctions on Diagnosticable implements FCardStyleDelta {
  /// Returns itself.
  @override
  FCardStyle call(Object _) => this as FCardStyle;

  Decoration get decoration;
  TextStyle get titleTextStyle;
  TextStyle get subtitleTextStyle;
  EdgeInsetsGeometry get padding;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCardStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle &&
          padding == other.padding);

  @override
  int get hashCode => decoration.hashCode ^ titleTextStyle.hashCode ^ subtitleTextStyle.hashCode ^ padding.hashCode;
}

/// A delta that applies modifications to a [FCardStyle].
///
/// A [FCardStyle] is itself a [FCardStyleDelta].
abstract class FCardStyleDelta with Delta {
  /// Creates a partial modification of a [FCardStyle].
  ///
  /// ## Parameters
  /// * [FCardStyle.decoration] - The decoration.
  /// * [FCardStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FCardStyle.subtitleTextStyle] - The subtitle's [TextStyle].
  /// * [FCardStyle.padding] - The padding.
  const factory FCardStyleDelta.delta({
    DecorationDelta? decoration,
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? subtitleTextStyle,
    EdgeInsetsGeometryDelta? padding,
  }) = _FCardStyleDelta;

  /// Creates a delta that returns the [FCardStyle] in the current context.
  const factory FCardStyleDelta.context() = _FCardStyleContext;

  @override
  FCardStyle call(covariant FCardStyle value);
}

class _FCardStyleDelta implements FCardStyleDelta {
  const _FCardStyleDelta({this.decoration, this.titleTextStyle, this.subtitleTextStyle, this.padding});

  final DecorationDelta? decoration;

  final TextStyleDelta? titleTextStyle;

  final TextStyleDelta? subtitleTextStyle;

  final EdgeInsetsGeometryDelta? padding;

  @override
  FCardStyle call(FCardStyle original) => FCardStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle?.call(original.subtitleTextStyle) ?? original.subtitleTextStyle,
    padding: padding?.call(original.padding) ?? original.padding,
  );
}

class _FCardStyleContext implements FCardStyleDelta {
  const _FCardStyleContext();

  @override
  FCardStyle call(FCardStyle original) => original;
}
