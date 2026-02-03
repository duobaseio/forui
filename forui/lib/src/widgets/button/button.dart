import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/widgets/button/button_content.dart';

@Variants('FButton', {
  'secondary': (2, 'The secondary button style.'),
  'destructive': (3, 'The destructive button style.'),
  'outline': (4, 'The outline button style.'),
  'ghost': (5, 'The ghost button style.'),
})
part 'button.design.dart';

/// A button.
///
/// [FButton] typically contains icons and/or a label. If the [onPress] and [onLongPress] callbacks are null, then this
/// button will be disabled, and it will not react to touch.
///
/// See:
/// * https://forui.dev/docs/form/button for working examples.
/// * [FButtonStyle] for customizing a button's appearance.
class FButton extends StatelessWidget {
  /// The variants used to resolve the style from [FButtonStyles].
  ///
  /// Defaults to an empty set, which resolves to the base (primary) style. The current platform variant is automatically
  /// included during style resolution. To change the platform variant, update the enclosing
  /// [FTheme.platform]/[FAdaptiveScope.platform].
  ///
  /// For example, to create a destructive button:
  /// ```dart
  /// FButton(
  ///   variants: {.destructive},
  ///   onPress: () {},
  ///   child: Text('Delete'),
  /// )
  /// ```
  final Set<FButtonVariant> variants;

  /// The style delta applied to the style resolved by [variants].
  ///
  /// The final style is computed by first resolving the base style from [FButtonStyles] using [variants], then applying
  /// this delta. This allows modifying variant-specific styles:
  /// ```dart
  /// FButton(
  ///   variants: {.destructive},
  ///   style: .delta(contentStyle: .delta(padding: EdgeInsets.all(20))),
  ///   onPress: () {},
  ///   child: Text('Custom destructive button'),
  /// )
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create buttons
  /// ```
  final FButtonStyleDelta style;

  /// {@macro forui.foundation.FTappable.onPress}
  final VoidCallback? onPress;

  /// {@macro forui.foundation.FTappable.onLongPress}
  final VoidCallback? onLongPress;

  /// {@macro forui.foundation.FTappable.onSecondaryPress}
  final VoidCallback? onSecondaryPress;

  /// {@macro forui.foundation.FTappable.onSecondaryLongPress}
  final VoidCallback? onSecondaryLongPress;

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

  /// {@macro forui.foundation.FTappable.shortcuts}
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// {@macro forui.foundation.FTappable.actions}
  final Map<Type, Action<Intent>>? actions;

  /// True if this button is currently selected. Defaults to false.
  final bool selected;

  /// The child.
  final Widget child;

  /// Creates a [FButton] that contains a [prefix], [child], and [suffix].
  ///
  /// [mainAxisSize] determines how the button's width is sized.
  ///
  /// [mainAxisAlignment] and [crossAxisAlignment] determine how the button's content is aligned horizontally and
  /// vertically, respectively.
  ///
  /// [textBaseline] is used to align the [prefix], [child] and [suffix] if [crossAxisAlignment] is
  /// [CrossAxisAlignment.baseline].
  ///
  /// [prefix] and [suffix] are wrapped in [IconThemeData].
  ///
  /// The button layout is as follows, assuming the locale is LTR:
  /// ```diagram
  /// |---------------------------------------|
  /// |  [prefix]  [child]  [suffix]  |
  /// |---------------------------------------|
  /// ```
  ///
  /// The layout is reversed for RTL locales.
  FButton({
    required this.onPress,
    required Widget child,
    this.variants = const {},
    this.style = const .inherit(),
    this.onLongPress,
    this.onSecondaryPress,
    this.onSecondaryLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onVariantChange,
    this.selected = false,
    this.shortcuts,
    this.actions,
    MainAxisSize mainAxisSize = .max,
    MainAxisAlignment mainAxisAlignment = .center,
    CrossAxisAlignment crossAxisAlignment = .center,
    TextBaseline? textBaseline,
    Widget? prefix,
    Widget? suffix,
    super.key,
  }) : child = Content(
         mainAxisSize: mainAxisSize,
         mainAxisAlignment: mainAxisAlignment,
         crossAxisAlignment: crossAxisAlignment,
         textBaseline: textBaseline,
         prefix: prefix,
         suffix: suffix,
         child: child,
       );

  /// Creates a [FButton] that contains only an icon.
  ///
  /// [child] is wrapped in [IconThemeData].
  FButton.icon({
    required this.onPress,
    required Widget child,
    Set<FButtonVariant>? variants,
    this.style = const .inherit(),
    this.onLongPress,
    this.onSecondaryPress,
    this.onSecondaryLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onVariantChange,
    this.selected = false,
    this.shortcuts,
    this.actions,
    super.key,
  }) : variants = variants ?? {FButtonVariant.outline},
       child = IconContent(child: child);

