import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FTextField', {
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
  'error': (2, 'The semantic variant when this widget is in an error state.'),
  'focused': (1, 'The interaction variant when the given widget or any of its descendants have focus.'),
  'hovered': (1, 'The interaction variant when the user drags their mouse cursor over the given widget.'),
  'pressed': (1, 'The interaction variant when the user is actively pressing down on the given widget.'),
})
part 'text_field_style.design.dart';

/// The text field style.
class FTextFieldStyle extends FLabelStyle with _$FTextFieldStyleFunctions {
  /// The appearance of the keyboard. Defaults to [FColors.brightness].
  ///
  /// This setting is only honored on iOS devices.
  @override
  final Brightness keyboardAppearance;

  /// The fill color of the text-field.
  @override
  final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, Color?, Delta> color;

  /// The color of the cursor. Defaults to [CupertinoColors.activeBlue].
  ///
  /// The cursor indicates the current location of text insertion point in the field.
  @override
  final Color cursorColor;

  /// The padding surrounding this text field's content.
  ///
  /// Defaults to `const EdgeInsets.symmetric(horizontal: 10, vertical: 9)`.
  @override
  final EdgeInsetsGeometry contentPadding;

  /// The padding surrounding the clear button. Defaults to `EdgeInsetsDirectional.only(end: 4)`.
  @override
  final EdgeInsetsGeometry clearButtonPadding;

  /// The padding surrounding the obscured text toggle. Defaults to `EdgeInsetsDirectional.only(end: 4)`.
  @override
  final EdgeInsetsGeometry obscureButtonPadding;

  /// Configures padding to edges surrounding a [Scrollable] when this text field scrolls into view.
  ///
  /// Defaults to `EdgeInsets.all(20)`.
  ///
  /// When this widget receives focus and is not completely visible (for example scrolled partially off the screen or
  /// overlapped by the keyboard) then it will attempt to make itself visible by scrolling a surrounding [Scrollable],
  /// if one is present. This value controls how far from the edges of a [Scrollable] the TextField will be positioned
  /// after the scroll.
  @override
  final EdgeInsets scrollPadding;

  /// The prefix & suffix icon styles.
  @override
  final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta> iconStyle;

  /// The clear button's style when [FTextField.clearable] is true.
  @override
  final FButtonStyle clearButtonStyle;

  /// The obscured text toggle's style when enabled in [FTextField.password].
  @override
  final FButtonStyle obscureButtonStyle;

  /// The content's [TextStyle].
  @override
  final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> contentTextStyle;

  /// The hint's [TextStyle].
  @override
  final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> hintTextStyle;

  /// The counter's [TextStyle].
  @override
  final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> counterTextStyle;

  /// The border.
  @override
  // TODO: Change this to Decoration once Flutter provides a raw text field, EditableText is awful to work with.
  final FVariants<FTextFieldVariantConstraint, FTextFieldVariant, InputBorder, Delta> border;

  /// Creates a [FTextFieldStyle].
  FTextFieldStyle({
    required this.keyboardAppearance,
    required this.color,
    required this.iconStyle,
    required this.clearButtonStyle,
    required this.obscureButtonStyle,
    required this.contentTextStyle,
    required this.hintTextStyle,
    required this.counterTextStyle,
    required this.border,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.cursorColor = CupertinoColors.activeBlue,
    this.contentPadding = const .symmetric(horizontal: 10, vertical: 9),
    this.clearButtonPadding = const .directional(end: 4),
    this.obscureButtonPadding = const .directional(end: 4),
    this.scrollPadding = const .all(20),
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
    super.labelMotion,
  });

  /// Creates a [FTextFieldStyle] that inherits its properties.
  factory FTextFieldStyle.inherit({required FColors colors, required FTypography typography, required FStyle style}) {
    final label = FLabelStyles.inherit(style: style).verticalStyle;
    final ghost = FButtonStyles.inherit(colors: colors, typography: typography, style: style).ghost.sm;
    final textStyle = typography.sm.copyWith(fontFamily: typography.defaultFontFamily);
    final iconStyle = FVariants<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta>.from(
      IconThemeData(color: colors.mutedForeground, size: typography.md.fontSize),
      variants: {
        [.disabled]: .delta(color: colors.disable(colors.mutedForeground)),
      },
    );
    final bounceableButtonStyle = ghost.copyWith(
      iconContentStyle: ghost.iconContentStyle.copyWith(iconStyle: iconStyle.cast()),
    );

    return .new(
      keyboardAppearance: colors.brightness,
      color: FVariants(
        colors.card,
        variants: {
          [.disabled]: colors.disable(colors.card),
        },
      ),
      cursorColor: colors.primary,
      iconStyle: iconStyle,
      clearButtonStyle: bounceableButtonStyle,
      obscureButtonStyle: bounceableButtonStyle.copyWith(
        tappableStyle: const .delta(motion: .delta(bounceTween: FTappableMotion.noBounceTween)),
      ),
      contentTextStyle: FVariants.from(
        textStyle.copyWith(color: colors.foreground),
        variants: {
          [.disabled]: .delta(color: colors.disable(colors.foreground)),
        },
      ),
      hintTextStyle: FVariants.from(
        textStyle.copyWith(color: colors.mutedForeground),
        variants: {
          [.disabled]: .delta(color: colors.disable(colors.mutedForeground)),
        },
      ),
      counterTextStyle: FVariants.from(
        textStyle.copyWith(color: colors.foreground),
        variants: {
          [.disabled]: .delta(color: colors.disable(colors.foreground)),
        },
      ),
      border: FVariants(
        OutlineInputBorder(
          borderSide: BorderSide(color: colors.border, width: style.borderWidth),
          borderRadius: style.borderRadius.md,
        ),
        variants: {
          [.focused]: OutlineInputBorder(
            borderSide: BorderSide(color: colors.primary, width: style.borderWidth),
            borderRadius: style.borderRadius.md,
          ),
          //
          [.disabled]: OutlineInputBorder(
            borderSide: BorderSide(color: colors.disable(colors.border), width: style.borderWidth),
            borderRadius: style.borderRadius.md,
          ),
          //
          [.error]: OutlineInputBorder(
            borderSide: BorderSide(color: colors.error, width: style.borderWidth),
            borderRadius: style.borderRadius.md,
          ),
          [.error.and(.disabled)]: OutlineInputBorder(
            borderSide: BorderSide(color: colors.disable(colors.error), width: style.borderWidth),
            borderRadius: style.borderRadius.md,
          ),
        },
      ),
      labelTextStyle: style.formFieldStyle.labelTextStyle,
      descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
      errorTextStyle: style.formFieldStyle.errorTextStyle,
      labelPadding: label.labelPadding,
      descriptionPadding: label.descriptionPadding,
      errorPadding: label.errorPadding,
      childPadding: label.childPadding,
    );
  }
}
