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
  /// * [FDialogContentStyle.titlePadding] - The padding surrounding the title.
  /// * [FDialogContentStyle.bodyPadding] - The padding surrounding the body.
  /// * [FDialogContentStyle.imageSpacing] - The spacing between the image and the title/body.
  /// * [FDialogContentStyle.titleSpacing] - The spacing between the title and the body.
  /// * [FDialogContentStyle.contentSpacing] - The spacing between the content (title/body) and the actions.
  /// * [FDialogContentStyle.actionSpacing] - The space between actions.
  /// * [FDialogContentStyle.expandActions] - Whether each action expands to fill the available width.
  @useResult
  FDialogContentStyle copyWith({
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? bodyTextStyle,
    EdgeInsetsGeometryDelta? padding,
    EdgeInsetsGeometryDelta? titlePadding,
    EdgeInsetsGeometryDelta? bodyPadding,
    double? imageSpacing,
    double? titleSpacing,
    double? contentSpacing,
    double? actionSpacing,
    bool? expandActions,
  }) => .new(
    titleTextStyle: titleTextStyle?.call(this.titleTextStyle) ?? this.titleTextStyle,
    bodyTextStyle: bodyTextStyle?.call(this.bodyTextStyle) ?? this.bodyTextStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    titlePadding: titlePadding?.call(this.titlePadding) ?? this.titlePadding,
    bodyPadding: bodyPadding?.call(this.bodyPadding) ?? this.bodyPadding,
    imageSpacing: imageSpacing ?? this.imageSpacing,
    titleSpacing: titleSpacing ?? this.titleSpacing,
    contentSpacing: contentSpacing ?? this.contentSpacing,
    actionSpacing: actionSpacing ?? this.actionSpacing,
    expandActions: expandActions ?? this.expandActions,
  );

  /// Linearly interpolate between this and another [FDialogContentStyle] using the given factor [t].
  @useResult
  FDialogContentStyle lerp(FDialogContentStyle other, double t) => .new(
    titleTextStyle: .lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    bodyTextStyle: .lerp(bodyTextStyle, other.bodyTextStyle, t) ?? bodyTextStyle,
    padding: .lerp(padding, other.padding, t) ?? padding,
    titlePadding: .lerp(titlePadding, other.titlePadding, t) ?? titlePadding,
    bodyPadding: .lerp(bodyPadding, other.bodyPadding, t) ?? bodyPadding,
    imageSpacing: lerpDouble(imageSpacing, other.imageSpacing, t) ?? imageSpacing,
    titleSpacing: lerpDouble(titleSpacing, other.titleSpacing, t) ?? titleSpacing,
    contentSpacing: lerpDouble(contentSpacing, other.contentSpacing, t) ?? contentSpacing,
    actionSpacing: lerpDouble(actionSpacing, other.actionSpacing, t) ?? actionSpacing,
    expandActions: t < 0.5 ? expandActions : other.expandActions,
  );
}

mixin _$FDialogContentStyleFunctions on Diagnosticable implements FDialogContentStyleDelta {
  /// Returns itself.
  @override
  FDialogContentStyle call(Object _) => this as FDialogContentStyle;

  TextStyle get titleTextStyle;
  TextStyle get bodyTextStyle;
  EdgeInsetsGeometry get padding;
  EdgeInsetsGeometry get titlePadding;
  EdgeInsetsGeometry get bodyPadding;
  double get imageSpacing;
  double get titleSpacing;
  double get contentSpacing;
  double get actionSpacing;
  bool get expandActions;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('bodyTextStyle', bodyTextStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('titlePadding', titlePadding, level: .debug))
      ..add(DiagnosticsProperty('bodyPadding', bodyPadding, level: .debug))
      ..add(DoubleProperty('imageSpacing', imageSpacing, level: .debug))
      ..add(DoubleProperty('titleSpacing', titleSpacing, level: .debug))
      ..add(DoubleProperty('contentSpacing', contentSpacing, level: .debug))
      ..add(DoubleProperty('actionSpacing', actionSpacing, level: .debug))
      ..add(FlagProperty('expandActions', value: expandActions, ifTrue: 'expandActions', level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogContentStyle &&
          runtimeType == other.runtimeType &&
          titleTextStyle == other.titleTextStyle &&
          bodyTextStyle == other.bodyTextStyle &&
          padding == other.padding &&
          titlePadding == other.titlePadding &&
          bodyPadding == other.bodyPadding &&
          imageSpacing == other.imageSpacing &&
          titleSpacing == other.titleSpacing &&
          contentSpacing == other.contentSpacing &&
          actionSpacing == other.actionSpacing &&
          expandActions == other.expandActions);

  @override
  int get hashCode =>
      titleTextStyle.hashCode ^
      bodyTextStyle.hashCode ^
      padding.hashCode ^
      titlePadding.hashCode ^
      bodyPadding.hashCode ^
      imageSpacing.hashCode ^
      titleSpacing.hashCode ^
      contentSpacing.hashCode ^
      actionSpacing.hashCode ^
      expandActions.hashCode;
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
  /// * [FDialogContentStyle.titlePadding] - The padding surrounding the title.
  /// * [FDialogContentStyle.bodyPadding] - The padding surrounding the body.
  /// * [FDialogContentStyle.imageSpacing] - The spacing between the image and the title/body.
  /// * [FDialogContentStyle.titleSpacing] - The spacing between the title and the body.
  /// * [FDialogContentStyle.contentSpacing] - The spacing between the content (title/body) and the actions.
  /// * [FDialogContentStyle.actionSpacing] - The space between actions.
  /// * [FDialogContentStyle.expandActions] - Whether each action expands to fill the available width.
  const factory FDialogContentStyleDelta.delta({
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? bodyTextStyle,
    EdgeInsetsGeometryDelta? padding,
    EdgeInsetsGeometryDelta? titlePadding,
    EdgeInsetsGeometryDelta? bodyPadding,
    double? imageSpacing,
    double? titleSpacing,
    double? contentSpacing,
    double? actionSpacing,
    bool? expandActions,
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
    this.titlePadding,
    this.bodyPadding,
    this.imageSpacing,
    this.titleSpacing,
    this.contentSpacing,
    this.actionSpacing,
    this.expandActions,
  });

  final TextStyleDelta? titleTextStyle;

  final TextStyleDelta? bodyTextStyle;

  final EdgeInsetsGeometryDelta? padding;

  final EdgeInsetsGeometryDelta? titlePadding;

  final EdgeInsetsGeometryDelta? bodyPadding;

  final double? imageSpacing;

  final double? titleSpacing;

  final double? contentSpacing;

  final double? actionSpacing;

  final bool? expandActions;

  @override
  FDialogContentStyle call(FDialogContentStyle original) => FDialogContentStyle(
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    bodyTextStyle: bodyTextStyle?.call(original.bodyTextStyle) ?? original.bodyTextStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    titlePadding: titlePadding?.call(original.titlePadding) ?? original.titlePadding,
    bodyPadding: bodyPadding?.call(original.bodyPadding) ?? original.bodyPadding,
    imageSpacing: imageSpacing ?? original.imageSpacing,
    titleSpacing: titleSpacing ?? original.titleSpacing,
    contentSpacing: contentSpacing ?? original.contentSpacing,
    actionSpacing: actionSpacing ?? original.actionSpacing,
    expandActions: expandActions ?? original.expandActions,
  );
}

class _FDialogContentStyleContext implements FDialogContentStyleDelta {
  const _FDialogContentStyleContext();

  @override
  FDialogContentStyle call(FDialogContentStyle original) => original;
}