  /// Creates a [FButton] with custom content.
  const FButton.raw({
    required this.onPress,
    required this.child,
    this.variants = const {},
    this.style = const .inherit(),
    this.onLongPress,
    this.onSecondaryPress,
    this.onSecondaryLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onVariantChange,
    this.selected = false,
    this.shortcuts,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style(context.theme.buttonStyles.resolve({...variants, context.platformVariant}));

    return FTappable(
      style: style.tappableStyle,
      focusedOutlineStyle: style.focusedOutlineStyle,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onVariantChange: onVariantChange,
      onPress: onPress,
      onLongPress: onLongPress,
      onSecondaryPress: onSecondaryPress,
      onSecondaryLongPress: onSecondaryLongPress,
      selected: selected,
      builder: (_, variants, _) => DecoratedBox(
        decoration: style.decoration.resolve(variants),
        child: FButtonData(style: style, variants: variants, child: child),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty('variants', variants))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onSecondaryPress', onSecondaryPress))
      ..add(ObjectFlagProperty.has('onSecondaryLongPress', onSecondaryLongPress))
      ..add(FlagProperty('autofocus', value: autofocus, defaultValue: false, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onVariantChange', onVariantChange))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(DiagnosticsProperty('actions', actions))
      ..add(FlagProperty('selected', value: selected, defaultValue: false, ifTrue: 'selected'));
  }
}

/// [FButtonStyle]'s style.
extension type FButtonStyles._(FVariants<FButtonVariantConstraint, FButtonStyle, FButtonStyleDelta> _)
    implements FVariants<FButtonVariantConstraint, FButtonStyle, FButtonStyleDelta> {
  /// Creates a [FButtonStyles] that inherits its properties.
  FButtonStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this._(
        FVariants(
          .inherit(
            colors: colors,
            style: style,
            typography: typography,
            color: colors.primary,
            foregroundColor: colors.primaryForeground,
          ),
          variants: {
            [.secondary]: .inherit(
              colors: colors,
              style: style,
              typography: typography,
              color: colors.secondary,
              foregroundColor: colors.secondaryForeground,
            ),
            [.destructive]: .inherit(
              colors: colors,
              style: style,
              typography: typography,
              color: colors.destructive,
              foregroundColor: colors.destructiveForeground,
            ),
            [.outline]: FButtonStyle(
              decoration: .delta(
                BoxDecoration(
                  border: .all(color: colors.border),
                  borderRadius: style.borderRadius,
                ),
                variants: {
                  [.disabled]: .delta(border: .all(color: colors.disable(colors.border))),
                  [.hovered, .pressed]: .delta(color: colors.secondary),
                },
              ),
              focusedOutlineStyle: style.focusedOutlineStyle,
              contentStyle: .inherit(
                typography: typography,
                enabled: colors.secondaryForeground,
                disabled: colors.disable(colors.secondaryForeground),
              ),
              iconContentStyle: .inherit(
                enabled: colors.secondaryForeground,
                disabled: colors.disable(colors.secondaryForeground),
              ),
              tappableStyle: style.tappableStyle,
            ),
            [.ghost]: FButtonStyle(
              decoration: .delta(
                BoxDecoration(borderRadius: style.borderRadius),
                variants: {
                  [.disabled]: const .delta(),
                  [.hovered, .pressed]: .delta(color: colors.secondary),
                },
              ),
              focusedOutlineStyle: style.focusedOutlineStyle,
              contentStyle: .inherit(
                typography: typography,
                enabled: colors.secondaryForeground,
                disabled: colors.disable(colors.secondaryForeground),
              ),
              iconContentStyle: .inherit(
                enabled: colors.secondaryForeground,
                disabled: colors.disable(colors.secondaryForeground),
              ),
              tappableStyle: style.tappableStyle,
            ),
          },
        ),
      );
}

/// A [FButton]'s style.
final class FButtonStyle with Diagnosticable, _$FButtonStyleFunctions {
  /// The box decoration.
  @override
  final FVariants<FTappableVariantConstraint, BoxDecoration, BoxDecorationDelta> decoration;

  /// The content's style.
  @override
  final FButtonContentStyle contentStyle;

  /// The icon content's style.
  @override
  final FButtonIconContentStyle iconContentStyle;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FButtonStyle].
  FButtonStyle({
    required this.decoration,
    required this.contentStyle,
    required this.iconContentStyle,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
  });

  /// Creates a [FButtonStyle] that inherits its properties.
  FButtonStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required Color color,
    required Color foregroundColor,
  }) : this(
         decoration: .delta(
           BoxDecoration(borderRadius: style.borderRadius, color: color),
           variants: {
             [.disabled]: .delta(color: colors.disable(color)),
             [.hovered, .pressed]: .delta(color: colors.hover(color)),
           },
         ),
         focusedOutlineStyle: style.focusedOutlineStyle,
         contentStyle: .inherit(
           typography: typography,
           enabled: foregroundColor,
           disabled: colors.disable(foregroundColor, colors.disable(color)),
         ),
         iconContentStyle: FButtonIconContentStyle(
           iconStyle: .delta(
             IconThemeData(color: foregroundColor, size: 20),
             variants: {
               [.disabled]: .delta(color: colors.disable(foregroundColor, colors.disable(color))),
             },
           ),
         ),
         tappableStyle: style.tappableStyle,
       );
}

/// A button's data.
class FButtonData extends InheritedWidget {
  /// Returns the [FButtonData] of the [FButton] in the given [context].
  @useResult
  static FButtonData of(BuildContext context) {
    assert(debugCheckHasAncestor<FButtonData>('$FButton', context));
    return context.dependOnInheritedWidgetOfExactType<FButtonData>()!;
  }

  /// The button's style.
  final FButtonStyle style;

  /// The current variants.
  final Set<FTappableVariant> variants;

  /// Creates a [FButtonData].
  const FButtonData({required this.style, required this.variants, required super.child, super.key});

  @override
  bool updateShouldNotify(covariant FButtonData old) => style != old.style || !setEquals(variants, old.variants);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(IterableProperty('variants', variants));
  }
}
