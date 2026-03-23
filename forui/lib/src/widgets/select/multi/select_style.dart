import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'select_style.design.dart';

/// A [FMultiSelect]'s style.
class FMultiSelectStyle with Diagnosticable, _$FMultiSelectStyleFunctions {
  /// The field's size styles.
  @override
  final FMultiSelectFieldSizeStyles fieldStyles;

  /// The search's style.
  @override
  final FSelectSearchStyle searchStyle;

  /// The content's style.
  @override
  final FSelectContentStyle contentStyle;

  /// The default text style when there are no results.
  @override
  final TextStyle emptyTextStyle;

  /// Creates a [FMultiSelectStyle].
  FMultiSelectStyle({
    required this.fieldStyles,
    required this.searchStyle,
    required this.contentStyle,
    required this.emptyTextStyle,
  });

  /// Creates a [FMultiSelectStyle] that inherits its properties.
  FMultiSelectStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) : this(
         fieldStyles: .inherit(colors: colors, typography: typography, style: style, touch: touch),
         searchStyle: .inherit(colors: colors, typography: typography, style: style, touch: touch),
         contentStyle: .inherit(colors: colors, typography: typography, style: style, touch: touch),
         emptyTextStyle: typography.sm,
       );
}

/// [FMultiSelectFieldStyle]'s size styles.
extension type FMultiSelectFieldSizeStyles(
  FVariants<FTextFieldSizeVariantConstraint, FTextFieldSizeVariant, FMultiSelectFieldStyle, FMultiSelectFieldStyleDelta>
  _
)
    implements
        FVariants<
          FTextFieldSizeVariantConstraint,
          FTextFieldSizeVariant,
          FMultiSelectFieldStyle,
          FMultiSelectFieldStyleDelta
        > {
  /// Creates a [FMultiSelectFieldSizeStyles] that inherits its properties.
  factory FMultiSelectFieldSizeStyles.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) {
    final label = FLabelStyles.inherit(style: style).verticalStyle;
    final textStyle = typography.sm;
    final iconStyle = FVariants<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta>.from(
      IconThemeData(color: colors.mutedForeground, size: typography.sm.fontSize),
      variants: {
        [.disabled]: .delta(color: colors.disable(colors.mutedForeground)),
      },
    );

    FMultiSelectFieldStyle field({
      required FButtonStyle buttonStyle,
      required EdgeInsetsGeometry contentPadding,
      required EdgeInsetsGeometry hintPadding,
      required EdgeInsetsGeometry tagPadding,
      required BorderRadiusGeometry tagBorderRadius,
    }) => FMultiSelectFieldStyle.inherit(
      colors: colors,
      style: style,
      labelStyle: label,
      textStyle: textStyle,
      iconStyle: iconStyle,
      clearButtonStyle: buttonStyle,
      contentPadding: contentPadding,
      hintPadding: hintPadding,
      tagStyle: .inherit(
        colors: colors,
        style: style,
        textStyle: typography.sm,
        padding: tagPadding,
        borderRadius: tagBorderRadius,
      ),
    );

    final ghost = FButtonStyles.inherit(colors: colors, typography: typography, style: style, touch: touch).ghost;
    final buttonStyle = ghost.sm.copyWith(
      iconContentStyle: ghost.sm.iconContentStyle.copyWith(iconStyle: iconStyle.cast()),
    );

    if (touch) {
      final md = field(
        buttonStyle: buttonStyle,
        contentPadding: const .directional(start: 12, end: 8, top: 4, bottom: 4),
        hintPadding: const .directional(start: 4, top: 6, bottom: 6),
        tagPadding: const .symmetric(vertical: 9, horizontal: 10),
        tagBorderRadius: style.borderRadius.md,
      );

      return FMultiSelectFieldSizeStyles(
        FVariants(
          md,
          variants: {
            [.sm]: field(
              buttonStyle: buttonStyle,
              contentPadding: const .directional(start: 12, end: 8, top: 5, bottom: 5),
              hintPadding: const .directional(start: 4, top: 3, bottom: 3),
              tagPadding: const .symmetric(vertical: 7, horizontal: 10),
              tagBorderRadius: style.borderRadius.sm,
            ),
            [.md]: md,
            [.lg]: field(
              buttonStyle: buttonStyle,
              contentPadding: const .directional(start: 12, end: 8, top: 5, bottom: 5),
              hintPadding: const .directional(start: 4, top: 7, bottom: 7),
              tagPadding: const .symmetric(vertical: 11, horizontal: 10),
              tagBorderRadius: style.borderRadius.md,
            ),
          },
        ),
      );
    } else {
      final md = field(
        buttonStyle: buttonStyle,
        contentPadding: const .directional(start: 10, end: 8, top: 5, bottom: 5),
        hintPadding: const .directional(start: 4, top: 4, bottom: 4),
        tagPadding: const .symmetric(vertical: 6, horizontal: 8),
        tagBorderRadius: style.borderRadius.md,
      );
      return FMultiSelectFieldSizeStyles(
        FVariants(
          md,
          variants: {
            [.sm]: field(
              buttonStyle: ghost.xs.copyWith(iconContentStyle: ghost.xs.iconContentStyle.copyWith(iconStyle: iconStyle.cast())),
              contentPadding: const .directional(start: 10, end: 8, top: 3, bottom: 3),
              hintPadding: const .directional(start: 4, top: 4, bottom: 4),
              tagPadding: const .symmetric(vertical: 4, horizontal: 8),
              tagBorderRadius: style.borderRadius.xs,
            ),
            [.md]: md,
            [.lg]: field(
              buttonStyle: buttonStyle,
              contentPadding: const .directional(start: 10, end: 8, top: 5, bottom: 5),
              hintPadding: const .directional(start: 4, top: 6, bottom: 6),
              tagPadding: const .symmetric(vertical: 8, horizontal: 8),
              tagBorderRadius: style.borderRadius.md,
            ),
          },
        ),
      );
    }
  }

  /// The small multi-select field style.
  FMultiSelectFieldStyle get sm => resolve({FTextFieldSizeVariant.sm});

  /// The medium (default) multi-select field style.
  FMultiSelectFieldStyle get md => resolve({FTextFieldSizeVariant.md});

  /// The large multi-select field style.
  FMultiSelectFieldStyle get lg => resolve({FTextFieldSizeVariant.lg});
}

