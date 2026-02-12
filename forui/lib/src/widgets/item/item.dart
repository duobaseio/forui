import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/delta.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/widgets/item/item_content.dart';
import 'package:forui/src/widgets/item/raw_item_content.dart';

@Variants('FItem', {'destructive': (2, 'The destructive item style.')})
@Sentinels(FItemStyle, {'focusedOutlineStyle': 'focusedOutlineStyleSentinel'})
part 'item.design.dart';

/// A marker interface which denotes that mixed-in widgets is an item.
mixin FItemMixin on Widget {
  /// {@macro forui.widgets.FItem.new}
  ///
  /// This function is a shorthand for [FItem.new].
  static FItem item({
    required Widget title,
    Set<FItemVariant> variants = const {},
    FItemStyleDelta style = const .context(),
    bool? enabled,
    bool selected = false,
    String? semanticsLabel,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    FTappableVariantChangeCallback? onVariantChange,
    VoidCallback? onPress,
    VoidCallback? onLongPress,
    VoidCallback? onSecondaryPress,
    VoidCallback? onSecondaryLongPress,
    Map<ShortcutActivator, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    Widget? prefix,
    Widget? subtitle,
    Widget? details,
    Widget? suffix,
    Key? key,
  }) => .new(
    title: title,
    variants: variants,
    style: style,
    enabled: enabled,
    selected: selected,
    semanticsLabel: semanticsLabel,
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
    prefix: prefix,
    subtitle: subtitle,
    details: details,
    suffix: suffix,
    key: key,
  );

  /// {@macro forui.widgets.FItem.raw}
  ///
  /// This function is a shorthand for [FItem.raw].
  static FItem raw({
    required Widget child,
    Set<FItemVariant> variants = const {},
    FItemStyleDelta style = const .context(),
    bool? enabled,
    bool selected = false,
    String? semanticsLabel,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    FTappableVariantChangeCallback? onVariantChange,
    VoidCallback? onPress,
    VoidCallback? onLongPress,
    VoidCallback? onSecondaryPress,
    VoidCallback? onSecondaryLongPress,
    Map<ShortcutActivator, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    Widget? prefix,
    Key? key,
  }) => .raw(
    variants: variants,
    style: style,
    enabled: enabled,
    selected: selected,
    semanticsLabel: semanticsLabel,
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
    prefix: prefix,
    key: key,
    child: child,
  );
}

/// An item that is typically used to group related information together.
///
/// ## Using [FItem] in a [FPopover] when wrapped in a [FItemGroup]
/// When a [FPopover] is used inside an [FItemGroup], items inside the popover will inherit styling from the parent group.
/// This happens because [FPopover]'s content shares the same `BuildContext` as its child, causing data inheritance
/// that may lead to unexpected rendering issues.
///
/// To prevent this styling inheritance, wrap the popover in a [FInheritedItemData] with null data to reset the
/// inherited data:
/// ```dart
/// FItemGroup(
///   children: [
///     FItem(title: Text('Item with popover')),
///     FPopoverWrapperItem(
///       popoverBuilder: (_, _) => FInheritedItemData(
///         child: FItemGroup(
///           children: [
///             FItem(title: Text('Popover Item 1')),
///             FItem(title: Text('Popover Item 2')),
///           ],
///         ),
///       ),
///       child: FButton(child: Text('Open Popover')),
///     ),
///   ],
/// );
/// ```
///
/// See:
/// * https://forui.dev/docs/data/item for working examples.
/// * [FTile] for a specialized item for touch devices.
/// * [FItemStyle] for customizing an item's appearance.
class FItem extends StatelessWidget with FItemMixin {
  /// The variants used to resolve the style from [FItemStyles].
  ///
  /// Defaults to an empty set, which resolves to the base (primary) style. The current platform variant is automatically
  /// included during style resolution. To change the platform variant, update the enclosing
  /// [FTheme.platform]/[FAdaptiveScope.platform].
  ///
  /// For example, to create a destructive item:
  /// ```dart
  /// FItem(
  ///   variants: {FItemVariant.destructive},
  ///   title: Text('Delete'),
  /// )
  /// ```
  final Set<FItemVariant> variants;

  /// The item's style. Defaults to [FItemData.styles] if present.
  ///
  /// Provide a style to prevent inheritance from [FInheritedItemData].
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FItemStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create item
  /// ```
  final FItemStyleDelta style;

  /// Whether the item is enabled. Defaults to true.
  final bool? enabled;

  /// True if this item is currently selected. Defaults to false.
  final bool selected;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

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

  /// A callback for when the item is pressed.
  ///
  /// The item is not interactable if the following are all null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  final VoidCallback? onPress;

