// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'scaffold.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FScaffoldStyleTransformations on FScaffoldStyle {
  /// Returns a copy of this [FScaffoldStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FScaffoldStyle.systemOverlayStyle] - The fallback system overlay style.
  /// * [FScaffoldStyle.backgroundColor] - The background color.
  /// * [FScaffoldStyle.sidebarBackgroundColor] - The sidebar background color.
  /// * [FScaffoldStyle.childPadding] - The child padding.
  /// * [FScaffoldStyle.footerDecoration] - The footer decoration.
  /// * [FScaffoldStyle.headerDecoration] - The header decoration.
  @useResult
  FScaffoldStyle copyWith({
    SystemUiOverlayStyle? systemOverlayStyle,
    Color? backgroundColor,
    Color? sidebarBackgroundColor,
    EdgeInsetsGeometryDelta? childPadding,
    DecorationDelta? footerDecoration,
    DecorationDelta? headerDecoration,
  }) => .new(
    systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    sidebarBackgroundColor: sidebarBackgroundColor ?? this.sidebarBackgroundColor,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    footerDecoration: footerDecoration?.call(this.footerDecoration) ?? this.footerDecoration,
    headerDecoration: headerDecoration?.call(this.headerDecoration) ?? this.headerDecoration,
  );

  /// Linearly interpolate between this and another [FScaffoldStyle] using the given factor [t].
  @useResult
  FScaffoldStyle lerp(FScaffoldStyle other, double t) => .new(
    systemOverlayStyle: t < 0.5 ? systemOverlayStyle : other.systemOverlayStyle,
    backgroundColor: FColors.lerpColor(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
    sidebarBackgroundColor:
        FColors.lerpColor(sidebarBackgroundColor, other.sidebarBackgroundColor, t) ?? sidebarBackgroundColor,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    footerDecoration: .lerp(footerDecoration, other.footerDecoration, t) ?? footerDecoration,
    headerDecoration: .lerp(headerDecoration, other.headerDecoration, t) ?? headerDecoration,
  );
}

mixin _$FScaffoldStyleFunctions on Diagnosticable implements FScaffoldStyleDelta {
  /// Returns itself.
  @override
  FScaffoldStyle call(Object _) => this as FScaffoldStyle;

  SystemUiOverlayStyle get systemOverlayStyle;
  Color get backgroundColor;
  Color get sidebarBackgroundColor;
  EdgeInsetsGeometry get childPadding;
  Decoration get footerDecoration;
  Decoration get headerDecoration;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('systemOverlayStyle', systemOverlayStyle, level: .debug))
      ..add(ColorProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(ColorProperty('sidebarBackgroundColor', sidebarBackgroundColor, level: .debug))
      ..add(DiagnosticsProperty('childPadding', childPadding, level: .debug))
      ..add(DiagnosticsProperty('footerDecoration', footerDecoration, level: .debug))
      ..add(DiagnosticsProperty('headerDecoration', headerDecoration, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FScaffoldStyle &&
          runtimeType == other.runtimeType &&
          systemOverlayStyle == other.systemOverlayStyle &&
          backgroundColor == other.backgroundColor &&
          sidebarBackgroundColor == other.sidebarBackgroundColor &&
          childPadding == other.childPadding &&
          footerDecoration == other.footerDecoration &&
          headerDecoration == other.headerDecoration);

  @override
  int get hashCode =>
      systemOverlayStyle.hashCode ^
      backgroundColor.hashCode ^
      sidebarBackgroundColor.hashCode ^
      childPadding.hashCode ^
      footerDecoration.hashCode ^
      headerDecoration.hashCode;
}

/// A delta that applies modifications to a [FScaffoldStyle].
///
/// A [FScaffoldStyle] is itself a [FScaffoldStyleDelta].
abstract class FScaffoldStyleDelta with Delta {
  /// Creates a partial modification of a [FScaffoldStyle].
  ///
  /// ## Parameters
  /// * [FScaffoldStyle.systemOverlayStyle] - The fallback system overlay style.
  /// * [FScaffoldStyle.backgroundColor] - The background color.
  /// * [FScaffoldStyle.sidebarBackgroundColor] - The sidebar background color.
  /// * [FScaffoldStyle.childPadding] - The child padding.
  /// * [FScaffoldStyle.footerDecoration] - The footer decoration.
  /// * [FScaffoldStyle.headerDecoration] - The header decoration.
  const factory delta({
    SystemUiOverlayStyle? systemOverlayStyle,
    Color? backgroundColor,
    Color? sidebarBackgroundColor,
    EdgeInsetsGeometryDelta? childPadding,
    DecorationDelta? footerDecoration,
    DecorationDelta? headerDecoration,
  }) = _FScaffoldStyleDelta;

  /// Creates a delta that returns the [FScaffoldStyle] in the current context.
  const factory context() = _FScaffoldStyleContext;

  @override
  FScaffoldStyle call(covariant FScaffoldStyle value);
}

class _FScaffoldStyleDelta implements FScaffoldStyleDelta {
  const new({
    this.systemOverlayStyle,
    this.backgroundColor,
    this.sidebarBackgroundColor,
    this.childPadding,
    this.footerDecoration,
    this.headerDecoration,
  });

  final SystemUiOverlayStyle? systemOverlayStyle;

  final Color? backgroundColor;

  final Color? sidebarBackgroundColor;

  final EdgeInsetsGeometryDelta? childPadding;

  final DecorationDelta? footerDecoration;

  final DecorationDelta? headerDecoration;

  @override
  FScaffoldStyle call(FScaffoldStyle original) => FScaffoldStyle(
    systemOverlayStyle: systemOverlayStyle ?? original.systemOverlayStyle,
    backgroundColor: backgroundColor ?? original.backgroundColor,
    sidebarBackgroundColor: sidebarBackgroundColor ?? original.sidebarBackgroundColor,
    childPadding: childPadding?.call(original.childPadding) ?? original.childPadding,
    footerDecoration: footerDecoration?.call(original.footerDecoration) ?? original.footerDecoration,
    headerDecoration: headerDecoration?.call(original.headerDecoration) ?? original.headerDecoration,
  );
}

class _FScaffoldStyleContext implements FScaffoldStyleDelta {
  const new();

  @override
  FScaffoldStyle call(FScaffoldStyle original) => original;
}