/// A [FMultiSelectFieldStyle]'s style.
class FMultiSelectFieldStyle extends FLabelStyle with Diagnosticable, _$FMultiSelectFieldStyleFunctions {
  /// The multi-select field's decoration.
  @override
  final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, Decoration, DecorationDelta> decoration;

  /// The multi-select field's padding.
  @override
  final EdgeInsetsGeometry contentPadding;

  /// The spacing between tags. Defaults to 4.
  @override
  final double spacing;

  /// The spacing between the rows of tags. Defaults to 4.
  @override
  final double runSpacing;

  /// The multi-select field hint's text style.
  @override
  final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> hintTextStyle;

  /// The multi-select field's hint padding.
  @override
  final EdgeInsetsGeometry hintPadding;

  /// The multi-select field's icon style.
  @override
  final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta> iconStyle;

  /// The clear button's style when [FMultiSelect.clearable] is true.
  @override
  final FButtonStyle clearButtonStyle;

  /// The padding surrounding the clear button. Defaults to [EdgeInsets.zero].
  @override
  final EdgeInsetsGeometry clearButtonPadding;

  /// The multi-select field's tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// The tag's style.
  @override
  final FMultiSelectTagStyle tagStyle;

  /// Creates a [FMultiSelectFieldStyle].
  FMultiSelectFieldStyle({
    required this.decoration,
    required this.contentPadding,
    required this.hintTextStyle,
    required this.hintPadding,
    required this.iconStyle,
    required this.clearButtonStyle,
    required this.tappableStyle,
    required this.tagStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.spacing = 4,
    this.runSpacing = 4,
    this.clearButtonPadding = .zero,
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
    super.labelMotion,
  });

  /// Creates a [FMultiSelectFieldStyle] that inherits its properties.
  FMultiSelectFieldStyle.inherit({
    required FColors colors,
    required FStyle style,
    required FLabelStyle labelStyle,
    required TextStyle textStyle,
    required FVariants<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta> iconStyle,
    required FButtonStyle clearButtonStyle,
    required EdgeInsetsGeometry contentPadding,
    required EdgeInsetsGeometry hintPadding,
    required FMultiSelectTagStyle tagStyle,
  }) : this(
         decoration: FVariants(
           ShapeDecoration(
             shape: RoundedSuperellipseBorder(
               side: BorderSide(color: colors.border, width: style.borderWidth),
               borderRadius: style.borderRadius.md,
             ),
             color: colors.card,
           ),
           variants: {
             [.focused]: ShapeDecoration(
               shape: RoundedSuperellipseBorder(
                 side: BorderSide(color: colors.primary, width: style.borderWidth),
                 borderRadius: style.borderRadius.md,
               ),
               color: colors.card,
             ),
             //
             [.disabled]: ShapeDecoration(
               shape: RoundedSuperellipseBorder(
                 side: BorderSide(color: colors.disable(colors.border), width: style.borderWidth),
                 borderRadius: style.borderRadius.md,
               ),
               color: colors.card,
             ),
             //
             [.error]: ShapeDecoration(
               shape: RoundedSuperellipseBorder(
                 side: BorderSide(color: colors.error, width: style.borderWidth),
                 borderRadius: style.borderRadius.md,
               ),
               color: colors.card,
             ),
             [.error.and(.disabled)]: ShapeDecoration(
               shape: RoundedSuperellipseBorder(
                 side: BorderSide(color: colors.disable(colors.error), width: style.borderWidth),
                 borderRadius: style.borderRadius.md,
               ),
               color: colors.disable(colors.card),
             ),
           },
         ),
         contentPadding: contentPadding,
         hintPadding: hintPadding,
         hintTextStyle: FVariants.from(
           textStyle.copyWith(color: colors.mutedForeground),
           variants: {
             [.disabled]: .delta(color: colors.disable(colors.mutedForeground)),
           },
         ),
         iconStyle: iconStyle,
         clearButtonStyle: clearButtonStyle,
         tagStyle: tagStyle,
         tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
         labelTextStyle: style.formFieldStyle.labelTextStyle,
         descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
         errorTextStyle: style.formFieldStyle.errorTextStyle,
         labelPadding: labelStyle.labelPadding,
         descriptionPadding: labelStyle.descriptionPadding,
         errorPadding: labelStyle.errorPadding,
         childPadding: labelStyle.childPadding,
       );
}
