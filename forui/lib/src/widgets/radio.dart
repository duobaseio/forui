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
/// See:
/// * https://forui.dev/docs/form/radio for working examples.
/// * [FRadioStyle] for customizing a radio's appearance.
class FRadio extends StatelessWidget {
  /// The style. Defaults to [FThemeData.radioStyle].
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
      style: .value(style.tappableStyle),
      semanticsLabel: semanticsLabel,
      selected: value,
      onPress: enabled ? () => onChange?.call(!value) : null,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      builder: (context, tappableVariants, _) {
        final variants = {...tappableVariants, ...formVariants};

        return FLabel(
          axis: .horizontal,
          variants: formVariants,
          style: .value(style),
          label: label,
          description: description,
          error: error,
          // A separate FFocusedOutline is used instead of FTappable's built-in one so that only the radio,
          // rather than the entire FLabel, is outlined.
          child: FFocusedOutline(
            focused: tappableVariants.contains(FTappableVariant.focused),
            style: .value(style.focusedOutlineStyle),
            child: Stack(
              alignment: .center,
              children: [
                Container(
                  padding: const .all(2),
                  decoration: BoxDecoration(
                    border: .all(color: style.borderColor.resolve(variants)),
                    color: style.backgroundColor.resolve(variants),
                    shape: .circle,
                  ),
                  child: const SizedBox.square(dimension: 10),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(color: style.indicatorColor.resolve(variants), shape: .circle),
                  child: AnimatedSize(
                    duration: style.motion.duration,
                    reverseDuration: style.motion.reverseDuration,
                    curve: style.motion.curve,
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
  final FVariants<FRadioVariantConstraint, Color, Delta<Color>> borderColor;

  /// The [FRadio]'s background color.
  @override
  final FVariants<FRadioVariantConstraint, Color, Delta<Color>> backgroundColor;

  /// The [FRadio]'s indicator color.
  @override
  final FVariants<FRadioVariantConstraint, Color, Delta<Color>> indicatorColor;

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
  });

  /// Creates a [FRadioStyle] that inherits its properties.
  factory FRadioStyle.inherit({required FColors colors, required FStyle style}) {
    final label = FLabelStyles.inherit(style: style).horizontalStyle;
    return .new(
      tappableStyle: style.tappableStyle.copyWith(motion: const .value(FTappableMotion.none)),
      focusedOutlineStyle: FFocusedOutlineStyle(color: colors.primary, borderRadius: .circular(100)),
      borderColor: FVariants(
        colors.primary,
        variants: {
          [.error]: colors.error,
          [.disabled]: colors.disable(colors.primary),
        },
      ),
      backgroundColor: .all(colors.background),
      indicatorColor: FVariants(
        colors.primary,
        variants: {
          [.error]: colors.error,
          [.disabled]: colors.disable(colors.primary),
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
  /// The duration of the animation when selected. Defaults to 100ms.
  @override
  final Duration duration;

  /// The duration of the reverse animation when unselected. Defaults to 100ms.
  @override
  final Duration reverseDuration;

  /// The curve of the animation. Defaults to [Curves.easeOutCirc].
  @override
  final Curve curve;

  /// Creates a [FRadioMotion].
  const FRadioMotion({
    this.duration = const Duration(milliseconds: 100),
    this.reverseDuration = const Duration(milliseconds: 100),
    this.curve = Curves.easeOutCirc,
  });
}
