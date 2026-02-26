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
  /// * [FSidebarStyle.backgroundFilter] - An optional background filter applied to the sidebar.
  /// * [FSidebarStyle.constraints] - The sidebar's width.
  /// * [FSidebarStyle.groupStyle] - The group's style.
  /// * [FSidebarStyle.headerPadding] - The padding for the header section.
  /// * [FSidebarStyle.contentPadding] - The padding for the content section.
  /// * [FSidebarStyle.footerPadding] - The padding for the footer section.
  @useResult
  FSidebarStyle copyWith({
    DecorationDelta? decoration,
    ImageFilter? backgroundFilter = imageFilterSentinel,
    BoxConstraints? constraints,
    FSidebarGroupStyleDelta? groupStyle,
    EdgeInsetsGeometryDelta? headerPadding,
    EdgeInsetsGeometryDelta? contentPadding,
    EdgeInsetsGeometryDelta? footerPadding,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    backgroundFilter: backgroundFilter == imageFilterSentinel ? this.backgroundFilter : backgroundFilter,
    constraints: constraints ?? this.constraints,
    groupStyle: groupStyle?.call(this.groupStyle) ?? this.groupStyle,
    headerPadding: headerPadding?.call(this.headerPadding) ?? this.headerPadding,
    contentPadding: contentPadding?.call(this.contentPadding) ?? this.contentPadding,
    footerPadding: footerPadding?.call(this.footerPadding) ?? this.footerPadding,
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

mixin _$FSidebarStyleFunctions on Diagnosticable implements FSidebarStyleDelta {
  /// Returns itself.
  @override
  FSidebarStyle call(Object _) => this as FSidebarStyle;

  Decoration get decoration;
  ImageFilter? get backgroundFilter;
  BoxConstraints get constraints;
  FSidebarGroupStyle get groupStyle;
  EdgeInsetsGeometry get headerPadding;
  EdgeInsetsGeometry get contentPadding;
  EdgeInsetsGeometry get footerPadding;
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
///
/// A [FSidebarStyle] is itself a [FSidebarStyleDelta].
abstract class FSidebarStyleDelta with Delta {
  /// Creates a partial modification of a [FSidebarStyle].
  ///
  /// ## Parameters
  /// * [FSidebarStyle.decoration] - The decoration.
  /// * [FSidebarStyle.backgroundFilter] - An optional background filter applied to the sidebar.
  /// * [FSidebarStyle.constraints] - The sidebar's width.
  /// * [FSidebarStyle.groupStyle] - The group's style.
  /// * [FSidebarStyle.headerPadding] - The padding for the header section.
  /// * [FSidebarStyle.contentPadding] - The padding for the content section.
  /// * [FSidebarStyle.footerPadding] - The padding for the footer section.
  const factory FSidebarStyleDelta.delta({
    DecorationDelta? decoration,
    ImageFilter? backgroundFilter,
    BoxConstraints? constraints,
    FSidebarGroupStyleDelta? groupStyle,
    EdgeInsetsGeometryDelta? headerPadding,
    EdgeInsetsGeometryDelta? contentPadding,
    EdgeInsetsGeometryDelta? footerPadding,
  }) = _FSidebarStyleDelta;

  /// Creates a delta that returns the [FSidebarStyle] in the current context.
  const factory FSidebarStyleDelta.context() = _FSidebarStyleContext;

  @override
  FSidebarStyle call(covariant FSidebarStyle value);
}

class _FSidebarStyleDelta implements FSidebarStyleDelta {
  const _FSidebarStyleDelta({
    this.decoration,
    this.backgroundFilter = imageFilterSentinel,
    this.constraints,
    this.groupStyle,
    this.headerPadding,
    this.contentPadding,
    this.footerPadding,
  });

  final DecorationDelta? decoration;

  final ImageFilter? backgroundFilter;

  final BoxConstraints? constraints;

  final FSidebarGroupStyleDelta? groupStyle;

  final EdgeInsetsGeometryDelta? headerPadding;

  final EdgeInsetsGeometryDelta? contentPadding;

  final EdgeInsetsGeometryDelta? footerPadding;

  @override
  FSidebarStyle call(FSidebarStyle original) => FSidebarStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    backgroundFilter: backgroundFilter == imageFilterSentinel ? original.backgroundFilter : backgroundFilter,
    constraints: constraints ?? original.constraints,
    groupStyle: groupStyle?.call(original.groupStyle) ?? original.groupStyle,
    headerPadding: headerPadding?.call(original.headerPadding) ?? original.headerPadding,
    contentPadding: contentPadding?.call(original.contentPadding) ?? original.contentPadding,
    footerPadding: footerPadding?.call(original.footerPadding) ?? original.footerPadding,
  );
}

class _FSidebarStyleContext implements FSidebarStyleDelta {
  const _FSidebarStyleContext();

  @override
  FSidebarStyle call(FSidebarStyle original) => original;
}
