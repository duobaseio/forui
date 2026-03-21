// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'dialog_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FDialogContentStyleTransformations on FDialogContentStyle {
  /// Returns a copy of this [FDialogContentStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FDialogContentStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FDialogContentStyle.bodyTextStyle] - The body's [TextStyle].
  /// * [FDialogContentStyle.padding] - The padding surrounding the content.
  /// * [FDialogContentStyle.titleSpacing] - The spacing below the title.
  /// * [FDialogContentStyle.bodySpacing] - The spacing below the body.
  /// * [FDialogContentStyle.contentSpacing] - The spacing between the content (title/body) and the actions.
  /// * [FDialogContentStyle.actionSpacing] - The space between actions.
  @useResult
  FDialogContentStyle copyWith({
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? bodyTextStyle,
    EdgeInsetsGeometryDelta? padding,
    double? titleSpacing,
    double? bodySpacing,
    double? contentSpacing,
    double? actionSpacing,
  }) => .new(
    titleTextStyle: titleTextStyle?.call(this.titleTextStyle) ?? this.titleTextStyle,
    bodyTextStyle: bodyTextStyle?.call(this.bodyTextStyle) ?? this.bodyTextStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    titleSpacing: titleSpacing ?? this.titleSpacing,
    bodySpacing: bodySpacing ?? this.bodySpacing,
    contentSpacing: contentSpacing ?? this.contentSpacing,
    actionSpacing: actionSpacing ?? this.actionSpacing,
  );

  /// Linearly interpolate between this and another [FDialogContentStyle] using the given factor [t].
  @useResult
  FDialogContentStyle lerp(FDialogContentStyle other, double t) => .new(
    titleTextStyle: .lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    bodyTextStyle: .lerp(bodyTextStyle, other.bodyTextStyle, t) ?? bodyTextStyle,
    padding: .lerp(padding, other.padding, t) ?? padding,
    titleSpacing: lerpDouble(titleSpacing, other.titleSpacing, t) ?? titleSpacing,
    bodySpacing: lerpDouble(bodySpacing, other.bodySpacing, t) ?? bodySpacing,
    contentSpacing: lerpDouble(contentSpacing, other.contentSpacing, t) ?? contentSpacing,
    actionSpacing: lerpDouble(actionSpacing, other.actionSpacing, t) ?? actionSpacing,
  );
}

mixin _$FDialogContentStyleFunctions on Diagnosticable implements FDialogContentStyleDelta {
  /// Returns itself.
  @override
  FDialogContentStyle call(Object _) => this as FDialogContentStyle;

  TextStyle get titleTextStyle;
  TextStyle get bodyTextStyle;
  EdgeInsetsGeometry get padding;
  double get titleSpacing;
  double get bodySpacing;
  double get contentSpacing;
  double get actionSpacing;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('bodyTextStyle', bodyTextStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('titleSpacing', titleSpacing, level: .debug))
      ..add(DoubleProperty('bodySpacing', bodySpacing, level: .debug))
      ..add(DoubleProperty('contentSpacing', contentSpacing, level: .debug))
      ..add(DoubleProperty('actionSpacing', actionSpacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogContentStyle &&
          runtimeType == other.runtimeType &&
          titleTextStyle == other.titleTextStyle &&
          bodyTextStyle == other.bodyTextStyle &&
          padding == other.padding &&
          titleSpacing == other.titleSpacing &&
          bodySpacing == other.bodySpacing &&
          contentSpacing == other.contentSpacing &&
          actionSpacing == other.actionSpacing);

  @override
  int get hashCode =>
      titleTextStyle.hashCode ^
      bodyTextStyle.hashCode ^
      padding.hashCode ^
      titleSpacing.hashCode ^
      bodySpacing.hashCode ^
      contentSpacing.hashCode ^
      actionSpacing.hashCode;
}

/// A delta that applies modifications to a [FDialogContentStyle].
///
/// A [FDialogContentStyle] is itself a [FDialogContentStyleDelta].
abstract class FDialogContentStyleDelta with Delta {
  /// Creates a partial modification of a [FDialogContentStyle].
  ///
  /// ## Parameters
  /// * [FDialogContentStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FDialogContentStyle.bodyTextStyle] - The body's [TextStyle].
  /// * [FDialogContentStyle.padding] - The padding surrounding the content.
  /// * [FDialogContentStyle.titleSpacing] - The spacing below the title.
  /// * [FDialogContentStyle.bodySpacing] - The spacing below the body.
  /// * [FDialogContentStyle.contentSpacing] - The spacing between the content (title/body) and the actions.
  /// * [FDialogContentStyle.actionSpacing] - The space between actions.
  const factory FDialogContentStyleDelta.delta({
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? bodyTextStyle,
    EdgeInsetsGeometryDelta? padding,
    double? titleSpacing,
    double? bodySpacing,
    double? contentSpacing,
    double? actionSpacing,
  }) = _FDialogContentStyleDelta;

  /// Creates a delta that returns the [FDialogContentStyle] in the current context.
  const factory FDialogContentStyleDelta.context() = _FDialogContentStyleContext;

  @override
  FDialogContentStyle call(covariant FDialogContentStyle value);
}

class _FDialogContentStyleDelta implements FDialogContentStyleDelta {
  const _FDialogContentStyleDelta({
    this.titleTextStyle,
    this.bodyTextStyle,
    this.padding,
    this.titleSpacing,
    this.bodySpacing,
    this.contentSpacing,
    this.actionSpacing,
  });

  final TextStyleDelta? titleTextStyle;

  final TextStyleDelta? bodyTextStyle;

  final EdgeInsetsGeometryDelta? padding;

  final double? titleSpacing;

  final double? bodySpacing;

  final double? contentSpacing;

  final double? actionSpacing;

  @override
  FDialogContentStyle call(FDialogContentStyle original) => FDialogContentStyle(
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    bodyTextStyle: bodyTextStyle?.call(original.bodyTextStyle) ?? original.bodyTextStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    titleSpacing: titleSpacing ?? original.titleSpacing,
    bodySpacing: bodySpacing ?? original.bodySpacing,
    contentSpacing: contentSpacing ?? original.contentSpacing,
    actionSpacing: actionSpacing ?? original.actionSpacing,
  );
}

class _FDialogContentStyleContext implements FDialogContentStyleDelta {
  const _FDialogContentStyleContext();

  @override
  FDialogContentStyle call(FDialogContentStyle original) => original;
}
