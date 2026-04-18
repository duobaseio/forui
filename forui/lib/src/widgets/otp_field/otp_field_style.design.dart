// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'otp_field_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FOtpFieldItemVariant], which represents individual variants.
extension type const FOtpFieldItemVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FOtpFieldItemVariantConstraint] that negates [variant].
  factory FOtpFieldItemVariantConstraint.not(FOtpFieldItemVariant variant) =>
      FOtpFieldItemVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FOtpFieldItemVariant.disabled;

  /// The semantic variant when this widget is in an error state.
  static const error = FOtpFieldItemVariant.error;

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FOtpFieldItemVariant.focused;

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FOtpFieldItemVariant.hovered;

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FOtpFieldItemVariant.pressed;

  /// The variant for the first item in a group (e.g. the first item or the first item after a divider).
  static const start = FOtpFieldItemVariant.start;

  /// The variant for the last item in a group (e.g. the last item or the last item before a divider).
  static const end = FOtpFieldItemVariant.end;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FOtpFieldItemVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FOtpFieldItemVariant._(Desktop());

  /// The Android platform variant.
  static const android = FOtpFieldItemVariant.android;

  /// The iOS platform variant.
  static const iOS = FOtpFieldItemVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FOtpFieldItemVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FOtpFieldItemVariant.windows;

  /// The macOS platform variant.
  static const macOS = FOtpFieldItemVariant.macOS;

  /// The Linux platform variant.
  static const linux = FOtpFieldItemVariant.linux;

  /// The web platform variant.
  static const web = FOtpFieldItemVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FOtpFieldItemVariantConstraint and(FOtpFieldItemVariantConstraint other) =>
      FOtpFieldItemVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FOtpFieldItemVariantConstraint], which represents combinations of variants.