  /// A callback for when the item is long pressed.
  ///
  /// The item is not interactable if the following are all null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  final VoidCallback? onLongPress;

  /// A callback for when the widget is pressed with a secondary button (usually right-click on desktop).
  ///
  /// The item is not interactable if the following are all null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  final VoidCallback? onSecondaryPress;

  /// A callback for when the widget is pressed with a secondary button (usually right-click on desktop).
  ///
  /// The item is not interactable if the following are all null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  final VoidCallback? onSecondaryLongPress;

  /// {@macro forui.foundation.FTappable.shortcuts}
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// {@macro forui.foundation.FTappable.actions}
  final Map<Type, Action<Intent>>? actions;

  final Widget Function(
    BuildContext context,
    FItemStyle style,
    double top,
    double bottom,
    Set<FTappableVariant> variants,
    FVariants<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? color,
    double? width,
    FItemDivider divider,
  )
  _builder;

  /// {@template forui.widgets.FItem.new}
  /// Creates a [FItem].
  ///
  /// Assuming LTR locale:
  /// ```diagram
  /// -----------------------------------------------------
  /// | [prefix] [title]       [details] [suffix]         |
  /// |          [subtitle]                               |
  /// -----------------------------------------------------
  /// ```
  ///
  /// The order is reversed for RTL locales.
  ///
  /// ## Overflow behavior
  /// [FItem] has custom layout behavior to handle overflow of its content. If [details] is text, it is truncated,
  /// else [title] and [subtitle] are truncated.
  ///
  /// ## Why isn't my [title] [subtitle], or [details] rendered?
  /// Using widgets that try to fill the available space, such as [Expanded] or [FTextField], as [details] will cause
  /// the [title] and [subtitle] to never be rendered.
  ///
  /// Use [FItem.raw] in these cases.
  /// {@endtemplate}
  FItem({
    required Widget title,
    this.variants = const {},
    this.style = const .context(),
    this.enabled,
    this.selected = false,
    this.semanticsLabel,
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
    Widget? prefix,
    Widget? subtitle,
    Widget? details,
    Widget? suffix,
    super.key,
  }) : _builder = ((context, style, top, bottom, variants, color, width, divider) => ItemContent(
         style: style.contentStyle,
         margin: style.margin,
         top: top,
         bottom: bottom,
         variants: variants,
         dividerColor: color,
         dividerWidth: width,
         dividerType: divider,
         prefix: prefix,
         title: title,
         subtitle: subtitle,
         details: details,
         suffix: suffix,
       ));

  /// {@template forui.widgets.FItem.raw}
  /// Creates a [FItem] without custom layout behavior.
  ///
  /// Assuming LTR locale:
  /// ```diagram
  /// ----------------------------------------
  /// | [prefix] [child]                     |
  /// ----------------------------------------
  /// ```
  ///
  /// The order is reversed for RTL locales.
  /// {@endtemplate}
  FItem.raw({
    required Widget child,
    this.variants = const {},
    this.style = const .context(),
    this.enabled,
    this.selected = false,
    this.semanticsLabel,
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
    Widget? prefix,
    super.key,
  }) : _builder = ((context, style, top, bottom, variants, color, width, divider) => RawItemContent(
         style: style.rawItemContentStyle,
         margin: style.margin,
         top: top,
         bottom: bottom,
         variants: variants,
         dividerColor: color,
         dividerWidth: width,
         dividerType: divider,
         prefix: prefix,
         child: child,
       ));

