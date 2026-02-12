import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FRadio', {
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
  'error': (2, 'The semantic variant when this widget is in an error state.'),
  'selected': (2, 'The semantic variant when this widget is selected.'),
  'focused': (1, 'The interaction variant when the given widget or any of its descendants have focus.'),
  'hovered': (1, 'The interaction variant when the user drags their mouse cursor over the given widget.'),
  'pressed': (1, 'The interaction variant when the user is actively pressing down on the given widget.'),
})
part 'radio.design.dart';

/// A radio button that typically allows the user to choose only one of a predefined set of options.
///
/// It is recommended to use [FSelectGroup] in conjunction with [FSelectGroupItemMixin.radio] to create a group of radio
/// buttons.
///
/// {@macro forui.widgets.label.error_transition}
///
/// See:
/// * https://forui.dev/docs/form/radio for working examples.
/// * [FRadioStyle] for customizing a radio's appearance.
class FRadio extends StatelessWidget {
  /// The style. Defaults to [FThemeData.radioStyle].
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FRadioStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create radio
  /// ```
  final FRadioStyleDelta style;

  /// The label displayed next to the radio.
  final Widget? label;

  /// The description displayed below the [label].
  final Widget? description;

  /// The error displayed below the [description].
  ///
  /// If the value is present, the radio is in an error state.
  final Widget? error;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

  /// The current value of the radio.
  final bool value;

  /// Called when the user initiates a change to the [FRadio]'s value: when they have checked or unchecked this box.
  final ValueChanged<bool>? onChange;

  /// Whether this radio is enabled. Defaults to true.
  final bool enabled;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// Creates a [FRadio].
  const FRadio({
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
    final style = this.style(context.theme.radioStyle);
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

        return FLabel(
          axis: .horizontal,
          variants: formVariants,
          style: style,
          label: label,
          description: description,
          error: error,
          // A separate FFocusedOutline is used instead of FTappable's built-in one so that only the radio,
          // rather than the entire FLabel, is outlined.
          child: FFocusedOutline(
            focused: tappableVariants.contains(FTappableVariant.focused),
            style: style.focusedOutlineStyle,
            child: Stack(
              alignment: .center,
              children: [
                AnimatedContainer(
                  duration: style.motion.transitionDuration,
                  curve: style.motion.transitionCurve,
                  padding: const .all(2),
                  decoration: BoxDecoration(
                    border: .all(color: style.borderColor.resolve(variants)),
                    color: style.backgroundColor.resolve(variants),
                    shape: .circle,
                  ),
                  child: const SizedBox.square(dimension: 10),
                ),
                AnimatedContainer(
                  duration: style.motion.transitionDuration,
                  curve: style.motion.transitionCurve,
                  decoration: BoxDecoration(color: style.indicatorColor.resolve(variants), shape: .circle),
                  child: AnimatedSize(
                    duration: style.motion.selectDuration,
                    reverseDuration: style.motion.unselectDuration,
                    curve: style.motion.selectCurve,
                    child: value ? const SizedBox.square(dimension: 9) : const SizedBox.shrink(),
                  ),
                ),
              ],
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
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

/// A [FRadio]'s style.
class FRadioStyle extends FLabelStyle with _$FRadioStyleFunctions {
  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The [FRadio]'s border color.
  @override
  final FVariants<FRadioVariantConstraint, Color, Delta> borderColor;

  /// The [FRadio]'s background color.
  @override
  final FVariants<FRadioVariantConstraint, Color, Delta> backgroundColor;

  /// The [FRadio]'s indicator color.
  @override
  final FVariants<FRadioVariantConstraint, Color, Delta> indicatorColor;

  /// The motion-related properties.
  @override
  final FRadioMotion motion;

  /// Creates a [FRadioStyle].
  const FRadioStyle({
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    required this.borderColor,
    required this.backgroundColor,
    required this.indicatorColor,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.motion = const FRadioMotion(),
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
    super.labelMotion,
  });

  /// Creates a [FRadioStyle] that inherits its properties.
  factory FRadioStyle.inherit({required FColors colors, required FStyle style}) {
    final label = FLabelStyles.inherit(style: style).horizontalStyle;
    return .new(
      tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
      focusedOutlineStyle: FFocusedOutlineStyle(color: colors.primary, borderRadius: .circular(100)),
      borderColor: FVariants(
        colors.mutedForeground,
        variants: {
          [.disabled]: colors.disable(colors.mutedForeground),
          //
          [.error]: colors.error,
          [.error.and(.disabled)]: colors.disable(colors.error),
        },
      ),
      backgroundColor: FVariants(
        colors.card,
        variants: {
          [.disabled]: colors.disable(colors.card),
        },
      ),
      indicatorColor: FVariants(
        colors.primary,
        variants: {
          [.disabled]: colors.disable(colors.primary),
          //
          [.error]: colors.error,
          [.error.and(.disabled)]: colors.disable(colors.error),
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

/// The motion-related properties for a [FRadio].
class FRadioMotion with Diagnosticable, _$FRadioMotionFunctions {
  /// The duration of the transition between states. Defaults to 100ms.
  @override
  final Duration transitionDuration;

  /// The curve of the transition between states. Defaults to [Curves.linear].
  @override
  final Curve transitionCurve;

  /// The duration of the animation when selected. Defaults to 100ms.
  @override
  final Duration selectDuration;

  /// The duration of the animation when unselected. Defaults to 100ms.
  @override
  final Duration unselectDuration;

  /// The curve of the select & unselect animation. Defaults to [Curves.easeOutCirc].
  @override
  final Curve selectCurve;

  /// Creates a [FRadioMotion].
  const FRadioMotion({
    this.transitionDuration = const Duration(milliseconds: 100),
    this.transitionCurve = Curves.linear,
    this.selectDuration = const Duration(milliseconds: 100),
    this.unselectDuration = const Duration(milliseconds: 100),
    this.selectCurve = Curves.easeOutCirc,
  });
}
