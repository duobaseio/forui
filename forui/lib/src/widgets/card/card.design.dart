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
  /// * [FCardStyle.contentStyle] - The card content's style.
  @useResult
  FCardStyle copyWith({DecorationDelta? decoration, FCardContentStyleDelta? contentStyle}) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
  );

  /// Linearly interpolate between this and another [FCardStyle] using the given factor [t].
  @useResult
  FCardStyle lerp(FCardStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    contentStyle: contentStyle.lerp(other.contentStyle, t),
  );
}

mixin _$FCardStyleFunctions on Diagnosticable implements FCardStyleDelta {
  /// Returns itself.
  @override
  FCardStyle call(Object _) => this as FCardStyle;

  Decoration get decoration;
  FCardContentStyle get contentStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCardStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          contentStyle == other.contentStyle);

  @override
  int get hashCode => decoration.hashCode ^ contentStyle.hashCode;
}

/// A delta that applies modifications to a [FCardStyle].
///
/// A [FCardStyle] is itself a [FCardStyleDelta].
abstract class FCardStyleDelta with Delta {
  /// Creates a partial modification of a [FCardStyle].
  ///
  /// ## Parameters
  /// * [FCardStyle.decoration] - The decoration.
  /// * [FCardStyle.contentStyle] - The card content's style.
  const factory FCardStyleDelta.delta({DecorationDelta? decoration, FCardContentStyleDelta? contentStyle}) =
      _FCardStyleDelta;

  /// Creates a delta that returns the [FCardStyle] in the current context.
  const factory FCardStyleDelta.context() = _FCardStyleContext;

  @override
  FCardStyle call(covariant FCardStyle value);
}

class _FCardStyleDelta implements FCardStyleDelta {
  const _FCardStyleDelta({this.decoration, this.contentStyle});

  final DecorationDelta? decoration;

  final FCardContentStyleDelta? contentStyle;

  @override
  FCardStyle call(FCardStyle original) => FCardStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
  );
}

class _FCardStyleContext implements FCardStyleDelta {
  const _FCardStyleContext();

  @override
  FCardStyle call(FCardStyle original) => original;
}
