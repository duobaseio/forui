// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSidebarStyleTransformations on FSidebarStyle {
  /// Returns a copy of this [FSidebarStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSidebarStyle.decoration] - The decoration.
  /// * [FSidebarStyle.backgroundFilter] - An optional background filter applied to the sidebar.
  /// * [FSidebarStyle.constraints] - The sidebar's width.
  /// * [FSidebarStyle.groupStyle] - The group's style.
  /// * [FSidebarStyle.headerPadding] - The padding for the header section.
  /// * [FSidebarStyle.contentPadding] - The padding for the content section.
  /// * [FSidebarStyle.footerPadding] - The padding for the footer section.
  @useResult
  FSidebarStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    BoxConstraints? constraints,
    FSidebarGroupStyle Function(FSidebarGroupStyle style)? groupStyle,
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? footerPadding,
  }) => .new(
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    constraints: constraints ?? this.constraints,
    groupStyle: groupStyle != null ? groupStyle(this.groupStyle) : this.groupStyle,
    headerPadding: headerPadding ?? this.headerPadding,
    contentPadding: contentPadding ?? this.contentPadding,
    footerPadding: footerPadding ?? this.footerPadding,
  );

  /// Linearly interpolate between this and another [FSidebarStyle] using the given factor [t].
  @useResult
  FSidebarStyle lerp(FSidebarStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    constraints: .lerp(constraints, other.constraints, t) ?? constraints,
    groupStyle: groupStyle.lerp(other.groupStyle, t),
    headerPadding: .lerp(headerPadding, other.headerPadding, t) ?? headerPadding,
    contentPadding: .lerp(contentPadding, other.contentPadding, t) ?? contentPadding,
    footerPadding: .lerp(footerPadding, other.footerPadding, t) ?? footerPadding,
  );
}

mixin _$FSidebarStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  ImageFilter? get backgroundFilter;
  BoxConstraints get constraints;
  FSidebarGroupStyle get groupStyle;
  EdgeInsetsGeometry get headerPadding;
  EdgeInsetsGeometry get contentPadding;
  EdgeInsetsGeometry get footerPadding;

  /// Returns itself.
  ///
  /// Allows [FSidebarStyle] to replace functions that accept and return a [FSidebarStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSidebarStyle Function(FSidebarStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSidebarStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSidebarStyle(...));
  /// ```
  @useResult
  FSidebarStyle call(Object? _) => this as FSidebarStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: .debug))
      ..add(DiagnosticsProperty('constraints', constraints, level: .debug))
      ..add(DiagnosticsProperty('groupStyle', groupStyle, level: .debug))
      ..add(DiagnosticsProperty('headerPadding', headerPadding, level: .debug))
      ..add(DiagnosticsProperty('contentPadding', contentPadding, level: .debug))
      ..add(DiagnosticsProperty('footerPadding', footerPadding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          constraints == other.constraints &&
          groupStyle == other.groupStyle &&
          headerPadding == other.headerPadding &&
          contentPadding == other.contentPadding &&
          footerPadding == other.footerPadding);

  @override
  int get hashCode =>
      decoration.hashCode ^
      backgroundFilter.hashCode ^
      constraints.hashCode ^
      groupStyle.hashCode ^
      headerPadding.hashCode ^
      contentPadding.hashCode ^
      footerPadding.hashCode;
}

/// A delta that applies modifications to a [FSidebarStyle].
sealed class FSidebarStyleDelta with Delta<FSidebarStyle> {
  /// Creates a complete replacement for a [FSidebarStyle].
  const factory FSidebarStyleDelta.replace(FSidebarStyle replacement) = _FSidebarStyleReplace;

  /// Creates a partial modification of a [FSidebarStyle].
  const factory FSidebarStyleDelta.merge({
    BoxDecorationDelta? decoration,
    ImageFilter? Function()? backgroundFilter,
    BoxConstraints? constraints,
    FSidebarGroupStyleDelta? groupStyle,
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? footerPadding,
  }) = _FSidebarStyleMerge;
}

class _FSidebarStyleReplace implements FSidebarStyleDelta {
  const _FSidebarStyleReplace(this._replacement);

  final FSidebarStyle _replacement;

  @override
  FSidebarStyle call(FSidebarStyle _) => _replacement;
}

class _FSidebarStyleMerge implements FSidebarStyleDelta {
  const _FSidebarStyleMerge({
    this.decoration,
    this.backgroundFilter,
    this.constraints,
    this.groupStyle,
    this.headerPadding,
    this.contentPadding,
    this.footerPadding,
  });

  final BoxDecorationDelta? decoration;

  final ImageFilter? Function()? backgroundFilter;

  final BoxConstraints? constraints;

  final FSidebarGroupStyleDelta? groupStyle;

  final EdgeInsetsGeometry? headerPadding;

  final EdgeInsetsGeometry? contentPadding;

  final EdgeInsetsGeometry? footerPadding;

  @override
  FSidebarStyle call(FSidebarStyle original) => FSidebarStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    backgroundFilter: backgroundFilter == null ? original.backgroundFilter : backgroundFilter!(),
    constraints: constraints ?? original.constraints,
    groupStyle: groupStyle?.call(original.groupStyle) ?? original.groupStyle,
    headerPadding: headerPadding ?? original.headerPadding,
    contentPadding: contentPadding ?? original.contentPadding,
    footerPadding: footerPadding ?? original.footerPadding,
  );
}
