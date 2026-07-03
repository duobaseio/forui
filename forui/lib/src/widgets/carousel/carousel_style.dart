import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'carousel_style.design.dart';

/// The [FCarousel] style.
class FCarouselStyle with Diagnosticable, _$FCarouselStyleFunctions {
  /// The carousel's height. Defaults to `88`.
  @override
  final double height;

  /// The padding around the carousel. Defaults to `EdgeInsets.fromLTRB(8, 6, 8, 0)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The carousel's border radius. Defaults to `BorderRadius.circular(12)`.
  @override
  final BorderRadiusGeometry borderRadius;

  /// The indicator's padding from the bottom edge. Defaults to `EdgeInsets.only(bottom: 8)`.
  @override
  final EdgeInsetsGeometry indicatorPadding;

  /// The spacing between indicator dots. Defaults to `3`.
  @override
  final double indicatorSpacing;

  /// The inactive indicator dot's width. Defaults to `5`.
  @override
  final double indicatorDotWidth;

  /// The active indicator dot's width. Defaults to `16`.
  @override
  final double indicatorActiveDotWidth;

  /// The indicator dot's height. Defaults to `5`.
  @override
  final double indicatorDotHeight;

  /// The active indicator dot's color. Defaults to `Colors.white`.
  @override
  final Color indicatorActiveColor;

  /// The inactive indicator dot's color. Defaults to `Color(0x73FFFFFF)`.
  @override
  final Color indicatorInactiveColor;

  /// The indicator dot's shadow. Defaults to `BoxShadow(blurRadius: 4, color: Color(0x42000000))`.
  @override
  final BoxShadow indicatorShadow;

  /// The indicator dot's tappable style.
  @override
  final FTappableStyle indicatorTappableStyle;

  /// The padding applied around each navigation control. Defaults to `EdgeInsets.symmetric(horizontal: 4)`.
  @override
  final EdgeInsetsGeometry controlPadding;

  /// The navigation control's constraints.
  @override
  final BoxConstraints controlConstraints;

  /// The navigation control icon's style.
  @override
  final IconThemeData controlIconStyle;

  /// The navigation control's decoration.
  @override
  final Decoration controlDecoration;

  /// The navigation control's tappable style.
  @override
  final FTappableStyle controlTappableStyle;

  /// Creates a [FCarouselStyle].
  FCarouselStyle({
    required this.indicatorTappableStyle,
    required this.controlIconStyle,
    required this.controlDecoration,
    required this.controlTappableStyle,
    this.height = 88,
    this.padding = const .fromLTRB(8, 6, 8, 0),
    this.borderRadius = const .all(.circular(12)),
    this.indicatorPadding = const .only(bottom: 8),
    this.indicatorSpacing = 3,
    this.indicatorDotWidth = 5,
    this.indicatorActiveDotWidth = 16,
    this.indicatorDotHeight = 5,
    this.indicatorActiveColor = const Color(0xFFFFFFFF),
    this.indicatorInactiveColor = const Color(0x73FFFFFF),
    this.indicatorShadow = const BoxShadow(blurRadius: 4, color: Color(0x42000000)),
    this.controlPadding = const .symmetric(horizontal: 4),
    this.controlConstraints = const .tightFor(width: 32, height: 32),
  });

  /// Creates a [FCarouselStyle] that inherits its properties.
  FCarouselStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) : this(
         indicatorTappableStyle: style.tappableStyle,
         controlTappableStyle: style.tappableStyle,
         borderRadius: style.borderRadius.md,
         indicatorActiveColor: colors.background,
         indicatorInactiveColor: colors.background.withValues(alpha: 0.45),
         indicatorDotHeight: touch ? 6 : 5,
         indicatorDotWidth: touch ? 6 : 5,
         indicatorActiveDotWidth: touch ? 18 : 16,
         controlIconStyle: IconThemeData(color: colors.background, size: typography.body.md.fontSize),
         controlDecoration: ShapeDecoration(shape: const CircleBorder(), color: colors.foreground.withValues(alpha: 0.35)),
         controlConstraints: touch ? const .tightFor(width: 44, height: 44) : const .tightFor(width: 32, height: 32),
       );
}
