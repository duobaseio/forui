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
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSidebarStyle.decoration] - The decoration.
  /// * [FSidebarStyle.groupStyle] - The group's style.
  /// * [FSidebarStyle.constraints] - The sidebar's width.
  /// * [FSidebarStyle.backgroundFilter] - An optional background filter applied to the sidebar.
  /// * [FSidebarStyle.headerPadding] - The padding for the header section.
  /// * [FSidebarStyle.contentPadding] - The padding for the content section.
  /// * [FSidebarStyle.footerPadding] - The padding for the footer section.
  @useResult
  FSidebarStyle copyWith({
    DecorationDelta? decoration,
    FSidebarGroupStyleDelta? groupStyle,
    BoxConstraints? constraints,
    ImageFilter? backgroundFilter = Sentinels.imageFilter,
    EdgeInsetsGeometryDelta? headerPadding,
    EdgeInsetsGeometryDelta? contentPadding,
    EdgeInsetsGeometryDelta? footerPadding,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    groupStyle: groupStyle?.call(this.groupStyle) ?? this.groupStyle,
    constraints: constraints ?? this.constraints,
    backgroundFilter: backgroundFilter == Sentinels.imageFilter ? this.backgroundFilter : backgroundFilter,
    headerPadding: headerPadding?.call(this.headerPadding) ?? this.headerPadding,
    contentPadding: contentPadding?.call(this.contentPadding) ?? this.contentPadding,
    footerPadding: footerPadding?.call(this.footerPadding) ?? this.footerPadding,
  );

  /// Linearly interpolate between this and another [FSidebarStyle] using the given factor [t].
  @useResult
  FSidebarStyle lerp(FSidebarStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    groupStyle: groupStyle.lerp(other.groupStyle, t),
    constraints: .lerp(constraints, other.constraints, t) ?? constraints,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    headerPadding: .lerp(headerPadding, other.headerPadding, t) ?? headerPadding,
    contentPadding: .lerp(contentPadding, other.contentPadding, t) ?? contentPadding,
    footerPadding: .lerp(footerPadding, other.footerPadding, t) ?? footerPadding,
  );
}

mixin _$FSidebarStyleFunctions on Diagnosticable implements FSidebarStyleDelta {
  /// Returns itself.
  @override
  FSidebarStyle call(Object _) => this as FSidebarStyle;

  Decoration get decoration;
  FSidebarGroupStyle get groupStyle;
  BoxConstraints get constraints;
  ImageFilter? get backgroundFilter;
  EdgeInsetsGeometry get headerPadding;
  EdgeInsetsGeometry get contentPadding;
  EdgeInsetsGeometry get footerPadding;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('groupStyle', groupStyle, level: .debug))
      ..add(DiagnosticsProperty('constraints', constraints, level: .debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: .debug))
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
          groupStyle == other.groupStyle &&
          constraints == other.constraints &&
          backgroundFilter == other.backgroundFilter &&
          headerPadding == other.headerPadding &&
          contentPadding == other.contentPadding &&
          footerPadding == other.footerPadding);

  @override
  int get hashCode =>
      decoration.hashCode ^
      groupStyle.hashCode ^
      constraints.hashCode ^
      backgroundFilter.hashCode ^
      headerPadding.hashCode ^
      contentPadding.hashCode ^
      footerPadding.hashCode;
}

/// A delta that applies modifications to a [FSidebarStyle].
///
/// A [FSidebarStyle] is itself a [FSidebarStyleDelta].
abstract class FSidebarStyleDelta with Delta {
  /// Creates a partial modification of a [FSidebarStyle].
  ///
  /// ## Parameters
  /// * [FSidebarStyle.decoration] - The decoration.
  /// * [FSidebarStyle.groupStyle] - The group's style.
  /// * [FSidebarStyle.constraints] - The sidebar's width.
  /// * [FSidebarStyle.backgroundFilter] - An optional background filter applied to the sidebar.
  /// * [FSidebarStyle.headerPadding] - The padding for the header section.
  /// * [FSidebarStyle.contentPadding] - The padding for the content section.
  /// * [FSidebarStyle.footerPadding] - The padding for the footer section.
  const factory delta({
    DecorationDelta? decoration,
    FSidebarGroupStyleDelta? groupStyle,
    BoxConstraints? constraints,
    ImageFilter? backgroundFilter,
    EdgeInsetsGeometryDelta? headerPadding,
    EdgeInsetsGeometryDelta? contentPadding,
    EdgeInsetsGeometryDelta? footerPadding,
  }) = _FSidebarStyleDelta;

  /// Creates a delta that returns the [FSidebarStyle] in the current context.
  const factory context() = _FSidebarStyleContext;

  @override
  FSidebarStyle call(covariant FSidebarStyle value);
}

class _FSidebarStyleDelta implements FSidebarStyleDelta {
  const new({
    this.decoration,
    this.groupStyle,
    this.constraints,
    this.backgroundFilter = Sentinels.imageFilter,
    this.headerPadding,
    this.contentPadding,
    this.footerPadding,
  });

  final DecorationDelta? decoration;

  final FSidebarGroupStyleDelta? groupStyle;

  final BoxConstraints? constraints;

  final ImageFilter? backgroundFilter;

  final EdgeInsetsGeometryDelta? headerPadding;

  final EdgeInsetsGeometryDelta? contentPadding;

  final EdgeInsetsGeometryDelta? footerPadding;

  @override
  FSidebarStyle call(FSidebarStyle original) => FSidebarStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    groupStyle: groupStyle?.call(original.groupStyle) ?? original.groupStyle,
    constraints: constraints ?? original.constraints,
    backgroundFilter: backgroundFilter == Sentinels.imageFilter ? original.backgroundFilter : backgroundFilter,
    headerPadding: headerPadding?.call(original.headerPadding) ?? original.headerPadding,
    contentPadding: contentPadding?.call(original.contentPadding) ?? original.contentPadding,
    footerPadding: footerPadding?.call(original.footerPadding) ?? original.footerPadding,
  );
}

class _FSidebarStyleContext implements FSidebarStyleDelta {
  const new();

  @override
  FSidebarStyle call(FSidebarStyle original) => original;
}
