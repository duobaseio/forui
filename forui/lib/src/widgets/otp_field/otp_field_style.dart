import 'dart:ui';

import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FOtpFieldItem', {
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
  'error': (2, 'The semantic variant when this widget is in an error state.'),
  'focused': (1, 'The interaction variant when the given widget or any of its descendants have focus.'),
  'hovered': (1, 'The interaction variant when the user drags their mouse cursor over the given widget.'),
  'pressed': (1, 'The interaction variant when the user is actively pressing down on the given widget.'),
  'start': (1, 'The variant for the first item in a group (e.g. the first item or the first item after a divider).'),
  'end': (1, 'The variant for the last item in a group (e.g. the last item or the last item before a divider).'),
})
part 'otp_field_style.design.dart';

/// The [FOtpField]'s style.
class FOtpFieldStyle({
  /// The appearance of the keyboard. Defaults to [FColors.brightness].
  ///
  /// This setting is only honored on iOS devices.
  @override required final Brightness keyboardAppearance,

  /// The item size.
  @override required final Size itemSize,

  /// The item styles per variant.
  @override required final FOtpFieldItemStyles itemStyles,

  /// The divider's color.
  @override required final FVariants<FOtpFieldItemVariantConstraint, FOtpFieldItemVariant, Color, Delta> dividerColor,
  required super.labelTextStyle,
  required super.descriptionTextStyle,
  required super.errorTextStyle,

  /// The color of the cursor. Defaults to [CupertinoColors.activeBlue].
  ///
  /// The cursor indicates the current location of text insertion point in the field.
  @override final Color cursorColor = CupertinoColors.activeBlue,

  /// The width of the cursor. Defaults to 2.0.
  ///
  /// The cursor indicates the current location of text insertion point in the field.
  @override final double cursorWidth = 2.0,

  /// Whether the cursor opacity animates. Defaults to the current platform's behavior (true on iOS and macOS, false on
  /// other platforms).
  @override final bool? cursorOpacityAnimates,

  /// The divider's padding. Defaults to `EdgeInsets.symmetric(horizontal: 8)`.
  @override final EdgeInsetsGeometry dividerPadding = const .symmetric(horizontal: 8),

  /// The divider's size. Defaults to `Size(12, 1)`.
  @override final Size dividerSize = const Size(12, 1),
  super.labelPadding = const .only(bottom: 6),
  super.descriptionPadding = const .only(top: 6),
  super.errorPadding = const .only(top: 6),
  super.childPadding,
  super.labelMotion,
}) extends FLabelStyle with _$FOtpFieldStyleFunctions {
  /// Creates a [FOtpFieldStyle].
  this;

  /// Creates a [FOtpFieldStyle] that inherits its properties.
  new inherit({required FColors colors, required FTypography typography, required FStyle style, required bool touch})
    : this(
        keyboardAppearance: colors.brightness,
        cursorColor: colors.primary,
        itemSize: touch ? const Size(44, 44) : const Size(36, 36),
        itemStyles: .inherit(colors: colors, typography: typography, style: style),
        dividerPadding: const .symmetric(horizontal: 4),
        dividerColor: FVariants(
          colors.foreground,
          variants: {
            [.disabled]: colors.disable(colors.foreground),
          },
        ),
        labelTextStyle: style.formFieldStyle.labelTextStyle,
        descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
        errorTextStyle: style.formFieldStyle.errorTextStyle,
      );
}

