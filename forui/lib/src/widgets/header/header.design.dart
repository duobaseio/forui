// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'header.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FHeaderStylesTransformations on FHeaderStyles {
  /// Returns a copy of this [FHeaderStyles] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FHeaderStyles.rootStyle] - The root header's style.
  /// * [FHeaderStyles.nestedStyle] - The nested header's style.
  @useResult
  FHeaderStyles copyWith({
    FHeaderStyle Function(FHeaderStyle style)? rootStyle,
    FHeaderStyle Function(FHeaderStyle style)? nestedStyle,
  }) => .new(
    rootStyle: rootStyle != null ? rootStyle(this.rootStyle) : this.rootStyle,
    nestedStyle: nestedStyle != null ? nestedStyle(this.nestedStyle) : this.nestedStyle,
  );

  /// Linearly interpolate between this and another [FHeaderStyles] using the given factor [t].
  @useResult
  FHeaderStyles lerp(FHeaderStyles other, double t) =>
      .new(rootStyle: rootStyle.lerp(other.rootStyle, t), nestedStyle: nestedStyle.lerp(other.nestedStyle, t));
}

mixin _$FHeaderStylesFunctions on Diagnosticable {
  FHeaderStyle get rootStyle;
  FHeaderStyle get nestedStyle;

  /// Returns itself.
  ///
  /// Allows [FHeaderStyles] to replace functions that accept and return a [FHeaderStyles], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FHeaderStyles Function(FHeaderStyles) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FHeaderStyles(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FHeaderStyles(...));
  /// ```
  @useResult
  FHeaderStyles call(Object? _) => this as FHeaderStyles;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('rootStyle', rootStyle, level: .debug))
      ..add(DiagnosticsProperty('nestedStyle', nestedStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderStyles &&
          runtimeType == other.runtimeType &&
          rootStyle == other.rootStyle &&
          nestedStyle == other.nestedStyle);

  @override
  int get hashCode => rootStyle.hashCode ^ nestedStyle.hashCode;
}

/// A delta that applies modifications to a [FHeaderStyles].
sealed class FHeaderStylesDelta with Delta<FHeaderStyles> {
  /// Creates a complete replacement for a [FHeaderStyles].
  const factory FHeaderStylesDelta.replace(FHeaderStyles replacement) = _FHeaderStylesReplace;

  /// Creates a partial modification of a [FHeaderStyles].
  const factory FHeaderStylesDelta.merge({FHeaderStyleDelta? rootStyle, FHeaderStyleDelta? nestedStyle}) =
      _FHeaderStylesMerge;
}

class _FHeaderStylesReplace implements FHeaderStylesDelta {
  const _FHeaderStylesReplace(this._replacement);

  final FHeaderStyles _replacement;

  @override
  FHeaderStyles call(FHeaderStyles _) => _replacement;
}

class _FHeaderStylesMerge implements FHeaderStylesDelta {
  const _FHeaderStylesMerge({this.rootStyle, this.nestedStyle});

  final FHeaderStyleDelta? rootStyle;

  final FHeaderStyleDelta? nestedStyle;

  @override
  FHeaderStyles call(FHeaderStyles original) => FHeaderStyles(
    rootStyle: rootStyle?.call(original.rootStyle) ?? original.rootStyle,
    nestedStyle: nestedStyle?.call(original.nestedStyle) ?? original.nestedStyle,
  );
}

