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
@Variants('FButtonSize', {
  'xs': (1, 'The extra small button size.'),
  'sm': (1, 'The small button size.'),
  'lg': (1, 'The large button size.'),
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
  /// The variant. Defaults to the base (primary) style.
  ///
  /// The current platform variant is automatically included during style resolution. To change the platform variant,
  /// update the enclosing [FTheme.platform]/[FAdaptiveScope.platform].
  ///
  /// For example, to create a destructive button:
  /// ```dart
  /// FButton(
  ///   variant: .destructive,
  ///   onPress: () {},
  ///   child: Text('Delete'),
  /// )
  /// ```
  final FButtonVariant? variant;

  /// The button size. Defaults to the base size.
  ///
  /// The current platform variant is automatically included during style resolution. To change the platform variant,
  /// update the enclosing [FTheme.platform]/[FAdaptiveScope.platform].
  ///
  /// For example, to create a small button:
  /// ```dart
  /// FButton(
  ///   size: .sm,
  ///   mainAxisSize: .min, // optional: shrink to fit content horizontally.
  ///   onPress: () {},
  ///   child: Text('Delete'),
  /// )
  /// ```
  final FButtonSizeVariant? size;

  /// The style delta applied to the style resolved by [variant] and [size].
  ///
  /// ```dart
  /// FButton(
  ///   variant: .destructive,
  ///   size: .small,
  ///   style: .delta(contentStyle: .delta(padding: .all(20))),
  ///   onPress: () {},
  ///   child: Text('Small destructive button with extra padding'),
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
    this.variant,
    this.size,
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
    this.variant = .outline,
    this.size,
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
  }) : child = IconContent(child: child);

  /// Creates a [FButton] with custom content.
  const FButton.raw({
    required this.onPress,
    required this.child,
    this.variant,
    this.size,
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
    final sizeStyles = context.theme.buttonStyles.resolve({?variant, context.platformVariant});
    final style = this.style(sizeStyles.resolve({?size, context.platformVariant}));

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
      ..add(DiagnosticsProperty('variant', variant))
      ..add(DiagnosticsProperty('size', size))
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
extension type FButtonStyles._(FVariants<FButtonVariantConstraint, FButtonSizes, FButtonSizesDelta> _)
    implements FVariants<FButtonVariantConstraint, FButtonSizes, FButtonSizesDelta> {
  /// Creates a [FButtonStyles] that inherits its properties.
  FButtonStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this._(
        FVariants(
          FButtonSizeStyles.inherit(
            typography: typography,
            style: style,
            decoration: .delta(
              BoxDecoration(borderRadius: style.borderRadius, color: colors.primary),
              variants: {
                [.disabled]: .delta(color: colors.disable(colors.primary)),
                [.hovered, .pressed]: .delta(color: colors.hover(colors.primary)),
              },
            ),
            foregroundColor: colors.primaryForeground,
            disabledForegroundColor: colors.disable(colors.primaryForeground, colors.disable(colors.primary)),
          ),
          variants: {
            [.secondary]: FButtonSizeStyles.inherit(
              typography: typography,
              style: style,
              decoration: .delta(
                BoxDecoration(borderRadius: style.borderRadius, color: colors.secondary),
                variants: {
                  [.disabled]: .delta(color: colors.disable(colors.secondary)),
                  [.hovered, .pressed]: .delta(color: colors.hover(colors.secondary)),
                },
              ),
              foregroundColor: colors.secondaryForeground,
              disabledForegroundColor: colors.disable(colors.secondaryForeground, colors.disable(colors.secondary)),
            ),
            [.destructive]: FButtonSizeStyles.inherit(
              typography: typography,
              style: style,
              decoration: .delta(
                BoxDecoration(
                  borderRadius: style.borderRadius,
                  color: colors.destructive.withValues(alpha: colors.brightness == .light ? 0.1 : 0.2),
                ),
                variants: {
                  [.disabled]: .delta(
                    color: colors.destructive.withValues(alpha: colors.brightness == .light ? 0.05 : 0.1),
                  ),
                  [.hovered, .pressed]: .delta(
                    color: colors.destructive.withValues(alpha: colors.brightness == .light ? 0.2 : 0.3),
                  ),
                },
              ),
              foregroundColor: colors.destructive,
              disabledForegroundColor: colors.destructive.withValues(alpha: 0.5),
            ),
            [.outline]: FButtonSizeStyles.inherit(
              typography: typography,
              style: style,
              decoration: .delta(
                BoxDecoration(
                  border: .all(color: colors.border),
                  borderRadius: style.borderRadius,
                  color: colors.background,
                ),
                variants: {
                  [.disabled]: .delta(border: .all(color: colors.disable(colors.border))),
                  [.hovered, .pressed]: .delta(color: colors.secondary),
                },
              ),
              foregroundColor: colors.secondaryForeground,
              disabledForegroundColor: colors.disable(colors.secondaryForeground),
            ),
            [.ghost]: FButtonSizeStyles.inherit(
              typography: typography,
              style: style,
              decoration: .delta(
                BoxDecoration(borderRadius: style.borderRadius),
                variants: {
                  [.disabled]: const .delta(),
                  [.hovered, .pressed]: .delta(color: colors.secondary),
                },
              ),
              foregroundColor: colors.secondaryForeground,
              disabledForegroundColor: colors.disable(colors.secondaryForeground),
            ),
          },
        ),
      );
}

/// An alias for `FVariants<FButtonSizeVariantConstraint, FButtonStyle, FButtonStyleDelta>`.
typedef FButtonSizes = FVariants<FButtonSizeVariantConstraint, FButtonStyle, FButtonStyleDelta>;

/// An alias for the [FButtonSizeStyles]' delta.
typedef FButtonSizesDelta =
    FVariantsDelta<FButtonSizeVariantConstraint, FButtonSizeVariant, FButtonStyle, FButtonStyleDelta>;

/// [FButtonStyle]'s size styles.
extension type FButtonSizeStyles._(FVariants<FButtonSizeVariantConstraint, FButtonStyle, FButtonStyleDelta> _)
    implements FVariants<FButtonSizeVariantConstraint, FButtonStyle, FButtonStyleDelta> {
  /// Creates a [FButtonSizeStyles] that inherits its properties.
  factory FButtonSizeStyles.inherit({
    required FTypography typography,
    required FStyle style,
    required FVariants<FTappableVariantConstraint, BoxDecoration, BoxDecorationDelta> decoration,
    required Color foregroundColor,
    required Color disabledForegroundColor,
  }) {
    FButtonStyle button({
      required TextStyle textStyle,
      required EdgeInsetsGeometry contentPadding,
      required double contentSpacing,
      required double iconSize,
      required EdgeInsetsGeometry iconPadding,
    }) => FButtonStyle(
      decoration: decoration,
      focusedOutlineStyle: style.focusedOutlineStyle,
      contentStyle: FButtonContentStyle(
        textStyle: .delta(
          textStyle,
          variants: {
            [.disabled]: .delta(color: disabledForegroundColor),
          },
        ),
        iconStyle: .delta(
          IconThemeData(color: foregroundColor, size: iconSize),
          variants: {
            [.disabled]: .delta(color: disabledForegroundColor),
          },
        ),
        circularProgressStyle: .delta(
          FCircularProgressStyle(
            iconStyle: IconThemeData(color: foregroundColor, size: iconSize),
          ),
          variants: {
            [.disabled]: .delta(iconStyle: .delta(color: disabledForegroundColor)),
          },
        ),
        padding: contentPadding,
        spacing: contentSpacing,
      ),
      iconContentStyle: FButtonIconContentStyle(
        iconStyle: .delta(
          IconThemeData(color: foregroundColor, size: iconSize),
          variants: {
            [.disabled]: .delta(color: disabledForegroundColor),
          },
        ),
        padding: iconPadding,
      ),
      tappableStyle: style.tappableStyle,
    );

    return FButtonSizeStyles._(
      FVariants(
        button(
          textStyle: typography.base.copyWith(
            color: foregroundColor,
            fontWeight: .w500,
            height: 1,
            leadingDistribution: .even,
          ),
          contentPadding: const .symmetric(horizontal: 16, vertical: 12),
          contentSpacing: 10,
          iconSize: 20,
          iconPadding: const .all(8),
        ),
        variants: {
          [.xs]: button(
            textStyle: typography.xs.copyWith(
              color: foregroundColor,
              fontWeight: .w500,
              height: 1,
              leadingDistribution: .even,
            ),
            contentPadding: const .symmetric(horizontal: 8, vertical: 8),
            contentSpacing: 6,
            iconSize: 14,
            iconPadding: const .all(7),
          ),
          [.sm]: button(
            textStyle: typography.sm.copyWith(
              color: foregroundColor,
              fontWeight: .w500,
              height: 1,
              leadingDistribution: .even,
            ),
            contentPadding: const .symmetric(horizontal: 12, vertical: 10),
            contentSpacing: 8,
            iconSize: 16,
            iconPadding: const .all(8),
          ),
          [.lg]: button(
            textStyle: typography.base.copyWith(
              color: foregroundColor,
              fontWeight: .w500,
              height: 1,
              leadingDistribution: .even,
            ),
            contentPadding: const .symmetric(horizontal: 32, vertical: 14),
            contentSpacing: 10,
            iconSize: 24,
            iconPadding: const .all(8),
          ),
        },
      ),
    );
  }
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
