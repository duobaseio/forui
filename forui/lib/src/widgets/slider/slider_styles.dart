import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FSliderAxis', {'vertical': (1, 'The vertical slider variant.')})
@Variants('FSlider', {
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
})
part 'slider_styles.design.dart';

/// A slider's styles.
extension type FSliderStyles(
  FVariants<FSliderAxisVariantConstraint, FSliderAxisVariant, FSliderStyle, FSliderStyleDelta> _
)
    implements FVariants<FSliderAxisVariantConstraint, FSliderAxisVariant, FSliderStyle, FSliderStyleDelta> {
  /// Creates a [FSliderStyles] that inherits its properties.
  FSliderStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        .from(
          .inherit(
            colors: colors,
            typography: typography,
            style: style,
            labelAnchor: .topCenter,
            labelOffset: 10,
            descriptionPadding: const .only(top: 10),
            childPadding: const .only(top: 10, bottom: 20, left: 10, right: 10),
          ),
          variants: {
            [.touch]: const .delta(thumbSize: 25),
            [.vertical]: const .delta(
              markStyle: .delta(labelAnchor: .centerRight, labelOffset: -10),
              tooltipTipAnchor: .centerLeft,
              tooltipThumbAnchor: .centerRight,
              descriptionPadding: .only(top: 5),
              childPadding: .all(10),
            ),
            [.vertical.and(.touch)]: const .delta(
              markStyle: .delta(labelAnchor: .centerRight, labelOffset: -10),
              tooltipTipAnchor: .bottomCenter,
              tooltipThumbAnchor: .topCenter,
              thumbSize: 25,
              descriptionPadding: .only(top: 5),
              childPadding: .all(10),
            ),
          },
        ),
      );

  /// The horizontal slider style.
  FSliderStyle get horizontal => base;

  /// The vertical slider style.
  FSliderStyle get vertical => resolve({FSliderAxisVariant.vertical});
}

/// A slider's style.
class FSliderStyle extends FLabelStyle with _$FSliderStyleFunctions {
  /// The slider's active track colors.
  @override
  final FVariants<FSliderVariantConstraint, FSliderVariant, Color, Delta> activeColor;

  /// The slider's inactive track colors.
  @override
  final FVariants<FSliderVariantConstraint, FSliderVariant, Color, Delta> inactiveColor;

  /// The slider's border radius.
  @override
  final BorderRadius borderRadius;

  /// The slider's cross-axis extent. Defaults to 8.
  ///
  /// ## Contract:
  /// Throws [AssertionError] if it is not positive.
  @override
  final double crossAxisExtent;

  /// The thumb's size. Defaults to `25` on primarily touch devices and `20` on non-primarily touch devices.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [thumbSize] is not positive.
  ///
  /// ## Implementation details
  /// This unfortunately has to be placed outside of FSliderThumbStyle because [FSliderThumbStyle] is inside
  /// [FSliderStyle]. Putting the thumb size inside [FSliderThumbStyle] will cause a cyclic rebuild to occur
  /// whenever the window is resized due to a bad interaction between an internal LayoutBuilder and SliderFormField.
  @override
  final double thumbSize;

  /// The slider thumb's style.
  @override
  final FSliderThumbStyle thumbStyle;

  /// The slider marks' style.
  @override
  final FSliderMarkStyle markStyle;

  /// The tooltip's style.
  @override
  final FTooltipStyle tooltipStyle;

  /// The tooltip's motion-related properties.
  @override
  final FTooltipMotion tooltipMotion;

  /// The anchor of the tooltip to which the [tooltipThumbAnchor] is aligned.
  ///
  /// Defaults to [Alignment.bottomCenter] on primarily touch devices and [Alignment.centerLeft] on non-primarily touch
  /// devices.
  @override
  final AlignmentGeometry tooltipTipAnchor;

  /// The anchor of the thumb to which the [tooltipTipAnchor] is aligned.
  ///
  /// Defaults to [Alignment.topCenter] on primarily touch devices and [Alignment.centerRight] on non-primarily touch
  /// devices.
  @override
  final AlignmentGeometry tooltipThumbAnchor;

  /// Creates a [FSliderStyle].
  const FSliderStyle({
    required this.activeColor,
    required this.inactiveColor,
    required this.thumbStyle,
    required this.markStyle,
    required this.tooltipStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.borderRadius = const .all(.circular(4)),
    this.crossAxisExtent = 8,
    this.thumbSize = 20,
    this.tooltipMotion = const FTooltipMotion(),
    this.tooltipTipAnchor = .bottomCenter,
    this.tooltipThumbAnchor = .topCenter,
    super.labelPadding = const .only(bottom: 5),
    super.descriptionPadding,
    super.errorPadding = const .only(top: 5),
    super.childPadding,
    super.labelMotion,
  }) : assert(0 < thumbSize, 'thumbSize must be > 0');

  /// Creates a [FSliderStyle] that inherits its properties.
  FSliderStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required AlignmentGeometry labelAnchor,
    required double labelOffset,
    required EdgeInsetsGeometry descriptionPadding,
    required EdgeInsetsGeometry childPadding,
    AlignmentGeometry tooltipTipAnchor = .bottomCenter,
    AlignmentGeometry tooltipThumbAnchor = .topCenter,
  }) : this(
         activeColor: FVariants(
           colors.primary,
           variants: {
             [.disabled]: colors.disable(colors.primary),
           },
         ),
         inactiveColor: .all(colors.secondary),
         thumbStyle: FSliderThumbStyle(
           color: .all(colors.primaryForeground),
           borderColor: FVariants(
             colors.primary,
             variants: {
               [.disabled]: colors.disable(colors.primary),
             },
           ),
           focusedOutlineStyle: style.focusedOutlineStyle,
         ),
         markStyle: FSliderMarkStyle(
           tickColor: .all(colors.mutedForeground),
           labelTextStyle: .all(typography.xs.copyWith(color: colors.mutedForeground)),
           labelAnchor: labelAnchor,
           labelOffset: labelOffset,
         ),
         tooltipStyle: .inherit(colors: colors, typography: typography, style: style),
         tooltipTipAnchor: tooltipTipAnchor,
         tooltipThumbAnchor: tooltipThumbAnchor,
         labelTextStyle: style.formFieldStyle.labelTextStyle,
         descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
         errorTextStyle: style.formFieldStyle.errorTextStyle,
         descriptionPadding: descriptionPadding,
         childPadding: childPadding,
       );
}
