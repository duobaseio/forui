import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/foundation/keys.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FCheckbox', {
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
  'error': (2, 'The semantic variant when this widget is in an error state.'),
  'selected': (2, 'The semantic variant when this widget is selected/checked.'),
  'focused': (1, 'The interaction variant when the given widget or any of its descendants have focus.'),
  'hovered': (1, 'The interaction variant when the user drags their mouse cursor over the given widget.'),
  'pressed': (1, 'The interaction variant when the user is actively pressing down on the given widget.'),
})
part 'checkbox.design.dart';

/// A checkbox control that allows the user to toggle between checked and not checked.
///
/// For touch devices, a [FSwitch] is generally recommended over this.
///
/// See:
/// * https://forui.dev/docs/form/checkbox for working examples.
/// * [FCheckboxStyle] for customizing a checkboxes appearance.
class FCheckbox extends StatelessWidget {
  /// The style. Defaults to [FThemeData.checkboxStyle].
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FCheckboxStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create checkbox
  /// ```
  final FCheckboxStyleDelta style;

  /// The label displayed next to the checkbox.
  final Widget? label;

  /// The description displayed below the [label].
  final Widget? description;

  /// The error displayed below the [description].
  ///
  /// If the value is present, the checkbox is in an error state.
  final Widget? error;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

  /// The current value of the checkbox.
  final bool value;

  /// Called when the user initiates a change to the FCheckBox's value: when they have checked or unchecked this box.
  final ValueChanged<bool>? onChange;

  /// Whether this checkbox is enabled. Defaults to true.
  final bool enabled;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// Creates a [FCheckbox].
  const FCheckbox({
    this.style = const .inherit(),
    this.label,
    this.description,
    this.error,
    this.semanticsLabel,
    this.value = false,
    this.onChange,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style(context.theme.checkboxStyle);
    final formVariants = <FFormFieldVariant>{if (!enabled) .disabled, if (error != null) .error};

    return FTappable(
      style: style.tappableStyle,
      semanticsLabel: semanticsLabel,
      selected: value,
      onPress: enabled ? () => onChange?.call(!value) : null,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      builder: (context, tappableVariants, _) {
        final variants = <FVariant>{...tappableVariants, ...formVariants};

        final iconTheme = style.iconStyle.resolve(variants);
        final decoration = style.decoration.resolve(variants);
        return FLabel(
          axis: .horizontal,
          variants: formVariants,
          style: style,
          label: label,
          description: description,
          error: error,
          // A separate FFocusedOutline is used instead of FTappable's built-in one so that only the checkbox,
          // rather than the entire FLabel, is outlined.
          child: FFocusedOutline(
            focused: tappableVariants.contains(FTappableVariant.focused),
            style: style.focusedOutlineStyle,
            child: AnimatedSwitcher(
              duration: style.motion.fadeInDuration,
              reverseDuration: style.motion.fadeOutDuration,
              switchInCurve: style.motion.fadeInCurve,
              switchOutCurve: style.motion.fadeOutCurve,
              // This transition builder is necessary because of https://github.com/flutter/flutter/issues/121336#issuecomment-1482620874
              transitionBuilder: (child, opacity) => FadeTransition(opacity: opacity, child: child),
              child: SizedBox.square(
                // We use the derived iconTheme and decoration as keys to prevent the animation from triggering between
                // states with the same appearance.
                key: ListKey([iconTheme, decoration]),
                dimension: style.size,
                child: DecoratedBox(
                  decoration: decoration,
                  child: value ? IconTheme(data: iconTheme, child: const Icon(FIcons.check)) : const SizedBox(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('value', value: value, ifTrue: 'checked'))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

/// A checkboxes style.
class FCheckboxStyle extends FLabelStyle with _$FCheckboxStyleFunctions {
  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The checkboxes size. Defaults to 16.
  @override
  final double size;

  /// The icon style.
  @override
  final FVariants<FFormFieldVariantConstraint, FFormFieldVariant, IconThemeData, IconThemeDataDelta> iconStyle;

  /// The box decoration.
  @override
  final FVariants<FCheckboxVariantConstraint, FCheckboxVariant, BoxDecoration, BoxDecorationDelta> decoration;

  /// The motion-related properties.
  @override
  final FCheckboxMotion motion;

  /// Creates a [FCheckboxStyle].
  const FCheckboxStyle({
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    required this.iconStyle,
    required this.decoration,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.size = 16,
    this.motion = const FCheckboxMotion(),
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
    super.labelMotion,
  });

  /// Creates a [FCheckboxStyle] that inherits its properties.
  factory FCheckboxStyle.inherit({required FColors colors, required FStyle style}) {
    final label = FLabelStyles.inherit(style: style).horizontalStyle;
    return .new(
      tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
      focusedOutlineStyle: style.focusedOutlineStyle.copyWith(borderRadius: .circular(4)),
      iconStyle: FVariants.from(
        IconThemeData(color: colors.primaryForeground, size: 14),
        variants: {
          [.disabled]: .delta(color: colors.disable(colors.primaryForeground)),
          //
          [.error]: .delta(color: colors.errorForeground),
          [.error.and(.disabled)]: .delta(color: colors.disable(colors.errorForeground)),
        },
      ),
      decoration: FVariants.from(
        BoxDecoration(
          borderRadius: style.borderRadius,
          border: .all(color: colors.mutedForeground, width: 0.6),
          color: colors.card,
        ),
        variants: {
          [.disabled]: .delta(
            border: .all(color: colors.disable(colors.mutedForeground), width: 0.6),
            color: colors.disable(colors.card),
          ),
          //
          [.selected]: .delta(border: null, color: colors.primary),
          [.selected.and(.disabled)]: .delta(border: null, color: colors.disable(colors.primary)),
          //
          [.error]: .delta(border: .all(color: colors.error, width: 0.6)),
          [.error.and(.disabled)]: .delta(
            border: .all(color: colors.disable(colors.error), width: 0.6),
            color: colors.disable(colors.card),
          ),
          [.error.and(.selected)]: .delta(border: null, color: colors.error),
          [.error.and(.disabled).and(.selected)]: .delta(border: null, color: colors.disable(colors.error)),
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

/// The motion-related properties for a [FCheckbox].
class FCheckboxMotion with Diagnosticable, _$FCheckboxMotionFunctions {
  /// The duration of the fade in animation. Defaults to 100ms.
  @override
  final Duration fadeInDuration;

  /// The duration of the fade out animation. Defaults to 100ms.
  @override
  final Duration fadeOutDuration;

  /// The curve of the fade in animation. Defaults to [Curves.linear].
  @override
  final Curve fadeInCurve;

  /// The curve of the fade out animation. Defaults to [Curves.linear].
  @override
  final Curve fadeOutCurve;

  /// Creates a [FCheckboxMotion].
  const FCheckboxMotion({
    this.fadeInDuration = const Duration(milliseconds: 100),
    this.fadeOutDuration = const Duration(milliseconds: 100),
    this.fadeInCurve = Curves.linear,
    this.fadeOutCurve = Curves.linear,
  });
}