extension type const FOtpFieldItemVariant._(FVariant _) implements FOtpFieldItemVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FOtpFieldItemVariant._(.new(2, 'disabled'));

  /// The semantic variant when this widget is in an error state.
  static const error = FOtpFieldItemVariant._(.new(2, 'error'));

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FOtpFieldItemVariant._(.new(1, 'focused'));

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FOtpFieldItemVariant._(.new(1, 'hovered'));

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FOtpFieldItemVariant._(.new(1, 'pressed'));

  /// The variant for the first item in a group (e.g. the first item or the first item after a divider).
  static const start = FOtpFieldItemVariant._(.new(1, 'start'));

  /// The variant for the last item in a group (e.g. the last item or the last item before a divider).
  static const end = FOtpFieldItemVariant._(.new(1, 'end'));

  /// The Android platform variant.
  static const android = FOtpFieldItemVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FOtpFieldItemVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FOtpFieldItemVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FOtpFieldItemVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FOtpFieldItemVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FOtpFieldItemVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FOtpFieldItemVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FOtpFieldStyleTransformations on FOtpFieldStyle {
  /// Returns a copy of this [FOtpFieldStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FOtpFieldStyle.keyboardAppearance] - The appearance of the keyboard.
  /// * [FOtpFieldStyle.cursorColor] - The color of the cursor.
  /// * [FOtpFieldStyle.cursorWidth] - The width of the cursor.
  /// * [FOtpFieldStyle.cursorOpacityAnimates] - Whether the cursor opacity animates.
  /// * [FOtpFieldStyle.itemSize] - The item size.
  /// * [FOtpFieldStyle.itemStyles] - The item styles per variant.
  /// * [FOtpFieldStyle.dividerPadding] - The divider's padding.
  /// * [FOtpFieldStyle.dividerSize] - The divider's size.
  /// * [FOtpFieldStyle.dividerColor] - The divider's color.
  /// * [FOtpFieldStyle.labelPadding] - The label's padding.
  /// * [FOtpFieldStyle.descriptionPadding] - The description's padding.
  /// * [FOtpFieldStyle.errorPadding] - The error's padding.
  /// * [FOtpFieldStyle.childPadding] - The child's padding.
  /// * [FOtpFieldStyle.labelMotion] - The motion properties for error animations.
  /// * [FOtpFieldStyle.labelTextStyle] - The label's text style.
  /// * [FOtpFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FOtpFieldStyle.errorTextStyle] - The error's text style.
  @useResult
  FOtpFieldStyle copyWith({
    Brightness? keyboardAppearance,
    Color? cursorColor,
    double? cursorWidth,
    bool? Function()? cursorOpacityAnimates,
    Size? itemSize,
    FVariantsDelta<FOtpFieldItemVariantConstraint, FOtpFieldItemVariant, FOtpFieldItemStyle, FOtpFieldItemStyleDelta>?
    itemStyles,
    EdgeInsetsGeometryDelta? dividerPadding,
    Size? dividerSize,
    FVariantsValueDelta<FOtpFieldItemVariantConstraint, FOtpFieldItemVariant, Color, Delta>? dividerColor,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
    cursorColor: cursorColor ?? this.cursorColor,
    cursorWidth: cursorWidth ?? this.cursorWidth,
    cursorOpacityAnimates: cursorOpacityAnimates == null ? this.cursorOpacityAnimates : cursorOpacityAnimates(),
    itemSize: itemSize ?? this.itemSize,
    itemStyles: FOtpFieldItemStyles(itemStyles?.call(this.itemStyles) ?? this.itemStyles),
    dividerPadding: dividerPadding?.call(this.dividerPadding) ?? this.dividerPadding,
    dividerSize: dividerSize ?? this.dividerSize,
    dividerColor: dividerColor?.call(this.dividerColor) ?? this.dividerColor,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    descriptionPadding: descriptionPadding?.call(this.descriptionPadding) ?? this.descriptionPadding,
    errorPadding: errorPadding?.call(this.errorPadding) ?? this.errorPadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    labelMotion: labelMotion?.call(this.labelMotion) ?? this.labelMotion,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FOtpFieldStyle] using the given factor [t].
  @useResult
  FOtpFieldStyle lerp(FOtpFieldStyle other, double t) => .new(
    keyboardAppearance: t < 0.5 ? keyboardAppearance : other.keyboardAppearance,
    cursorColor: FColors.lerpColor(cursorColor, other.cursorColor, t) ?? cursorColor,
    cursorWidth: lerpDouble(cursorWidth, other.cursorWidth, t) ?? cursorWidth,
    cursorOpacityAnimates: t < 0.5 ? cursorOpacityAnimates : other.cursorOpacityAnimates,
    itemSize: t < 0.5 ? itemSize : other.itemSize,
    itemStyles: FOtpFieldItemStyles(.lerpWhere(itemStyles, other.itemStyles, t, (a, b, t) => a!.lerp(b!, t))),
    dividerPadding: .lerp(dividerPadding, other.dividerPadding, t) ?? dividerPadding,
    dividerSize: t < 0.5 ? dividerSize : other.dividerSize,
    dividerColor: .lerpColor(dividerColor, other.dividerColor, t),
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: .lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: .lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelMotion: labelMotion.lerp(other.labelMotion, t),
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerpTextStyle(errorTextStyle, other.errorTextStyle, t),
  );
}

mixin _$FOtpFieldStyleFunctions on Diagnosticable implements FOtpFieldStyleDelta {
  /// Returns itself.
  @override
  FOtpFieldStyle call(Object _) => this as FOtpFieldStyle;

  Brightness get keyboardAppearance;
  Color get cursorColor;
  double get cursorWidth;
  bool? get cursorOpacityAnimates;
  Size get itemSize;
  FOtpFieldItemStyles get itemStyles;
  EdgeInsetsGeometry get dividerPadding;
  Size get dividerSize;
  FVariants<FOtpFieldItemVariantConstraint, FOtpFieldItemVariant, Color, Delta> get dividerColor;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FLabelMotion get labelMotion;
  FVariants<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta> get labelTextStyle;
  FVariants<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta> get descriptionTextStyle;
  FVariants<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta> get errorTextStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('keyboardAppearance', keyboardAppearance, level: .debug))
      ..add(ColorProperty('cursorColor', cursorColor, level: .debug))
      ..add(DoubleProperty('cursorWidth', cursorWidth, level: .debug))
      ..add(
        FlagProperty(
          'cursorOpacityAnimates',
          value: cursorOpacityAnimates,
          ifTrue: 'cursorOpacityAnimates',
          level: .debug,
        ),
      )
      ..add(DiagnosticsProperty('itemSize', itemSize, level: .debug))
      ..add(DiagnosticsProperty('itemStyles', itemStyles, level: .debug))
      ..add(DiagnosticsProperty('dividerPadding', dividerPadding, level: .debug))
      ..add(DiagnosticsProperty('dividerSize', dividerSize, level: .debug))
      ..add(DiagnosticsProperty('dividerColor', dividerColor, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FOtpFieldStyle &&
          runtimeType == other.runtimeType &&
          keyboardAppearance == other.keyboardAppearance &&
          cursorColor == other.cursorColor &&
          cursorWidth == other.cursorWidth &&
          cursorOpacityAnimates == other.cursorOpacityAnimates &&
          itemSize == other.itemSize &&
          itemStyles == other.itemStyles &&
          dividerPadding == other.dividerPadding &&
          dividerSize == other.dividerSize &&
          dividerColor == other.dividerColor &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelMotion == other.labelMotion &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      keyboardAppearance.hashCode ^
      cursorColor.hashCode ^
      cursorWidth.hashCode ^
      cursorOpacityAnimates.hashCode ^
      itemSize.hashCode ^
      itemStyles.hashCode ^
      dividerPadding.hashCode ^
      dividerSize.hashCode ^
      dividerColor.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelMotion.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FOtpFieldStyle].
///
/// A [FOtpFieldStyle] is itself a [FOtpFieldStyleDelta].
abstract class FOtpFieldStyleDelta with Delta {
  /// Creates a partial modification of a [FOtpFieldStyle].
  ///
  /// ## Parameters
  /// * [FOtpFieldStyle.keyboardAppearance] - The appearance of the keyboard.
  /// * [FOtpFieldStyle.cursorColor] - The color of the cursor.
  /// * [FOtpFieldStyle.cursorWidth] - The width of the cursor.
  /// * [FOtpFieldStyle.cursorOpacityAnimates] - Whether the cursor opacity animates.
  /// * [FOtpFieldStyle.itemSize] - The item size.
  /// * [FOtpFieldStyle.itemStyles] - The item styles per variant.
  /// * [FOtpFieldStyle.dividerPadding] - The divider's padding.
  /// * [FOtpFieldStyle.dividerSize] - The divider's size.
  /// * [FOtpFieldStyle.dividerColor] - The divider's color.
  /// * [FOtpFieldStyle.labelPadding] - The label's padding.
  /// * [FOtpFieldStyle.descriptionPadding] - The description's padding.
  /// * [FOtpFieldStyle.errorPadding] - The error's padding.
  /// * [FOtpFieldStyle.childPadding] - The child's padding.
  /// * [FOtpFieldStyle.labelMotion] - The motion properties for error animations.
  /// * [FOtpFieldStyle.labelTextStyle] - The label's text style.
  /// * [FOtpFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FOtpFieldStyle.errorTextStyle] - The error's text style.
  const factory FOtpFieldStyleDelta.delta({
    Brightness? keyboardAppearance,
    Color? cursorColor,
    double? cursorWidth,
    bool? Function()? cursorOpacityAnimates,
    Size? itemSize,
    FVariantsDelta<FOtpFieldItemVariantConstraint, FOtpFieldItemVariant, FOtpFieldItemStyle, FOtpFieldItemStyleDelta>?
    itemStyles,
    EdgeInsetsGeometryDelta? dividerPadding,
    Size? dividerSize,
    FVariantsValueDelta<FOtpFieldItemVariantConstraint, FOtpFieldItemVariant, Color, Delta>? dividerColor,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FOtpFieldStyleDelta;

  /// Creates a delta that returns the [FOtpFieldStyle] in the current context.
  const factory FOtpFieldStyleDelta.context() = _FOtpFieldStyleContext;

  @override
  FOtpFieldStyle call(covariant FOtpFieldStyle value);
}

class _FOtpFieldStyleDelta implements FOtpFieldStyleDelta {
  const _FOtpFieldStyleDelta({
    this.keyboardAppearance,
    this.cursorColor,
    this.cursorWidth,
    this.cursorOpacityAnimates,
    this.itemSize,
    this.itemStyles,
    this.dividerPadding,
    this.dividerSize,
    this.dividerColor,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelMotion,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final Brightness? keyboardAppearance;

  final Color? cursorColor;

  final double? cursorWidth;

  final bool? Function()? cursorOpacityAnimates;

  final Size? itemSize;

  final FVariantsDelta<
    FOtpFieldItemVariantConstraint,
    FOtpFieldItemVariant,
    FOtpFieldItemStyle,
    FOtpFieldItemStyleDelta
  >?
  itemStyles;

  final EdgeInsetsGeometryDelta? dividerPadding;

  final Size? dividerSize;

  final FVariantsValueDelta<FOtpFieldItemVariantConstraint, FOtpFieldItemVariant, Color, Delta>? dividerColor;

  final EdgeInsetsGeometryDelta? labelPadding;

  final EdgeInsetsGeometryDelta? descriptionPadding;

  final EdgeInsetsGeometryDelta? errorPadding;

  final EdgeInsetsGeometryDelta? childPadding;

  final FLabelMotionDelta? labelMotion;

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle;

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle;

  final FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>?
  errorTextStyle;

  @override
  FOtpFieldStyle call(FOtpFieldStyle original) => FOtpFieldStyle(
    keyboardAppearance: keyboardAppearance ?? original.keyboardAppearance,
    cursorColor: cursorColor ?? original.cursorColor,
    cursorWidth: cursorWidth ?? original.cursorWidth,
    cursorOpacityAnimates: cursorOpacityAnimates == null ? original.cursorOpacityAnimates : cursorOpacityAnimates!(),
    itemSize: itemSize ?? original.itemSize,
    itemStyles: FOtpFieldItemStyles(itemStyles?.call(original.itemStyles) ?? original.itemStyles),
    dividerPadding: dividerPadding?.call(original.dividerPadding) ?? original.dividerPadding,
    dividerSize: dividerSize ?? original.dividerSize,
    dividerColor: dividerColor?.call(original.dividerColor) ?? original.dividerColor,
    labelPadding: labelPadding?.call(original.labelPadding) ?? original.labelPadding,
    descriptionPadding: descriptionPadding?.call(original.descriptionPadding) ?? original.descriptionPadding,
    errorPadding: errorPadding?.call(original.errorPadding) ?? original.errorPadding,
    childPadding: childPadding?.call(original.childPadding) ?? original.childPadding,
    labelMotion: labelMotion?.call(original.labelMotion) ?? original.labelMotion,
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(original.descriptionTextStyle) ?? original.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(original.errorTextStyle) ?? original.errorTextStyle,
  );
}

class _FOtpFieldStyleContext implements FOtpFieldStyleDelta {
  const _FOtpFieldStyleContext();

  @override
  FOtpFieldStyle call(FOtpFieldStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FOtpFieldItemStyleTransformations on FOtpFieldItemStyle {
  /// Returns a copy of this [FOtpFieldItemStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FOtpFieldItemStyle.decoration] - The decoration.
  /// * [FOtpFieldItemStyle.contentTextStyle] - The content's [TextStyle].
  @useResult
  FOtpFieldItemStyle copyWith({DecorationDelta? decoration, TextStyleDelta? contentTextStyle}) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    contentTextStyle: contentTextStyle?.call(this.contentTextStyle) ?? this.contentTextStyle,
  );

  /// Linearly interpolate between this and another [FOtpFieldItemStyle] using the given factor [t].
  @useResult
  FOtpFieldItemStyle lerp(FOtpFieldItemStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    contentTextStyle: .lerp(contentTextStyle, other.contentTextStyle, t) ?? contentTextStyle,
  );
}

mixin _$FOtpFieldItemStyleFunctions on Diagnosticable implements FOtpFieldItemStyleDelta {
  /// Returns itself.
  @override
  FOtpFieldItemStyle call(Object _) => this as FOtpFieldItemStyle;

  Decoration get decoration;
  TextStyle get contentTextStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('contentTextStyle', contentTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FOtpFieldItemStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          contentTextStyle == other.contentTextStyle);

  @override
  int get hashCode => decoration.hashCode ^ contentTextStyle.hashCode;
}

/// A delta that applies modifications to a [FOtpFieldItemStyle].
///
/// A [FOtpFieldItemStyle] is itself a [FOtpFieldItemStyleDelta].
abstract class FOtpFieldItemStyleDelta with Delta {
  /// Creates a partial modification of a [FOtpFieldItemStyle].
  ///
  /// ## Parameters
  /// * [FOtpFieldItemStyle.decoration] - The decoration.
  /// * [FOtpFieldItemStyle.contentTextStyle] - The content's [TextStyle].
  const factory FOtpFieldItemStyleDelta.delta({DecorationDelta? decoration, TextStyleDelta? contentTextStyle}) =
      _FOtpFieldItemStyleDelta;

  /// Creates a delta that returns the [FOtpFieldItemStyle] in the current context.
  const factory FOtpFieldItemStyleDelta.context() = _FOtpFieldItemStyleContext;

  @override
  FOtpFieldItemStyle call(covariant FOtpFieldItemStyle value);
}

class _FOtpFieldItemStyleDelta implements FOtpFieldItemStyleDelta {
  const _FOtpFieldItemStyleDelta({this.decoration, this.contentTextStyle});

  final DecorationDelta? decoration;

  final TextStyleDelta? contentTextStyle;

  @override
  FOtpFieldItemStyle call(FOtpFieldItemStyle original) => FOtpFieldItemStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    contentTextStyle: contentTextStyle?.call(original.contentTextStyle) ?? original.contentTextStyle,
  );
}

class _FOtpFieldItemStyleContext implements FOtpFieldItemStyleDelta {
  const _FOtpFieldItemStyleContext();

  @override
  FOtpFieldItemStyle call(FOtpFieldItemStyle original) => original;
}
