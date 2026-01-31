// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select_menu_tile.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectMenuTileStyleTransformations on FSelectMenuTileStyle {
  /// Returns a copy of this [FSelectMenuTileStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectMenuTileStyle.menuStyle] - The menu's style.
  /// * [FSelectMenuTileStyle.tileStyle] - The tile's style.
  /// * [FSelectMenuTileStyle.labelPadding] - The label's padding.
  /// * [FSelectMenuTileStyle.descriptionPadding] - The description's padding.
  /// * [FSelectMenuTileStyle.errorPadding] - The error's padding.
  /// * [FSelectMenuTileStyle.childPadding] - The child's padding.
  /// * [FSelectMenuTileStyle.labelTextStyle] - The label's text style.
  /// * [FSelectMenuTileStyle.descriptionTextStyle] - The description's text style.
  /// * [FSelectMenuTileStyle.errorTextStyle] - The error's text style.
  @useResult
  FSelectMenuTileStyle copyWith({
    FPopoverMenuStyle Function(FPopoverMenuStyle style)? menuStyle,
    FTileStyle Function(FTileStyle style)? tileStyle,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => .new(
    menuStyle: menuStyle != null ? menuStyle(this.menuStyle) : this.menuStyle,
    tileStyle: tileStyle != null ? tileStyle(this.tileStyle) : this.tileStyle,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FSelectMenuTileStyle] using the given factor [t].
  @useResult
  FSelectMenuTileStyle lerp(FSelectMenuTileStyle other, double t) => .new(
    menuStyle: menuStyle.lerp(other.menuStyle, t),
    tileStyle: tileStyle.lerp(other.tileStyle, t),
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: .lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: .lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FSelectMenuTileStyleFunctions on Diagnosticable {
  FPopoverMenuStyle get menuStyle;
  FTileStyle get tileStyle;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FSelectMenuTileStyle] to replace functions that accept and return a [FSelectMenuTileStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSelectMenuTileStyle Function(FSelectMenuTileStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSelectMenuTileStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSelectMenuTileStyle(...));
  /// ```
  @useResult
  FSelectMenuTileStyle call(Object? _) => this as FSelectMenuTileStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('menuStyle', menuStyle, level: .debug))
      ..add(DiagnosticsProperty('tileStyle', tileStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectMenuTileStyle &&
          runtimeType == other.runtimeType &&
          menuStyle == other.menuStyle &&
          tileStyle == other.tileStyle &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      menuStyle.hashCode ^
      tileStyle.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FSelectMenuTileStyle].
sealed class FSelectMenuTileStyleDelta with Delta<FSelectMenuTileStyle> {
  /// Creates a complete replacement for a [FSelectMenuTileStyle].
  const factory FSelectMenuTileStyleDelta.replace(FSelectMenuTileStyle replacement) = _FSelectMenuTileStyleReplace;

  /// Creates a partial modification of a [FSelectMenuTileStyle].
  const factory FSelectMenuTileStyleDelta.merge({
    FPopoverMenuStyleDelta? menuStyle,
    FTileStyleDelta? tileStyle,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyleDelta? errorTextStyle,
  }) = _FSelectMenuTileStyleMerge;
}

class _FSelectMenuTileStyleReplace implements FSelectMenuTileStyleDelta {
  const _FSelectMenuTileStyleReplace(this._replacement);

  final FSelectMenuTileStyle _replacement;

  @override
  FSelectMenuTileStyle call(FSelectMenuTileStyle _) => _replacement;
}

class _FSelectMenuTileStyleMerge implements FSelectMenuTileStyleDelta {
  const _FSelectMenuTileStyleMerge({
    this.menuStyle,
    this.tileStyle,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final FPopoverMenuStyleDelta? menuStyle;

  final FTileStyleDelta? tileStyle;

  final EdgeInsetsGeometry? labelPadding;

  final EdgeInsetsGeometry? descriptionPadding;

  final EdgeInsetsGeometry? errorPadding;

  final EdgeInsetsGeometry? childPadding;

  final FWidgetStateMap<TextStyle>? labelTextStyle;

  final FWidgetStateMap<TextStyle>? descriptionTextStyle;

  final TextStyleDelta? errorTextStyle;

  @override
  FSelectMenuTileStyle call(FSelectMenuTileStyle original) => FSelectMenuTileStyle(
    menuStyle: menuStyle?.call(original.menuStyle) ?? original.menuStyle,
    tileStyle: tileStyle?.call(original.tileStyle) ?? original.tileStyle,
    labelPadding: labelPadding ?? original.labelPadding,
    descriptionPadding: descriptionPadding ?? original.descriptionPadding,
    errorPadding: errorPadding ?? original.errorPadding,
    childPadding: childPadding ?? original.childPadding,
    labelTextStyle: labelTextStyle ?? original.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? original.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(original.errorTextStyle) ?? original.errorTextStyle,
  );
}
