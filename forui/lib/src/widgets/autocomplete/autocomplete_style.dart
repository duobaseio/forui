import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show InputBorder;
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'autocomplete_style.design.dart';

/// An [FAutocomplete]'s style.
class FAutocompleteStyle with Diagnosticable, _$FAutocompleteStyleFunctions {
  /// The field's styles.
  @override
  final FAutocompleteFieldSizeStyles fieldStyles;

  /// The content's style.
  @override
  final FAutocompleteContentStyle contentStyle;

  /// Creates a [FAutocompleteStyle].
  FAutocompleteStyle({required this.fieldStyles, required this.contentStyle});

  /// Creates a [FAutocompleteStyle] that inherits its properties.
  FAutocompleteStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) : this(
         fieldStyles: .inherit(colors: colors, typography: typography, style: style, touch: touch),
         contentStyle: .inherit(colors: colors, typography: typography, style: style, touch: touch),
       );
}

/// [FAutocompleteStyle]'s size styles.
extension type FAutocompleteFieldSizeStyles(
  FVariants<
    FTextFieldSizeVariantConstraint,
    FTextFieldSizeVariant,
    FAutocompleteFieldStyle,
    FAutocompleteFieldStyleDelta
  >
  _
)
    implements
        FVariants<
          FTextFieldSizeVariantConstraint,
          FTextFieldSizeVariant,
          FAutocompleteFieldStyle,
          FAutocompleteFieldStyleDelta
        > {
  /// Creates [FAutocompleteFieldSizeStyles] that inherit their properties.
  factory FAutocompleteFieldSizeStyles.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) {
    final sizes = FTextFieldSizeStyles.inherit(colors: colors, typography: typography, style: style, touch: touch);

    final md = FAutocompleteFieldStyle.inherit(colors: colors, field: sizes.md);
    return FAutocompleteFieldSizeStyles(
      FVariants(
        md,
        variants: {
          [.sm]: .inherit(colors: colors, field: sizes.sm),
          [.md]: md,
          [.lg]: .inherit(colors: colors, field: sizes.lg),
        },
      ),
    );
  }

  /// The small autocomplete field style.
  FAutocompleteFieldStyle get sm => resolve({FTextFieldSizeVariant.sm});

  /// The medium (default) autocomplete field style.
  FAutocompleteFieldStyle get md => resolve({FTextFieldSizeVariant.md});

  /// The large autocomplete field style.
  FAutocompleteFieldStyle get lg => resolve({FTextFieldSizeVariant.lg});
}

/// An autocomplete field's style.
class FAutocompleteFieldStyle extends FTextFieldStyle with _$FAutocompleteFieldStyleFunctions {
  /// The composing text's [TextStyle].
  ///
  /// {@template forui.text_field.composingTextStyle}
  /// It is strongly recommended that [FTextFieldStyle.contentTextStyle], [composingTextStyle] and [typeaheadTextStyle]
  /// are the same size to prevent visual discrepancies between the actual and typeahead text.
  /// {@endtemplate}
  @override
  final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> composingTextStyle;

  /// The typeahead's [TextStyle].
  ///
  /// {@macro forui.text_field.composingTextStyle}
  @override
  final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle?, TextStyleDelta> typeaheadTextStyle;

  /// Creates a [FAutocompleteFieldStyle].
  FAutocompleteFieldStyle({
    required this.composingTextStyle,
    required this.typeaheadTextStyle,
    required super.keyboardAppearance,
    required super.color,
    required super.iconStyle,
    required super.clearButtonStyle,
    required super.obscureButtonStyle,
    required super.contentTextStyle,
    required super.hintTextStyle,
    required super.counterTextStyle,
    required super.border,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    super.cursorColor,
    super.cursorWidth,
    super.cursorOpacityAnimates,
    super.contentPadding,
    super.clearButtonPadding,
    super.obscureButtonPadding,
    super.scrollPadding,
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
    super.labelMotion,
  });

  /// Creates an [FAutocompleteFieldStyle] from a [FTextFieldStyle].
  FAutocompleteFieldStyle.inherit({required FColors colors, required FTextFieldStyle field})
    : this(
        composingTextStyle: field.contentTextStyle.apply([.all(.delta(decoration: () => .underline))]),
        typeaheadTextStyle: FVariants(
          field.contentTextStyle.base.copyWith(color: colors.mutedForeground),
          variants: {
            [.disabled, .not(.focused)]: null,
          },
        ),
        keyboardAppearance: field.keyboardAppearance,
        color: field.color,
        cursorColor: field.cursorColor,
        cursorWidth: field.cursorWidth,
        cursorOpacityAnimates: field.cursorOpacityAnimates,
        contentPadding: field.contentPadding,
        clearButtonPadding: field.clearButtonPadding,
        obscureButtonPadding: field.obscureButtonPadding,
        scrollPadding: field.scrollPadding,
        iconStyle: field.iconStyle,
        clearButtonStyle: field.clearButtonStyle,
        obscureButtonStyle: field.obscureButtonStyle,
        contentTextStyle: field.contentTextStyle,
        hintTextStyle: field.hintTextStyle,
        counterTextStyle: field.counterTextStyle,
        border: field.border,
        labelTextStyle: field.labelTextStyle,
        descriptionTextStyle: field.descriptionTextStyle,
        errorTextStyle: field.errorTextStyle,
        labelPadding: field.labelPadding,
        descriptionPadding: field.descriptionPadding,
        errorPadding: field.errorPadding,
        childPadding: field.childPadding,
        labelMotion: field.labelMotion,
      );
}