/// Provides [copyWith] and [lerp] methods.
extension $FHeaderStyleTransformations on FHeaderStyle {
  /// Returns a copy of this [FHeaderStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FHeaderStyle.systemOverlayStyle] - The system overlay style.
  /// * [FHeaderStyle.decoration] - The decoration.
  /// * [FHeaderStyle.backgroundFilter] - An optional background filter.
  /// * [FHeaderStyle.padding] - The padding.
  /// * [FHeaderStyle.actionSpacing] - The spacing between [FHeaderAction]s.
  /// * [FHeaderStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FHeaderStyle.actionStyle] - The [FHeaderAction]s' style.
  @useResult
  FHeaderStyle copyWith({
    SystemUiOverlayStyle? systemOverlayStyle,
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsetsGeometry? padding,
    double? actionSpacing,
    TextStyle? titleTextStyle,
    FHeaderActionStyle Function(FHeaderActionStyle style)? actionStyle,
  }) => .new(
    systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    padding: padding ?? this.padding,
    actionSpacing: actionSpacing ?? this.actionSpacing,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    actionStyle: actionStyle != null ? actionStyle(this.actionStyle) : this.actionStyle,
  );

  /// Linearly interpolate between this and another [FHeaderStyle] using the given factor [t].
  @useResult
  FHeaderStyle lerp(FHeaderStyle other, double t) => .new(
    systemOverlayStyle: t < 0.5 ? systemOverlayStyle : other.systemOverlayStyle,
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    padding: .lerp(padding, other.padding, t) ?? padding,
    actionSpacing: lerpDouble(actionSpacing, other.actionSpacing, t) ?? actionSpacing,
    titleTextStyle: .lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    actionStyle: actionStyle.lerp(other.actionStyle, t),
  );
}