/// The [FOtpFieldItemStyle]s for each variant.
extension type FOtpFieldItemStyles(
  FVariants<FOtpFieldItemVariantConstraint, FOtpFieldItemVariant, FOtpFieldItemStyle, FOtpFieldItemStyleDelta> _,
) implements
    FVariants<FOtpFieldItemVariantConstraint, FOtpFieldItemVariant, FOtpFieldItemStyle, FOtpFieldItemStyleDelta> {
  /// Creates [FOtpFieldItemStyles] that inherit their properties.
  factory inherit({required FColors colors, required FTypography typography, required FStyle style}) =>
      FOtpFieldItemStyles(
        .from(
          FOtpFieldItemStyle(
            decoration: BoxDecoration(
              color: colors.card,
              border: BorderDirectional(
                top: BorderSide(color: colors.border, width: style.borderWidth),
                bottom: BorderSide(color: colors.border, width: style.borderWidth),
                start: BorderSide(color: colors.border, width: style.borderWidth),
              ),
            ),
            contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
          ),
          variants: {
            // --- default ---
            [.start]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: style.borderRadius.sm.topLeft,
                  bottomStart: style.borderRadius.sm.bottomLeft,
                ),
                border: BorderDirectional(
                  top: BorderSide(color: colors.border, width: style.borderWidth),
                  bottom: BorderSide(color: colors.border, width: style.borderWidth),
                  start: BorderSide(color: colors.border, width: style.borderWidth),
                ),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
            ),
            [.end]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: style.borderRadius.sm.topRight,
                  bottomEnd: style.borderRadius.sm.bottomRight,
                ),
                border: Border.all(color: colors.border, width: style.borderWidth),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
            ),
            [.start.and(.end)]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: style.borderRadius.sm,
                border: Border.all(color: colors.border, width: style.borderWidth),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
            ),
            // --- focused ---
            [.focused]: FOtpFieldItemStyle(
              decoration: ShapeDecoration(
                color: colors.card,
                shape: RoundedSuperellipseBorder(
                  side: BorderSide(color: colors.foreground, width: style.borderWidth),
                ),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
            ),
            [.focused.and(.start)]: FOtpFieldItemStyle(
              decoration: ShapeDecoration(
                color: colors.card,
                shape: RoundedSuperellipseBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: style.borderRadius.sm.topLeft,
                    bottomStart: style.borderRadius.sm.bottomLeft,
                  ),
                  side: BorderSide(color: colors.foreground, width: style.borderWidth),
                ),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
            ),
            [.focused.and(.end)]: FOtpFieldItemStyle(
              decoration: ShapeDecoration(
                color: colors.card,
                shape: RoundedSuperellipseBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: style.borderRadius.sm.topRight,
                    bottomEnd: style.borderRadius.sm.bottomRight,
                  ),
                  side: BorderSide(color: colors.foreground, width: style.borderWidth),
                ),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
            ),
            [.focused.and(.start).and(.end)]: FOtpFieldItemStyle(
              decoration: ShapeDecoration(
                color: colors.card,
                shape: RoundedSuperellipseBorder(
                  borderRadius: style.borderRadius.sm,
                  side: BorderSide(color: colors.foreground, width: style.borderWidth),
                ),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
            ),
            // --- disabled ---
            [.disabled]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.disable(colors.card),
                border: BorderDirectional(
                  top: BorderSide(color: colors.disable(colors.border), width: style.borderWidth),
                  bottom: BorderSide(color: colors.disable(colors.border), width: style.borderWidth),
                  start: BorderSide(color: colors.disable(colors.border), width: style.borderWidth),
                ),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.disable(colors.foreground)),
            ),
            [.disabled.and(.start)]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.disable(colors.card),
                borderRadius: BorderRadiusDirectional.only(
                  topStart: style.borderRadius.sm.topLeft,
                  bottomStart: style.borderRadius.sm.bottomLeft,
                ),
                border: BorderDirectional(
                  top: BorderSide(color: colors.disable(colors.border), width: style.borderWidth),
                  bottom: BorderSide(color: colors.disable(colors.border), width: style.borderWidth),
                  start: BorderSide(color: colors.disable(colors.border), width: style.borderWidth),
                ),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.disable(colors.foreground)),
            ),
            [.disabled.and(.end)]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.disable(colors.card),
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: style.borderRadius.sm.topRight,
                  bottomEnd: style.borderRadius.sm.bottomRight,
                ),
                border: Border.all(color: colors.disable(colors.border), width: style.borderWidth),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.disable(colors.foreground)),
            ),
            [.disabled.and(.start).and(.end)]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.disable(colors.card),
                borderRadius: style.borderRadius.sm,
                border: Border.all(color: colors.disable(colors.border), width: style.borderWidth),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.disable(colors.foreground)),
            ),
            // --- error ---
            [.error]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.card,
                border: BorderDirectional(
                  top: BorderSide(color: colors.error, width: style.borderWidth),
                  bottom: BorderSide(color: colors.error, width: style.borderWidth),
                  start: BorderSide(color: colors.error, width: style.borderWidth),
                ),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
            ),
            [.error.and(.start)]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: style.borderRadius.sm.topLeft,
                  bottomStart: style.borderRadius.sm.bottomLeft,
                ),
                border: BorderDirectional(
                  top: BorderSide(color: colors.error, width: style.borderWidth),
                  bottom: BorderSide(color: colors.error, width: style.borderWidth),
                  start: BorderSide(color: colors.error, width: style.borderWidth),
                ),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
            ),
            [.error.and(.end)]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: style.borderRadius.sm.topRight,
                  bottomEnd: style.borderRadius.sm.bottomRight,
                ),
                border: Border.all(color: colors.error, width: style.borderWidth),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
            ),
            [.error.and(.start).and(.end)]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: style.borderRadius.sm,
                border: Border.all(color: colors.error, width: style.borderWidth),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.foreground),
            ),
            // --- error + disabled ---
            [.error.and(.disabled)]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.disable(colors.card),
                border: BorderDirectional(
                  top: BorderSide(color: colors.disable(colors.error), width: style.borderWidth),
                  bottom: BorderSide(color: colors.disable(colors.error), width: style.borderWidth),
                  start: BorderSide(color: colors.disable(colors.error), width: style.borderWidth),
                ),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.disable(colors.foreground)),
            ),
            [.error.and(.disabled).and(.start)]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.disable(colors.card),
                borderRadius: BorderRadiusDirectional.only(
                  topStart: style.borderRadius.sm.topLeft,
                  bottomStart: style.borderRadius.sm.bottomLeft,
                ),
                border: BorderDirectional(
                  top: BorderSide(color: colors.disable(colors.error), width: style.borderWidth),
                  bottom: BorderSide(color: colors.disable(colors.error), width: style.borderWidth),
                  start: BorderSide(color: colors.disable(colors.error), width: style.borderWidth),
                ),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.disable(colors.foreground)),
            ),
            [.error.and(.disabled).and(.end)]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.disable(colors.card),
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: style.borderRadius.sm.topRight,
                  bottomEnd: style.borderRadius.sm.bottomRight,
                ),
                border: Border.all(color: colors.disable(colors.error), width: style.borderWidth),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.disable(colors.foreground)),
            ),
            [.error.and(.disabled).and(.start).and(.end)]: FOtpFieldItemStyle(
              decoration: BoxDecoration(
                color: colors.disable(colors.card),
                borderRadius: style.borderRadius.sm,
                border: Border.all(color: colors.disable(colors.error), width: style.borderWidth),
              ),
              contentTextStyle: typography.body.sm.copyWith(color: colors.disable(colors.foreground)),
            ),
          },
        ),
      );
}

/// The style of an individual item in an [FOtpField].
class const FOtpFieldItemStyle({
  /// The decoration.
  @override required final Decoration decoration,

  /// The content's [TextStyle].
  @override required final TextStyle contentTextStyle,
}) with Diagnosticable, _$FOtpFieldItemStyleFunctions {
  /// Creates a [FOtpFieldItemStyle].
  this;
}
