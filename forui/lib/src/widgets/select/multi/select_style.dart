import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'select_style.design.dart';

/// A [FMultiSelect]'s style.
class FMultiSelectStyle({
  /// The field's size styles.
  @override required final FMultiSelectFieldSizeStyles fieldStyles,

  /// The search's style.
  @override required final FSelectSearchStyle searchStyle,

  /// The content's style.
  @override required final FSelectContentStyle contentStyle,

  /// The default text style when there are no results.
  @override required final TextStyle emptyTextStyle,
}) with Diagnosticable, _$FMultiSelectStyleFunctions {
  /// Creates a [FMultiSelectStyle].
  this;

  /// Creates a [FMultiSelectStyle] that inherits its properties.
  new inherit({
    required FColors colors,
    required FTypography typography,
    required FIcons icons,
    required FStyle style,
    required bool touch,
  }) : this(
         fieldStyles: .inherit(colors: colors, icons: icons, typography: typography, style: style, touch: touch),
         searchStyle: .inherit(colors: colors, typography: typography, style: style, touch: touch),
         contentStyle: .inherit(colors: colors, icons: icons, typography: typography, style: style, touch: touch),
         emptyTextStyle: typography.body.sm,
       );
}

/// [FMultiSelectFieldStyle]'s size styles.
extension type FMultiSelectFieldSizeStyles(
  FVariants<FTextFieldSizeVariantConstraint, FTextFieldSizeVariant, FMultiSelectFieldStyle, FMultiSelectFieldStyleDelta>
  _,
) implements
    FVariants<
      FTextFieldSizeVariantConstraint,
      FTextFieldSizeVariant,
      FMultiSelectFieldStyle,
      FMultiSelectFieldStyleDelta
    > {
  /// Creates a [FMultiSelectFieldSizeStyles] that inherits its properties.
  factory inherit({
    required FColors colors,
    required FIcons icons,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) {
    final label = FLabelStyles.inherit(style: style).verticalStyle;
    final textStyle = typography.body.sm;
    final iconStyle = FVariants<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta>.from(
      IconThemeData(color: colors.mutedForeground, size: typography.body.sm.fontSize),
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
      icons: icons,
      style: style,
      labelStyle: label,
      textStyle: textStyle,
      iconStyle: iconStyle,
      clearButtonStyle: buttonStyle,
      contentPadding: contentPadding,
      hintPadding: hintPadding,
      tagStyle: .inherit(
        colors: colors,
        icons: icons,
        style: style,
        textStyle: typography.body.sm,
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
              buttonStyle: ghost.xs.copyWith(
                iconContentStyle: ghost.xs.iconContentStyle.copyWith(iconStyle: iconStyle.cast()),
              ),
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
class FMultiSelectFieldStyle({
  /// The multi-select field's decoration.
  @override
  required final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, Decoration, DecorationDelta> decoration,

  /// The multi-select field's padding.
  @override required final EdgeInsetsGeometry contentPadding,

  /// The multi-select field hint's text style.
  @override
  required final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> hintTextStyle,

  /// The multi-select field's hint padding.
  @override required final EdgeInsetsGeometry hintPadding,

  /// The multi-select field's icon style.
  @override
  required final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta> iconStyle,

  /// The clear button's style when [FMultiSelect.clearable] is true.
  @override required final FButtonStyle clearButtonStyle,

  /// The clear button's icon builder. Defaults to [FIcons.x].
  @override required final FIcon clearIcon,

  /// The multi-select field's tappable style.
  @override required final FTappableStyle tappableStyle,

  /// The tag's style.
  @override required final FMultiSelectTagStyle tagStyle,
  required super.labelTextStyle,
  required super.descriptionTextStyle,
  required super.errorTextStyle,

  /// The spacing between tags. Defaults to 4.
  @override final double spacing = 4,

  /// The spacing between the rows of tags. Defaults to 4.
  @override final double runSpacing = 4,

  /// The padding surrounding the clear button. Defaults to [EdgeInsets.zero].
  @override final EdgeInsetsGeometry clearButtonPadding = .zero,
  super.labelPadding,
  super.descriptionPadding,
  super.errorPadding,
  super.childPadding,
  super.labelMotion,
}) extends FLabelStyle with Diagnosticable, _$FMultiSelectFieldStyleFunctions {
  /// Creates a [FMultiSelectFieldStyle].
  this;

  /// Creates a [FMultiSelectFieldStyle] that inherits its properties.
  new inherit({
    required FColors colors,
    required FIcons icons,
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
         clearIcon: icons.x,
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