mixin _$FHeaderStyleFunctions on Diagnosticable {
  SystemUiOverlayStyle get systemOverlayStyle;
  BoxDecoration get decoration;
  ImageFilter? get backgroundFilter;
  EdgeInsetsGeometry get padding;
  double get actionSpacing;
  TextStyle get titleTextStyle;
  FHeaderActionStyle get actionStyle;

  /// Returns itself.
  ///
  /// Allows [FHeaderStyle] to replace functions that accept and return a [FHeaderStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FHeaderStyle Function(FHeaderStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FHeaderStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FHeaderStyle(...));
  /// ```
  @useResult
  FHeaderStyle call(Object? _) => this as FHeaderStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('systemOverlayStyle', systemOverlayStyle, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('actionSpacing', actionSpacing, level: .debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('actionStyle', actionStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderStyle &&
          runtimeType == other.runtimeType &&
          systemOverlayStyle == other.systemOverlayStyle &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          actionSpacing == other.actionSpacing &&
          titleTextStyle == other.titleTextStyle &&
          actionStyle == other.actionStyle);

  @override
  int get hashCode =>
      systemOverlayStyle.hashCode ^
      decoration.hashCode ^
      backgroundFilter.hashCode ^
      padding.hashCode ^
      actionSpacing.hashCode ^
      titleTextStyle.hashCode ^
      actionStyle.hashCode;
}

/// A delta that applies modifications to a [FHeaderStyle].
sealed class FHeaderStyleDelta with Delta<FHeaderStyle> {
  /// Creates a complete replacement for a [FHeaderStyle].
  const factory FHeaderStyleDelta.replace(FHeaderStyle replacement) = _FHeaderStyleReplace;

  /// Creates a partial modification of a [FHeaderStyle].
  const factory FHeaderStyleDelta.merge({
    SystemUiOverlayStyle? systemOverlayStyle,
    BoxDecorationDelta? decoration,
    ImageFilter? Function()? backgroundFilter,
    EdgeInsetsGeometry? padding,
    double? actionSpacing,
    TextStyleDelta? titleTextStyle,
    FHeaderActionStyleDelta? actionStyle,
  }) = _FHeaderStyleMerge;
}

class _FHeaderStyleReplace implements FHeaderStyleDelta {
  const _FHeaderStyleReplace(this._replacement);

  final FHeaderStyle _replacement;

  @override
  FHeaderStyle call(FHeaderStyle _) => _replacement;
}

class _FHeaderStyleMerge implements FHeaderStyleDelta {
  const _FHeaderStyleMerge({
    this.systemOverlayStyle,
    this.decoration,
    this.backgroundFilter,
    this.padding,
    this.actionSpacing,
    this.titleTextStyle,
    this.actionStyle,
  });

  final SystemUiOverlayStyle? systemOverlayStyle;

  final BoxDecorationDelta? decoration;

  final ImageFilter? Function()? backgroundFilter;

  final EdgeInsetsGeometry? padding;

  final double? actionSpacing;

  final TextStyleDelta? titleTextStyle;

  final FHeaderActionStyleDelta? actionStyle;

  @override
  FHeaderStyle call(FHeaderStyle original) => FHeaderStyle(
    systemOverlayStyle: systemOverlayStyle ?? original.systemOverlayStyle,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    backgroundFilter: backgroundFilter == null ? original.backgroundFilter : backgroundFilter!(),
    padding: padding ?? original.padding,
    actionSpacing: actionSpacing ?? original.actionSpacing,
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    actionStyle: actionStyle?.call(original.actionStyle) ?? original.actionStyle,
  );
}

/// Provides [copyWith] and [lerp] methods.
extension $FHeaderActionStyleTransformations on FHeaderActionStyle {
  /// Returns a copy of this [FHeaderActionStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FHeaderActionStyle.iconStyle] - The icon's style.
  /// * [FHeaderActionStyle.focusedOutlineStyle] - The outline style when this action is focused.
  /// * [FHeaderActionStyle.tappableStyle] - The tappable's style.
  @useResult
  FHeaderActionStyle copyWith({
    FWidgetStateMap<IconThemeData>? iconStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
  }) => .new(
    iconStyle: iconStyle ?? this.iconStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
  );

  /// Linearly interpolate between this and another [FHeaderActionStyle] using the given factor [t].
  @useResult
  FHeaderActionStyle lerp(FHeaderActionStyle other, double t) => .new(
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
  );
}

mixin _$FHeaderActionStyleFunctions on Diagnosticable {
  FWidgetStateMap<IconThemeData> get iconStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FTappableStyle get tappableStyle;

  /// Returns itself.
  ///
  /// Allows [FHeaderActionStyle] to replace functions that accept and return a [FHeaderActionStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FHeaderActionStyle Function(FHeaderActionStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FHeaderActionStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FHeaderActionStyle(...));
  /// ```
  @useResult
  FHeaderActionStyle call(Object? _) => this as FHeaderActionStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderActionStyle &&
          runtimeType == other.runtimeType &&
          iconStyle == other.iconStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          tappableStyle == other.tappableStyle);

  @override
  int get hashCode => iconStyle.hashCode ^ focusedOutlineStyle.hashCode ^ tappableStyle.hashCode;
}

/// A delta that applies modifications to a [FHeaderActionStyle].
sealed class FHeaderActionStyleDelta with Delta<FHeaderActionStyle> {
  /// Creates a complete replacement for a [FHeaderActionStyle].
  const factory FHeaderActionStyleDelta.replace(FHeaderActionStyle replacement) = _FHeaderActionStyleReplace;

  /// Creates a partial modification of a [FHeaderActionStyle].
  const factory FHeaderActionStyleDelta.merge({
    FWidgetStateMap<IconThemeData>? iconStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FTappableStyleDelta? tappableStyle,
  }) = _FHeaderActionStyleMerge;
}

class _FHeaderActionStyleReplace implements FHeaderActionStyleDelta {
  const _FHeaderActionStyleReplace(this._replacement);

  final FHeaderActionStyle _replacement;

  @override
  FHeaderActionStyle call(FHeaderActionStyle _) => _replacement;
}

class _FHeaderActionStyleMerge implements FHeaderActionStyleDelta {
  const _FHeaderActionStyleMerge({this.iconStyle, this.focusedOutlineStyle, this.tappableStyle});

  final FWidgetStateMap<IconThemeData>? iconStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final FTappableStyleDelta? tappableStyle;

  @override
  FHeaderActionStyle call(FHeaderActionStyle original) => FHeaderActionStyle(
    iconStyle: iconStyle ?? original.iconStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
  );
}
