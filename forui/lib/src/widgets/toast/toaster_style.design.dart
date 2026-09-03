// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'toaster_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FToastVariant], which represents individual variants.
extension type const FToastVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FToastVariantConstraint] that negates [variant].
  factory not(FToastVariant variant) => FToastVariantConstraint._(Not(variant));

  /// The primary toast style.
  static const primary = FToastVariant.primary;

  /// The destructive toast style.
  static const destructive = FToastVariant.destructive;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FToastVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FToastVariant._(Desktop());

  /// The Android platform variant.
  static const android = FToastVariant.android;

  /// The iOS platform variant.
  static const iOS = FToastVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FToastVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FToastVariant.windows;

  /// The macOS platform variant.
  static const macOS = FToastVariant.macOS;

  /// The Linux platform variant.
  static const linux = FToastVariant.linux;

  /// The web platform variant.
  static const web = FToastVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FToastVariantConstraint and(FToastVariantConstraint other) => FToastVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FToastVariantConstraint], which represents combinations of variants.
extension type const FToastVariant._(FVariant _) implements FToastVariantConstraint, FVariant {
  /// The primary toast style.
  static const primary = FToastVariant._(.new(1, 'primary'));

  /// The destructive toast style.
  static const destructive = FToastVariant._(.new(2, 'destructive'));