  @override
  Widget build(BuildContext context) {
    final data = FInheritedItemData.maybeOf(context) ?? const FItemData();
    final style = this.style((data.styles ?? context.theme.itemStyles).resolve({...variants, context.platformVariant}));
    final enabled = this.enabled ?? data.enabled;
    final formVariants = <FTappableVariant>{
      context.platformVariant as FTappableVariant,
      if (!enabled) FTappableVariant.disabled,
    };
    final divider = data.divider;

    // We increase the bottom margin to draw the divider.
    final top = data.index == 0 ? data.spacing : 0.0;
    final bottom = data.last ? data.spacing : 0.0;

    var margin = style.margin.resolve(Directionality.maybeOf(context) ?? .ltr);
    margin = margin.copyWith(
      top: margin.top + top,
      bottom: margin.bottom + bottom + (divider == FItemDivider.none ? 0 : data.dividerWidth),
    );

    if (onPress == null && onLongPress == null && onSecondaryPress == null && onSecondaryLongPress == null) {
      return ColoredBox(
        color: style.backgroundColor.resolve(formVariants) ?? Colors.transparent,
        child: Padding(
          padding: margin,
          child: DecoratedBox(
            decoration: style.decoration.resolve(formVariants),
            child: _builder(context, style, top, bottom, formVariants, data.dividerColor, data.dividerWidth, divider),
          ),
        ),
      );
    }

    return ColoredBox(
      color: style.backgroundColor.resolve(formVariants) ?? Colors.transparent,
      child: Padding(
        padding: margin,
        child: FTappable(
          style: style.tappableStyle,
          semanticsLabel: semanticsLabel,
          autofocus: autofocus,
          focusNode: focusNode,
          onFocusChange: onFocusChange,
          onHoverChange: onHoverChange,
          onVariantChange: onVariantChange,
          selected: selected,
          onPress: enabled ? (onPress ?? () {}) : null,
          onLongPress: enabled ? (onLongPress ?? () {}) : null,
          onSecondaryPress: enabled ? (onSecondaryPress ?? () {}) : null,
          onSecondaryLongPress: enabled ? (onSecondaryLongPress ?? () {}) : null,
          shortcuts: shortcuts,
          actions: actions,
          builder: (context, variants, _) => DecoratedBox(
            position: .foreground,
            decoration: switch (style.focusedOutlineStyle) {
              final outline? when variants.contains(FTappableVariant.focused) => BoxDecoration(
                border: .all(color: outline.color, width: outline.width),
                borderRadius: outline.borderRadius,
              ),
              _ => const BoxDecoration(),
            },
            child: DecoratedBox(
              decoration: style.decoration.resolve(variants),
              child: _builder(context, style, top, bottom, variants, data.dividerColor, data.dividerWidth, divider),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty('variants', variants))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
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

/// The item styles.
extension type FItemStyles._(FVariants<FItemVariantConstraint, FItemVariant, FItemStyle, FItemStyleDelta> _)
    implements FVariants<FItemVariantConstraint, FItemVariant, FItemStyle, FItemStyleDelta> {
  /// Creates a [FItemStyles] that inherits its properties.
  FItemStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this._(
        FVariants.from(
          .inherit(colors: colors, typography: typography, style: style),
          variants: {
            [.destructive]: .delta(
              contentStyle: FItemContentStyle.inherit(
                colors: colors,
                typography: typography,
                prefix: colors.destructive,
                foreground: colors.destructive,
                mutedForeground: colors.destructive,
              ),
              rawItemContentStyle: FRawItemContentStyle.inherit(
                colors: colors,
                typography: typography,
                prefix: colors.primary,
                color: colors.primary,
              ),
            ),
          },
        ),
      );
}

/// A [FItem]'s style.
class FItemStyle with Diagnosticable, _$FItemStyleFunctions {
  /// The item's background color.
  ///
  /// It is applied to the entire item, including [margin]. Since it is applied before [decoration] in the z-layer,
  /// it is not visible if [decoration] has a background color.
  ///
  /// This is useful for setting a background color when [margin] is not zero.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, Color?, Delta> backgroundColor;

  /// The margin around the item, including the [decoration].
  ///
  /// Defaults to `const EdgeInsets.symmetric(vertical: 2, horizontal: 4)`.
  @override
  final EdgeInsetsGeometry margin;

  /// The item's decoration.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, BoxDecoration, BoxDecorationDelta> decoration;

  /// The default item content's style.
  @override
  final FItemContentStyle contentStyle;

  /// THe default raw item content's style.
  @override
  final FRawItemContentStyle rawItemContentStyle;

  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle? focusedOutlineStyle;

  /// Creates a [FItemStyle].
  FItemStyle({
    required this.backgroundColor,
    required this.decoration,
    required this.contentStyle,
    required this.rawItemContentStyle,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    this.margin = const .symmetric(vertical: 2, horizontal: 4),
  });

  /// Creates a [FTileGroupStyle] that inherits from the given arguments.
  FItemStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        backgroundColor: FVariants(
          colors.background,
          variants: {
            [.disabled]: colors.background,
          },
        ),
        decoration: FVariants.from(
          BoxDecoration(color: colors.background, borderRadius: style.borderRadius),
          variants: {
            [.hovered, .pressed]: .delta(color: colors.secondary),
            //
            [.disabled]: const .delta(),
            //
            [.selected]: .delta(color: colors.secondary),
            [.selected.and(.disabled)]: .delta(color: colors.disable(colors.secondary)),
          },
        ),
        contentStyle: .inherit(
          colors: colors,
          typography: typography,
          prefix: colors.primary,
          foreground: colors.foreground,
          mutedForeground: colors.mutedForeground,
        ),
        rawItemContentStyle: .inherit(
          colors: colors,
          typography: typography,
          prefix: colors.foreground,
          color: colors.foreground,
        ),
        tappableStyle: style.tappableStyle.copyWith(
          motion: FTappableMotion.none,
          pressedEnterDuration: .zero,
          pressedExitDuration: const Duration(milliseconds: 25),
        ),
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}
