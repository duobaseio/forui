// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'badge_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FBadgeContentStyleTransformations on FBadgeContentStyle {
  /// Returns a copy of this [FBadgeContentStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FBadgeContentStyle.labelTextStyle] - The label's [TextStyle].
  /// * [FBadgeContentStyle.padding] - The padding.
  @useResult
  FBadgeContentStyle copyWith({TextStyleDelta? labelTextStyle, EdgeInsetsGeometryDelta? padding}) => .new(
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    padding: padding?.call(this.padding) ?? this.padding,
  );

  /// Linearly interpolate between this and another [FBadgeContentStyle] using the given factor [t].
  @useResult
  FBadgeContentStyle lerp(FBadgeContentStyle other, double t) => .new(
    labelTextStyle: .lerp(labelTextStyle, other.labelTextStyle, t) ?? labelTextStyle,
    padding: .lerp(padding, other.padding, t) ?? padding,
  );
}

mixin _$FBadgeContentStyleFunctions on Diagnosticable implements FBadgeContentStyleDelta {
  /// Returns itself.
  @override
  FBadgeContentStyle call(Object _) => this as FBadgeContentStyle;

  TextStyle get labelTextStyle;
  EdgeInsetsGeometry get padding;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBadgeContentStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          padding == other.padding);

  @override
  int get hashCode => labelTextStyle.hashCode ^ padding.hashCode;
}

/// A delta that applies modifications to a [FBadgeContentStyle].
///
/// A [FBadgeContentStyle] is itself a [FBadgeContentStyleDelta].
abstract class FBadgeContentStyleDelta with Delta {
  /// Creates a partial modification of a [FBadgeContentStyle].
  ///
  /// ## Parameters
  /// * [FBadgeContentStyle.labelTextStyle] - The label's [TextStyle].
  /// * [FBadgeContentStyle.padding] - The padding.
  const factory FBadgeContentStyleDelta.delta({TextStyleDelta? labelTextStyle, EdgeInsetsGeometryDelta? padding}) =
      _FBadgeContentStyleDelta;

  /// Creates a delta that returns the [FBadgeContentStyle] in the current context.
  const factory FBadgeContentStyleDelta.context() = _FBadgeContentStyleContext;

  @override
  FBadgeContentStyle call(covariant FBadgeContentStyle value);
}

class _FBadgeContentStyleDelta implements FBadgeContentStyleDelta {
  const _FBadgeContentStyleDelta({this.labelTextStyle, this.padding});

  final TextStyleDelta? labelTextStyle;

  final EdgeInsetsGeometryDelta? padding;

  @override
  FBadgeContentStyle call(FBadgeContentStyle original) => FBadgeContentStyle(
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    padding: padding?.call(original.padding) ?? original.padding,
  );
}

class _FBadgeContentStyleContext implements FBadgeContentStyleDelta {
  const _FBadgeContentStyleContext();

  @override
  FBadgeContentStyle call(FBadgeContentStyle original) => original;
}