  /// The Android platform variant.
  static const android = FToastVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FToastVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FToastVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FToastVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FToastVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FToastVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FToastVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FToasterStyleTransformations on FToasterStyle {
  /// Returns a copy of this [FToasterStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FToasterStyle.toastStyles] - The toast variant styles.
  /// * [FToasterStyle.max] - The maximum number of entries shown per [FToastAlignment].
  /// * [FToasterStyle.padding] - The toaster's padding.
  /// * [FToasterStyle.expandBehavior] - The toaster's expansion behavior.
  /// * [FToasterStyle.expandHoverEnterDuration] - The duration to wait after entering the toaster before expanding the toasts.
  /// * [FToasterStyle.expandHoverExitDuration] - The duration to wait after exiting the toaster before collapsing the toasts.
  /// * [FToasterStyle.expandStartSpacing] - The spacing below or above the toasts when they are expanded.
  /// * [FToasterStyle.expandSpacing] - The spacing between the toasts when they are expanded.
  /// * [FToasterStyle.collapsedProtrusion] - The protrusion of the collapsed toasts behind the front toast.
  /// * [FToasterStyle.collapsedScale] - The scaling factor pf the collapsed toasts behind the front toast.
  /// * [FToasterStyle.motion] - The motion-related properties.
  /// * [FToasterStyle.toastAlignment] - The toast's alignment relative to a [FToaster].
  @useResult
  FToasterStyle copyWith({
    FVariantsDelta<FToastVariantConstraint, FToastVariant, FToastStyle, FToastStyleDelta>? toastStyles,
    double? max,
    EdgeInsetsGeometryDelta? padding,
    FToasterExpandBehavior? expandBehavior,
    Duration? expandHoverEnterDuration,
    Duration? expandHoverExitDuration,
    double? expandStartSpacing,
    double? expandSpacing,
    double? collapsedProtrusion,
    double? collapsedScale,
    FToasterMotionDelta? motion,
    FToastAlignment? toastAlignment,
  }) => .new(
    toastStyles: FToastStyles(toastStyles?.call(this.toastStyles) ?? this.toastStyles),
    max: max ?? this.max,
    padding: padding?.call(this.padding) ?? this.padding,
    expandBehavior: expandBehavior ?? this.expandBehavior,
    expandHoverEnterDuration: expandHoverEnterDuration ?? this.expandHoverEnterDuration,
    expandHoverExitDuration: expandHoverExitDuration ?? this.expandHoverExitDuration,
    expandStartSpacing: expandStartSpacing ?? this.expandStartSpacing,
    expandSpacing: expandSpacing ?? this.expandSpacing,
    collapsedProtrusion: collapsedProtrusion ?? this.collapsedProtrusion,
    collapsedScale: collapsedScale ?? this.collapsedScale,
    motion: motion?.call(this.motion) ?? this.motion,
    toastAlignment: toastAlignment ?? this.toastAlignment,
  );

  /// Linearly interpolate between this and another [FToasterStyle] using the given factor [t].
  @useResult
  FToasterStyle lerp(FToasterStyle other, double t) => .new(
    toastStyles: FToastStyles(.lerpWhere(toastStyles, other.toastStyles, t, (a, b, t) => a!.lerp(b!, t))),
    max: lerpDouble(max, other.max, t) ?? max,
    padding: .lerp(padding, other.padding, t) ?? padding,
    expandBehavior: t < 0.5 ? expandBehavior : other.expandBehavior,
    expandHoverEnterDuration: t < 0.5 ? expandHoverEnterDuration : other.expandHoverEnterDuration,
    expandHoverExitDuration: t < 0.5 ? expandHoverExitDuration : other.expandHoverExitDuration,
    expandStartSpacing: lerpDouble(expandStartSpacing, other.expandStartSpacing, t) ?? expandStartSpacing,
    expandSpacing: lerpDouble(expandSpacing, other.expandSpacing, t) ?? expandSpacing,
    collapsedProtrusion: lerpDouble(collapsedProtrusion, other.collapsedProtrusion, t) ?? collapsedProtrusion,
    collapsedScale: lerpDouble(collapsedScale, other.collapsedScale, t) ?? collapsedScale,
    motion: motion.lerp(other.motion, t),
    toastAlignment: t < 0.5 ? toastAlignment : other.toastAlignment,
  );
}

mixin _$FToasterStyleFunctions on Diagnosticable implements FToasterStyleDelta {
  /// Returns itself.
  @override
  FToasterStyle call(Object _) => this as FToasterStyle;

  FToastStyles get toastStyles;
  double get max;
  EdgeInsetsGeometry get padding;
  FToasterExpandBehavior get expandBehavior;
  Duration get expandHoverEnterDuration;
  Duration get expandHoverExitDuration;
  double get expandStartSpacing;
  double get expandSpacing;
  double get collapsedProtrusion;
  double get collapsedScale;
  FToasterMotion get motion;
  FToastAlignment get toastAlignment;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('toastStyles', toastStyles, level: .debug))
      ..add(DoubleProperty('max', max, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(EnumProperty('expandBehavior', expandBehavior, level: .debug))
      ..add(DiagnosticsProperty('expandHoverEnterDuration', expandHoverEnterDuration, level: .debug))
      ..add(DiagnosticsProperty('expandHoverExitDuration', expandHoverExitDuration, level: .debug))
      ..add(DoubleProperty('expandStartSpacing', expandStartSpacing, level: .debug))
      ..add(DoubleProperty('expandSpacing', expandSpacing, level: .debug))
      ..add(DoubleProperty('collapsedProtrusion', collapsedProtrusion, level: .debug))
      ..add(DoubleProperty('collapsedScale', collapsedScale, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug))
      ..add(DiagnosticsProperty('toastAlignment', toastAlignment, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FToasterStyle &&
          runtimeType == other.runtimeType &&
          toastStyles == other.toastStyles &&
          max == other.max &&
          padding == other.padding &&
          expandBehavior == other.expandBehavior &&
          expandHoverEnterDuration == other.expandHoverEnterDuration &&
          expandHoverExitDuration == other.expandHoverExitDuration &&
          expandStartSpacing == other.expandStartSpacing &&
          expandSpacing == other.expandSpacing &&
          collapsedProtrusion == other.collapsedProtrusion &&
          collapsedScale == other.collapsedScale &&
          motion == other.motion &&
          toastAlignment == other.toastAlignment);

  @override
  int get hashCode =>
      toastStyles.hashCode ^
      max.hashCode ^
      padding.hashCode ^
      expandBehavior.hashCode ^
      expandHoverEnterDuration.hashCode ^
      expandHoverExitDuration.hashCode ^
      expandStartSpacing.hashCode ^
      expandSpacing.hashCode ^
      collapsedProtrusion.hashCode ^
      collapsedScale.hashCode ^
      motion.hashCode ^
      toastAlignment.hashCode;
}

/// A delta that applies modifications to a [FToasterStyle].
///
/// A [FToasterStyle] is itself a [FToasterStyleDelta].
abstract class FToasterStyleDelta with Delta {
  /// Creates a partial modification of a [FToasterStyle].
  ///
  /// ## Parameters
  /// * [FToasterStyle.toastStyles] - The toast variant styles.
  /// * [FToasterStyle.max] - The maximum number of entries shown per [FToastAlignment].
  /// * [FToasterStyle.padding] - The toaster's padding.
  /// * [FToasterStyle.expandBehavior] - The toaster's expansion behavior.
  /// * [FToasterStyle.expandHoverEnterDuration] - The duration to wait after entering the toaster before expanding the toasts.
  /// * [FToasterStyle.expandHoverExitDuration] - The duration to wait after exiting the toaster before collapsing the toasts.
  /// * [FToasterStyle.expandStartSpacing] - The spacing below or above the toasts when they are expanded.
  /// * [FToasterStyle.expandSpacing] - The spacing between the toasts when they are expanded.
  /// * [FToasterStyle.collapsedProtrusion] - The protrusion of the collapsed toasts behind the front toast.
  /// * [FToasterStyle.collapsedScale] - The scaling factor pf the collapsed toasts behind the front toast.
  /// * [FToasterStyle.motion] - The motion-related properties.
  /// * [FToasterStyle.toastAlignment] - The toast's alignment relative to a [FToaster].
  const factory delta({
    FVariantsDelta<FToastVariantConstraint, FToastVariant, FToastStyle, FToastStyleDelta>? toastStyles,
    double? max,
    EdgeInsetsGeometryDelta? padding,
    FToasterExpandBehavior? expandBehavior,
    Duration? expandHoverEnterDuration,
    Duration? expandHoverExitDuration,
    double? expandStartSpacing,
    double? expandSpacing,
    double? collapsedProtrusion,
    double? collapsedScale,
    FToasterMotionDelta? motion,
    FToastAlignment? toastAlignment,
  }) = _FToasterStyleDelta;

  /// Creates a delta that returns the [FToasterStyle] in the current context.
  const factory context() = _FToasterStyleContext;

  @override
  FToasterStyle call(covariant FToasterStyle value);
}

class _FToasterStyleDelta implements FToasterStyleDelta {
  const new({
    this.toastStyles,
    this.max,
    this.padding,
    this.expandBehavior,
    this.expandHoverEnterDuration,
    this.expandHoverExitDuration,
    this.expandStartSpacing,
    this.expandSpacing,
    this.collapsedProtrusion,
    this.collapsedScale,
    this.motion,
    this.toastAlignment,
  });

  final FVariantsDelta<FToastVariantConstraint, FToastVariant, FToastStyle, FToastStyleDelta>? toastStyles;

  final double? max;

  final EdgeInsetsGeometryDelta? padding;

  final FToasterExpandBehavior? expandBehavior;

  final Duration? expandHoverEnterDuration;

  final Duration? expandHoverExitDuration;

  final double? expandStartSpacing;

  final double? expandSpacing;

  final double? collapsedProtrusion;

  final double? collapsedScale;

  final FToasterMotionDelta? motion;

  final FToastAlignment? toastAlignment;

  @override
  FToasterStyle call(FToasterStyle original) => FToasterStyle(
    toastStyles: FToastStyles(toastStyles?.call(original.toastStyles) ?? original.toastStyles),
    max: max ?? original.max,
    padding: padding?.call(original.padding) ?? original.padding,
    expandBehavior: expandBehavior ?? original.expandBehavior,
    expandHoverEnterDuration: expandHoverEnterDuration ?? original.expandHoverEnterDuration,
    expandHoverExitDuration: expandHoverExitDuration ?? original.expandHoverExitDuration,
    expandStartSpacing: expandStartSpacing ?? original.expandStartSpacing,
    expandSpacing: expandSpacing ?? original.expandSpacing,
    collapsedProtrusion: collapsedProtrusion ?? original.collapsedProtrusion,
    collapsedScale: collapsedScale ?? original.collapsedScale,
    motion: motion?.call(original.motion) ?? original.motion,
    toastAlignment: toastAlignment ?? original.toastAlignment,
  );
}

class _FToasterStyleContext implements FToasterStyleDelta {
  const new();

  @override
  FToasterStyle call(FToasterStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FToasterMotionTransformations on FToasterMotion {
  /// Returns a copy of this [FToasterMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FToasterMotion.expandDuration] - The duration of the toasts' expansion.
  /// * [FToasterMotion.collapseDuration] - The duration of the toasts' collapsing.
  /// * [FToasterMotion.expandCurve] - The animation curve for the toasts' expansion and collapsing.
  /// * [FToasterMotion.collapseCurve] - The animation curve for the toasts' collapsing.
  @useResult
  FToasterMotion copyWith({
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
  }) => .new(
    expandDuration: expandDuration ?? this.expandDuration,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseCurve: collapseCurve ?? this.collapseCurve,
  );

  /// Linearly interpolate between this and another [FToasterMotion] using the given factor [t].
  @useResult
  FToasterMotion lerp(FToasterMotion other, double t) => .new(
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    collapseDuration: t < 0.5 ? collapseDuration : other.collapseDuration,
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapseCurve: t < 0.5 ? collapseCurve : other.collapseCurve,
  );
}

mixin _$FToasterMotionFunctions on Diagnosticable implements FToasterMotionDelta {
  /// Returns itself.
  @override
  FToasterMotion call(Object _) => this as FToasterMotion;

  Duration get expandDuration;
  Duration get collapseDuration;
  Curve get expandCurve;
  Curve get collapseCurve;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expandDuration', expandDuration, level: .debug))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration, level: .debug))
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: .debug))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FToasterMotion &&
          runtimeType == other.runtimeType &&
          expandDuration == other.expandDuration &&
          collapseDuration == other.collapseDuration &&
          expandCurve == other.expandCurve &&
          collapseCurve == other.collapseCurve);

  @override
  int get hashCode =>
      expandDuration.hashCode ^ collapseDuration.hashCode ^ expandCurve.hashCode ^ collapseCurve.hashCode;
}

/// A delta that applies modifications to a [FToasterMotion].
///
/// A [FToasterMotion] is itself a [FToasterMotionDelta].
abstract class FToasterMotionDelta with Delta {
  /// Creates a partial modification of a [FToasterMotion].
  ///
  /// ## Parameters
  /// * [FToasterMotion.expandDuration] - The duration of the toasts' expansion.
  /// * [FToasterMotion.collapseDuration] - The duration of the toasts' collapsing.
  /// * [FToasterMotion.expandCurve] - The animation curve for the toasts' expansion and collapsing.
  /// * [FToasterMotion.collapseCurve] - The animation curve for the toasts' collapsing.
  const factory delta({
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
  }) = _FToasterMotionDelta;

  /// Creates a delta that returns the [FToasterMotion] in the current context.
  const factory context() = _FToasterMotionContext;

  @override
  FToasterMotion call(covariant FToasterMotion value);
}

class _FToasterMotionDelta implements FToasterMotionDelta {
  const new({this.expandDuration, this.collapseDuration, this.expandCurve, this.collapseCurve});

  final Duration? expandDuration;

  final Duration? collapseDuration;

  final Curve? expandCurve;

  final Curve? collapseCurve;

  @override
  FToasterMotion call(FToasterMotion original) => FToasterMotion(
    expandDuration: expandDuration ?? original.expandDuration,
    collapseDuration: collapseDuration ?? original.collapseDuration,
    expandCurve: expandCurve ?? original.expandCurve,
    collapseCurve: collapseCurve ?? original.collapseCurve,
  );
}

class _FToasterMotionContext implements FToasterMotionDelta {
  const new();

  @override
  FToasterMotion call(FToasterMotion original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FToastStyleTransformations on FToastStyle {
  /// Returns a copy of this [FToastStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FToastStyle.decoration] - The toast's decoration.
  /// * [FToastStyle.iconStyle] - The style of the toast's prefix icon.
  /// * [FToastStyle.titleTextStyle] - The title's text style.
  /// * [FToastStyle.descriptionTextStyle] - The description's text style.
  /// * [FToastStyle.padding] - The toast content's padding.
  /// * [FToastStyle.constraints] - The toast's constraints.
  /// * [FToastStyle.backgroundFilter] - An optional background filter.
  /// * [FToastStyle.iconSpacing] - The spacing between the icon and the title.
  /// * [FToastStyle.titleSpacing] - The spacing between the title and description.
  /// * [FToastStyle.suffixSpacing] - The spacing between the content and the suffix.
  /// * [FToastStyle.motion] - The motion-related properties.
  @useResult
  FToastStyle copyWith({
    DecorationDelta? decoration,
    IconThemeDataDelta? iconStyle,
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? descriptionTextStyle,
    EdgeInsetsGeometryDelta? padding,
    BoxConstraints? constraints,
    ImageFilter? backgroundFilter = Sentinels.imageFilter,
    double? iconSpacing,
    double? titleSpacing,
    double? suffixSpacing,
    FToastMotionDelta? motion,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    titleTextStyle: titleTextStyle?.call(this.titleTextStyle) ?? this.titleTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    constraints: constraints ?? this.constraints,
    backgroundFilter: backgroundFilter == Sentinels.imageFilter ? this.backgroundFilter : backgroundFilter,
    iconSpacing: iconSpacing ?? this.iconSpacing,
    titleSpacing: titleSpacing ?? this.titleSpacing,
    suffixSpacing: suffixSpacing ?? this.suffixSpacing,
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FToastStyle] using the given factor [t].
  @useResult
  FToastStyle lerp(FToastStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    iconStyle: .lerp(iconStyle, other.iconStyle, t),
    titleTextStyle: .lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    descriptionTextStyle: .lerp(descriptionTextStyle, other.descriptionTextStyle, t) ?? descriptionTextStyle,
    padding: .lerp(padding, other.padding, t) ?? padding,
    constraints: .lerp(constraints, other.constraints, t) ?? constraints,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    iconSpacing: lerpDouble(iconSpacing, other.iconSpacing, t) ?? iconSpacing,
    titleSpacing: lerpDouble(titleSpacing, other.titleSpacing, t) ?? titleSpacing,
    suffixSpacing: lerpDouble(suffixSpacing, other.suffixSpacing, t) ?? suffixSpacing,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FToastStyleFunctions on Diagnosticable implements FToastStyleDelta {
  /// Returns itself.
  @override
  FToastStyle call(Object _) => this as FToastStyle;

  Decoration get decoration;
  IconThemeData get iconStyle;
  TextStyle get titleTextStyle;
  TextStyle get descriptionTextStyle;
  EdgeInsetsGeometry get padding;
  BoxConstraints get constraints;
  ImageFilter? get backgroundFilter;
  double get iconSpacing;
  double get titleSpacing;
  double get suffixSpacing;
  FToastMotion get motion;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('constraints', constraints, level: .debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: .debug))
      ..add(DoubleProperty('iconSpacing', iconSpacing, level: .debug))
      ..add(DoubleProperty('titleSpacing', titleSpacing, level: .debug))
      ..add(DoubleProperty('suffixSpacing', suffixSpacing, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FToastStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          iconStyle == other.iconStyle &&
          titleTextStyle == other.titleTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          padding == other.padding &&
          constraints == other.constraints &&
          backgroundFilter == other.backgroundFilter &&
          iconSpacing == other.iconSpacing &&
          titleSpacing == other.titleSpacing &&
          suffixSpacing == other.suffixSpacing &&
          motion == other.motion);

  @override
  int get hashCode =>
      decoration.hashCode ^
      iconStyle.hashCode ^
      titleTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      padding.hashCode ^
      constraints.hashCode ^
      backgroundFilter.hashCode ^
      iconSpacing.hashCode ^
      titleSpacing.hashCode ^
      suffixSpacing.hashCode ^
      motion.hashCode;
}

/// A delta that applies modifications to a [FToastStyle].
///
/// A [FToastStyle] is itself a [FToastStyleDelta].
abstract class FToastStyleDelta with Delta {
  /// Creates a partial modification of a [FToastStyle].
  ///
  /// ## Parameters
  /// * [FToastStyle.decoration] - The toast's decoration.
  /// * [FToastStyle.iconStyle] - The style of the toast's prefix icon.
  /// * [FToastStyle.titleTextStyle] - The title's text style.
  /// * [FToastStyle.descriptionTextStyle] - The description's text style.
  /// * [FToastStyle.padding] - The toast content's padding.
  /// * [FToastStyle.constraints] - The toast's constraints.
  /// * [FToastStyle.backgroundFilter] - An optional background filter.
  /// * [FToastStyle.iconSpacing] - The spacing between the icon and the title.
  /// * [FToastStyle.titleSpacing] - The spacing between the title and description.
  /// * [FToastStyle.suffixSpacing] - The spacing between the content and the suffix.
  /// * [FToastStyle.motion] - The motion-related properties.
  const factory delta({
    DecorationDelta? decoration,
    IconThemeDataDelta? iconStyle,
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? descriptionTextStyle,
    EdgeInsetsGeometryDelta? padding,
    BoxConstraints? constraints,
    ImageFilter? backgroundFilter,
    double? iconSpacing,
    double? titleSpacing,
    double? suffixSpacing,
    FToastMotionDelta? motion,
  }) = _FToastStyleDelta;

  /// Creates a delta that returns the [FToastStyle] in the current context.
  const factory context() = _FToastStyleContext;

  @override
  FToastStyle call(covariant FToastStyle value);
}

class _FToastStyleDelta implements FToastStyleDelta {
  const new({
    this.decoration,
    this.iconStyle,
    this.titleTextStyle,
    this.descriptionTextStyle,
    this.padding,
    this.constraints,
    this.backgroundFilter = Sentinels.imageFilter,
    this.iconSpacing,
    this.titleSpacing,
    this.suffixSpacing,
    this.motion,
  });

  final DecorationDelta? decoration;

  final IconThemeDataDelta? iconStyle;

  final TextStyleDelta? titleTextStyle;

  final TextStyleDelta? descriptionTextStyle;

  final EdgeInsetsGeometryDelta? padding;

  final BoxConstraints? constraints;

  final ImageFilter? backgroundFilter;

  final double? iconSpacing;

  final double? titleSpacing;

  final double? suffixSpacing;

  final FToastMotionDelta? motion;

  @override
  FToastStyle call(FToastStyle original) => FToastStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(original.descriptionTextStyle) ?? original.descriptionTextStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    constraints: constraints ?? original.constraints,
    backgroundFilter: backgroundFilter == Sentinels.imageFilter ? original.backgroundFilter : backgroundFilter,
    iconSpacing: iconSpacing ?? original.iconSpacing,
    titleSpacing: titleSpacing ?? original.titleSpacing,
    suffixSpacing: suffixSpacing ?? original.suffixSpacing,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FToastStyleContext implements FToastStyleDelta {
  const new();

  @override
  FToastStyle call(FToastStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FToastMotionTransformations on FToastMotion {
  /// Returns a copy of this [FToastMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FToastMotion.entranceDuration] - The duration of the toast's entrance when it is initially added to to toaster.
  /// * [FToastMotion.dismissDuration] - The duration of the toast's exit animation when it is dismissed.
  /// * [FToastMotion.transitionDuration] - The duration of the toast's transition between places in the toaster.
  /// * [FToastMotion.reentranceDuration] - The duration of the toast's fade-in animation when another toast has been dismissed and this toast re-enters the toaster.
  /// * [FToastMotion.exitDuration] - The duration of the toast's fade-out animation when the number of toasts in a toaster exceeds the maximum allowed and this toast is hidden.
  /// * [FToastMotion.swipeCompletionDuration] - The toast's swipe completion animation duration.
  /// * [FToastMotion.entranceCurve] - The toast's initial entrance animation curve.
  /// * [FToastMotion.dismissCurve] - The toast's exit animation curve.
  /// * [FToastMotion.transitionCurve] - The toast's transition animation curve.
  /// * [FToastMotion.reentranceCurve] - The curve of the toast's fade-in animation when another toast has been dismissed and this toast re-enters the toaster.
  /// * [FToastMotion.exitCurve] - The curve of the toast's fade-out animation when the number of toasts in a toaster exceeds the maximum allowed and this toast is hidden.
  /// * [FToastMotion.swipeCompletionCurve] - The toast's swipe completion animation curve.
  /// * [FToastMotion.entranceDismissFadeTween] - The toast's initial entrance's opacity and dismiss's fade tween.
  @useResult
  FToastMotion copyWith({
    Duration? entranceDuration,
    Duration? dismissDuration,
    Duration? transitionDuration,
    Duration? reentranceDuration,
    Duration? exitDuration,
    Duration? swipeCompletionDuration,
    Curve? entranceCurve,
    Curve? dismissCurve,
    Curve? transitionCurve,
    Curve? reentranceCurve,
    Curve? exitCurve,
    Curve? swipeCompletionCurve,
    Animatable<double>? entranceDismissFadeTween,
  }) => .new(
    entranceDuration: entranceDuration ?? this.entranceDuration,
    dismissDuration: dismissDuration ?? this.dismissDuration,
    transitionDuration: transitionDuration ?? this.transitionDuration,
    reentranceDuration: reentranceDuration ?? this.reentranceDuration,
    exitDuration: exitDuration ?? this.exitDuration,
    swipeCompletionDuration: swipeCompletionDuration ?? this.swipeCompletionDuration,
    entranceCurve: entranceCurve ?? this.entranceCurve,
    dismissCurve: dismissCurve ?? this.dismissCurve,
    transitionCurve: transitionCurve ?? this.transitionCurve,
    reentranceCurve: reentranceCurve ?? this.reentranceCurve,
    exitCurve: exitCurve ?? this.exitCurve,
    swipeCompletionCurve: swipeCompletionCurve ?? this.swipeCompletionCurve,
    entranceDismissFadeTween: entranceDismissFadeTween ?? this.entranceDismissFadeTween,
  );

  /// Linearly interpolate between this and another [FToastMotion] using the given factor [t].
  @useResult
  FToastMotion lerp(FToastMotion other, double t) => .new(
    entranceDuration: t < 0.5 ? entranceDuration : other.entranceDuration,
    dismissDuration: t < 0.5 ? dismissDuration : other.dismissDuration,
    transitionDuration: t < 0.5 ? transitionDuration : other.transitionDuration,
    reentranceDuration: t < 0.5 ? reentranceDuration : other.reentranceDuration,
    exitDuration: t < 0.5 ? exitDuration : other.exitDuration,
    swipeCompletionDuration: t < 0.5 ? swipeCompletionDuration : other.swipeCompletionDuration,
    entranceCurve: t < 0.5 ? entranceCurve : other.entranceCurve,
    dismissCurve: t < 0.5 ? dismissCurve : other.dismissCurve,
    transitionCurve: t < 0.5 ? transitionCurve : other.transitionCurve,
    reentranceCurve: t < 0.5 ? reentranceCurve : other.reentranceCurve,
    exitCurve: t < 0.5 ? exitCurve : other.exitCurve,
    swipeCompletionCurve: t < 0.5 ? swipeCompletionCurve : other.swipeCompletionCurve,
    entranceDismissFadeTween: t < 0.5 ? entranceDismissFadeTween : other.entranceDismissFadeTween,
  );
}

mixin _$FToastMotionFunctions on Diagnosticable implements FToastMotionDelta {
  /// Returns itself.
  @override
  FToastMotion call(Object _) => this as FToastMotion;

  Duration get entranceDuration;
  Duration get dismissDuration;
  Duration get transitionDuration;
  Duration get reentranceDuration;
  Duration get exitDuration;
  Duration get swipeCompletionDuration;
  Curve get entranceCurve;
  Curve get dismissCurve;
  Curve get transitionCurve;
  Curve get reentranceCurve;
  Curve get exitCurve;
  Curve get swipeCompletionCurve;
  Animatable<double> get entranceDismissFadeTween;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('entranceDuration', entranceDuration, level: .debug))
      ..add(DiagnosticsProperty('dismissDuration', dismissDuration, level: .debug))
      ..add(DiagnosticsProperty('transitionDuration', transitionDuration, level: .debug))
      ..add(DiagnosticsProperty('reentranceDuration', reentranceDuration, level: .debug))
      ..add(DiagnosticsProperty('exitDuration', exitDuration, level: .debug))
      ..add(DiagnosticsProperty('swipeCompletionDuration', swipeCompletionDuration, level: .debug))
      ..add(DiagnosticsProperty('entranceCurve', entranceCurve, level: .debug))
      ..add(DiagnosticsProperty('dismissCurve', dismissCurve, level: .debug))
      ..add(DiagnosticsProperty('transitionCurve', transitionCurve, level: .debug))
      ..add(DiagnosticsProperty('reentranceCurve', reentranceCurve, level: .debug))
      ..add(DiagnosticsProperty('exitCurve', exitCurve, level: .debug))
      ..add(DiagnosticsProperty('swipeCompletionCurve', swipeCompletionCurve, level: .debug))
      ..add(DiagnosticsProperty('entranceDismissFadeTween', entranceDismissFadeTween, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FToastMotion &&
          runtimeType == other.runtimeType &&
          entranceDuration == other.entranceDuration &&
          dismissDuration == other.dismissDuration &&
          transitionDuration == other.transitionDuration &&
          reentranceDuration == other.reentranceDuration &&
          exitDuration == other.exitDuration &&
          swipeCompletionDuration == other.swipeCompletionDuration &&
          entranceCurve == other.entranceCurve &&
          dismissCurve == other.dismissCurve &&
          transitionCurve == other.transitionCurve &&
          reentranceCurve == other.reentranceCurve &&
          exitCurve == other.exitCurve &&
          swipeCompletionCurve == other.swipeCompletionCurve &&
          entranceDismissFadeTween == other.entranceDismissFadeTween);

  @override
  int get hashCode =>
      entranceDuration.hashCode ^
      dismissDuration.hashCode ^
      transitionDuration.hashCode ^
      reentranceDuration.hashCode ^
      exitDuration.hashCode ^
      swipeCompletionDuration.hashCode ^
      entranceCurve.hashCode ^
      dismissCurve.hashCode ^
      transitionCurve.hashCode ^
      reentranceCurve.hashCode ^
      exitCurve.hashCode ^
      swipeCompletionCurve.hashCode ^
      entranceDismissFadeTween.hashCode;
}

/// A delta that applies modifications to a [FToastMotion].
///
/// A [FToastMotion] is itself a [FToastMotionDelta].
abstract class FToastMotionDelta with Delta {
  /// Creates a partial modification of a [FToastMotion].
  ///
  /// ## Parameters
  /// * [FToastMotion.entranceDuration] - The duration of the toast's entrance when it is initially added to to toaster.
  /// * [FToastMotion.dismissDuration] - The duration of the toast's exit animation when it is dismissed.
  /// * [FToastMotion.transitionDuration] - The duration of the toast's transition between places in the toaster.
  /// * [FToastMotion.reentranceDuration] - The duration of the toast's fade-in animation when another toast has been dismissed and this toast re-enters the toaster.
  /// * [FToastMotion.exitDuration] - The duration of the toast's fade-out animation when the number of toasts in a toaster exceeds the maximum allowed and this toast is hidden.
  /// * [FToastMotion.swipeCompletionDuration] - The toast's swipe completion animation duration.
  /// * [FToastMotion.entranceCurve] - The toast's initial entrance animation curve.
  /// * [FToastMotion.dismissCurve] - The toast's exit animation curve.
  /// * [FToastMotion.transitionCurve] - The toast's transition animation curve.
  /// * [FToastMotion.reentranceCurve] - The curve of the toast's fade-in animation when another toast has been dismissed and this toast re-enters the toaster.
  /// * [FToastMotion.exitCurve] - The curve of the toast's fade-out animation when the number of toasts in a toaster exceeds the maximum allowed and this toast is hidden.
  /// * [FToastMotion.swipeCompletionCurve] - The toast's swipe completion animation curve.
  /// * [FToastMotion.entranceDismissFadeTween] - The toast's initial entrance's opacity and dismiss's fade tween.
  const factory delta({
    Duration? entranceDuration,
    Duration? dismissDuration,
    Duration? transitionDuration,
    Duration? reentranceDuration,
    Duration? exitDuration,
    Duration? swipeCompletionDuration,
    Curve? entranceCurve,
    Curve? dismissCurve,
    Curve? transitionCurve,
    Curve? reentranceCurve,
    Curve? exitCurve,
    Curve? swipeCompletionCurve,
    Animatable<double>? entranceDismissFadeTween,
  }) = _FToastMotionDelta;

  /// Creates a delta that returns the [FToastMotion] in the current context.
  const factory context() = _FToastMotionContext;

  @override
  FToastMotion call(covariant FToastMotion value);
}

class _FToastMotionDelta implements FToastMotionDelta {
  const new({
    this.entranceDuration,
    this.dismissDuration,
    this.transitionDuration,
    this.reentranceDuration,
    this.exitDuration,
    this.swipeCompletionDuration,
    this.entranceCurve,
    this.dismissCurve,
    this.transitionCurve,
    this.reentranceCurve,
    this.exitCurve,
    this.swipeCompletionCurve,
    this.entranceDismissFadeTween,
  });

  final Duration? entranceDuration;

  final Duration? dismissDuration;

  final Duration? transitionDuration;

  final Duration? reentranceDuration;

  final Duration? exitDuration;

  final Duration? swipeCompletionDuration;

  final Curve? entranceCurve;

  final Curve? dismissCurve;

  final Curve? transitionCurve;

  final Curve? reentranceCurve;

  final Curve? exitCurve;

  final Curve? swipeCompletionCurve;

  final Animatable<double>? entranceDismissFadeTween;

  @override
  FToastMotion call(FToastMotion original) => FToastMotion(
    entranceDuration: entranceDuration ?? original.entranceDuration,
    dismissDuration: dismissDuration ?? original.dismissDuration,
    transitionDuration: transitionDuration ?? original.transitionDuration,
    reentranceDuration: reentranceDuration ?? original.reentranceDuration,
    exitDuration: exitDuration ?? original.exitDuration,
    swipeCompletionDuration: swipeCompletionDuration ?? original.swipeCompletionDuration,
    entranceCurve: entranceCurve ?? original.entranceCurve,
    dismissCurve: dismissCurve ?? original.dismissCurve,
    transitionCurve: transitionCurve ?? original.transitionCurve,
    reentranceCurve: reentranceCurve ?? original.reentranceCurve,
    exitCurve: exitCurve ?? original.exitCurve,
    swipeCompletionCurve: swipeCompletionCurve ?? original.swipeCompletionCurve,
    entranceDismissFadeTween: entranceDismissFadeTween ?? original.entranceDismissFadeTween,
  );
}

class _FToastMotionContext implements FToastMotionDelta {
  const new();

  @override
  FToastMotion call(FToastMotion original) => original;
}
