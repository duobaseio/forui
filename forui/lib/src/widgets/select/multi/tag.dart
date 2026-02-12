import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FMultiSelectTag', {
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
  'focused': (1, 'The interaction variant when the given widget or any of its descendants have focus.'),
  'hovered': (1, 'The interaction variant when the user drags their mouse cursor over the given widget.'),
  'pressed': (1, 'The interaction variant when the user is actively pressing down on the given widget.'),
})
part 'tag.design.dart';

/// A tag in a [FMultiSelect].
class FMultiSelectTag extends StatelessWidget {
  /// The style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FMultiSelectTagStyle(...)
  /// ```
  final FMultiSelectTagStyleDelta style;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.foundation.FTappable.onHoverChange}
  final ValueChanged<bool>? onHoverChange;

  /// {@macro forui.foundation.FTappable.onVariantChange}
  final FTappableVariantChangeCallback? onVariantChange;

  /// The label.
  final Widget label;

  /// {@macro forui.foundation.FTappable.onPress}
  final VoidCallback? onPress;

  /// {@macro forui.foundation.FTappable.onLongPress}
  final VoidCallback? onLongPress;

  /// {@macro forui.foundation.FTappable.onSecondaryPress}
  final VoidCallback? onSecondaryPress;

  /// {@macro forui.foundation.FTappable.onSecondaryLongPress}
  final VoidCallback? onSecondaryLongPress;

  /// {@macro forui.foundation.FTappable.shortcuts}
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// {@macro forui.foundation.FTappable.actions}
  final Map<Type, Action<Intent>>? actions;

  /// Creates a [FMultiSelectTag].
  const FMultiSelectTag({
    required this.label,
    this.style = const .inherit(),
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onVariantChange,
    this.onPress,
    this.onLongPress,
    this.onSecondaryPress,
    this.onSecondaryLongPress,
    this.shortcuts,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style(context.theme.multiSelectStyle.tagStyle);
    return FTappable(
      style: style.tappableStyle,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onVariantChange: onVariantChange,
      onPress: onPress,
      onLongPress: onLongPress,
      onSecondaryPress: onSecondaryPress,
      onSecondaryLongPress: onSecondaryLongPress,
      shortcuts: shortcuts,
      actions: actions,
      builder: (context, variants, child) => DecoratedBox(
        decoration: style.decoration.resolve(variants),
        child: Padding(
          padding: style.padding,
          child: Row(
            mainAxisSize: .min,
            spacing: style.spacing,
            children: [
              DefaultTextStyle(style: style.labelTextStyle.resolve(variants), child: label),
              FFocusedOutline(
                focused: variants.contains(FTappableVariant.focused),
                child: IconTheme(data: style.iconStyle.resolve(variants), child: const Icon(FIcons.x)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('style', style))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onVariantChange', onVariantChange))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onSecondaryPress', onSecondaryPress))
      ..add(ObjectFlagProperty.has('onSecondaryLongPress', onSecondaryLongPress))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(DiagnosticsProperty('actions', actions));
  }
}

/// A [FMultiSelectTag]'s style.
class FMultiSelectTagStyle with Diagnosticable, _$FMultiSelectTagStyleFunctions {
  /// The decoration.
  @override
  final FVariants<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, Decoration, Delta> decoration;

  /// The padding. Defaults to `EdgeInsets.symmetric(vertical: 4, horizontal: 8)`.
  ///
  /// The vertical padding should typically be the same as the [FMultiSelectFieldStyle.hintPadding].
  @override
  final EdgeInsets padding;

  /// The spacing between the label and the icon. Defaults to 4.
  @override
  final double spacing;

  /// The label's text style.
  @override
  final FVariants<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, TextStyle, TextStyleDelta> labelTextStyle;

  /// The icon's style.
  @override
  final FVariants<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, IconThemeData, IconThemeDataDelta> iconStyle;

  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FMultiSelectTagStyle].
  FMultiSelectTagStyle({
    required this.decoration,
    required this.labelTextStyle,
    required this.iconStyle,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    this.spacing = 4,
  });

  /// Creates a [FMultiSelectTagStyle] that inherits its properties.
  FMultiSelectTagStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        decoration: FVariants(
          BoxDecoration(borderRadius: style.borderRadius, color: colors.secondary),
          variants: {
            [.hovered, .pressed]: BoxDecoration(
              borderRadius: style.borderRadius,
              color: colors.hover(colors.secondary),
            ),
            //
            [.disabled]: BoxDecoration(borderRadius: style.borderRadius, color: colors.disable(colors.secondary)),
          },
        ),
        labelTextStyle: FVariants.from(
          typography.sm.copyWith(color: colors.secondaryForeground),
          variants: {
            [.disabled]: .delta(color: colors.disable(colors.secondaryForeground)),
          },
        ),
        iconStyle: FVariants.from(
          IconThemeData(color: colors.mutedForeground, size: 15),
          variants: {
            [.disabled]: .delta(color: colors.disable(colors.mutedForeground)),
          },
        ),
        tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}
