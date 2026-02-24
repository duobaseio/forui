import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:forui/src/widgets/select/content/inherited_controller.dart';

@Variants('FSelectSection', {
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
})
part 'select_item.design.dart';

Widget? _defaultSuffixBuilder(BuildContext _, bool selected) => selected ? const Icon(FIcons.check) : null;

/// A marker interface which denotes that mixed-in widgets can be used in a [FSelect].
mixin FSelectItemMixin on Widget {
  /// {@macro forui.widgets.FSelectSection.new}
  ///
  /// For more control over the items' appearances, use [richSection].
  ///
  /// This function is a shorthand for [FSelectSection.new].
  static FSelectSection<T> section<T>({
    required Widget label,
    required Map<String, T> items,
    FSelectSectionStyleDelta style = const .context(),
    bool? enabled,
    FItemDivider divider = .none,
    Key? key,
  }) => .new(label: label, items: items, style: style, enabled: enabled, divider: divider, key: key);

  /// {@macro forui.widgets.FSelectSection.rich}
  ///
  /// This function is a shorthand for [FSelectSection.rich].
  static FSelectSection<T> richSection<T>({
    required Widget label,
    required List<FSelectItem<T>> children,
    FSelectSectionStyleDelta style = const .context(),
    bool? enabled,
    FItemDivider divider = .none,
    Key? key,
  }) => .rich(label: label, style: style, enabled: enabled, divider: divider, key: key, children: children);

  /// {@macro forui.widgets.FSelectItem.new}
  ///
  /// For even more control over the item's appearance, use [raw].
  ///
  /// This function is a shorthand for [FSelectItem.new].
  static FSelectItem<T> item<T>({
    required Widget title,
    required T value,
    FItemStyleDelta style = const .context(),
    bool? enabled,
    Widget? prefix,
    Widget? subtitle,
    // ignore: avoid_positional_boolean_parameters
    Widget? Function(BuildContext context, bool selected) suffixBuilder = _defaultSuffixBuilder,
    Key? key,
  }) => .new(
    title: title,
    value: value,
    style: style,
    enabled: enabled,
    prefix: prefix,
    subtitle: subtitle,
    suffixBuilder: suffixBuilder,
    key: key,
  );

  /// {@macro forui.widgets.FSelectItem.raw}
  ///
  /// This function is a shorthand for [FSelectItem.raw].
  static FSelectItem<T> raw<T>({
    required Widget child,
    required T value,
    FItemStyleDelta style = const .context(),
    bool? enabled,
    Widget? prefix,
    Key? key,
  }) => .raw(value: value, style: style, enabled: enabled, prefix: prefix, key: key, child: child);
}

/// A section in a [FSelect] that can contain multiple [FSelectItem]s.
class FSelectSection<T> extends StatelessWidget with FSelectItemMixin {
  /// The style. Defaults to the [FSelectSectionStyle] inherited from the parent [FSelect].
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FSelectSectionStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create select-section
  /// ```
  final FSelectSectionStyleDelta style;

  /// True if the section is enabled. Disabled sections cannot be selected, and is skipped during traversal.
  ///
  /// Defaults to inheriting from the [FSelect].
  final bool? enabled;

  /// The divider style. Defaults to the [FItemDivider] inherited from the parent [FSelect]. Defaults to
  /// [FItemDivider.none].
  final FItemDivider divider;

  /// The label.
  final Widget label;

  /// The nested [FSelectItem]s.
  final List<FSelectItem<T>> children;

  /// {@template forui.widgets.FSelectSection.new}
  /// Creates a [FSelectSection] from the given [items].
  ///
  /// For more control over the items' appearances, use [FSelectSection.rich].
  /// {@endtemplate}
  FSelectSection({
    required Widget label,
    required Map<String, T> items,
    FSelectSectionStyleDelta style = const .context(),
    bool? enabled,
    FItemDivider divider = .none,
    Key? key,
  }) : this.rich(
         label: label,
         children: [for (final e in items.entries) .item(title: Text(e.key), value: e.value)],
         style: style,
         enabled: enabled,
         divider: divider,
         key: key,
       );

  /// {@template forui.widgets.FSelectSection.rich}
  /// Creates a [FSelectSection] with the given [children].
  /// {@endtemplate}
  const FSelectSection.rich({
    required this.label,
    required this.children,
    this.style = const .context(),
    this.enabled,
    this.divider = .none,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final content = ContentData.of<T>(context);
    final enabled = this.enabled ?? content.enabled;
    final style = this.style(content.style);

    return ContentData<T>(
      style: style,
      enabled: enabled,
      autofocusFirst: false,
      autofocus: content.autofocus,
      visible: content.visible,
      ensureVisible: content.ensureVisible,
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          DefaultTextStyle.merge(
            style: style.labelTextStyle.resolve({if (!enabled) FSelectSectionVariant.disabled}),
            child: Padding(padding: style.labelPadding, child: label),
          ),
          // There is an edge case where a non-first, enabled child of a disabled section will not be auto-focused.
          // No feasible solution that doesn't involve a lot of complexity exists.
          if (children.firstOrNull case final first?)
            ContentData<T>(
              style: style,
              enabled: enabled,
              autofocusFirst: content.autofocusFirst,
              autofocus: content.autofocus,
              visible: content.visible,
              ensureVisible: content.ensureVisible,
              child: FInheritedItemData.merge(
                styles: .all(style.itemStyle),
                divider: divider,
                index: 0,
                last: children.length == 1,
                child: first,
              ),
            ),
          for (final (i, child) in children.indexed.skip(1))
            FInheritedItemData.merge(
              styles: .all(style.itemStyle),
              divider: divider,
              index: i,
              last: i == children.length - 1,
              child: child,
            ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(EnumProperty('divider', divider));
  }
}

/// A [FSelectSection]'s style.
class FSelectSectionStyle with Diagnosticable, _$FSelectSectionStyleFunctions {
  /// The label's text style.
  @override
  final FVariants<FSelectSectionVariantConstraint, FSelectSectionVariant, TextStyle, TextStyleDelta> labelTextStyle;

  /// The padding around the label. Defaults to `EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10)`.
  @override
  final EdgeInsetsGeometry labelPadding;

  /// The divider's style.
  @override
  final FVariants<FSelectSectionVariantConstraint, FSelectSectionVariant, Color, Delta> dividerColor;

  /// The divider's width.
  @override
  final double dividerWidth;

  /// The section's items' style.
  @override
  final FItemStyle itemStyle;

  /// Creates a [FSelectSectionStyle].
  FSelectSectionStyle({
    required this.labelTextStyle,
    required this.dividerColor,
    required this.dividerWidth,
    required this.itemStyle,
    this.labelPadding = const .directional(start: 15, top: 7.5, bottom: 7.5, end: 10),
  });

  /// Creates a [FSelectSectionStyle] that inherits its properties.
  factory FSelectSectionStyle.inherit({
    required FColors colors,
    required FStyle style,
    required FTypography typography,
  }) {
    const padding = EdgeInsetsDirectional.only(start: 11, top: 7.5, bottom: 7.5, end: 6);
    final iconStyle = FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>.from(
      IconThemeData(color: colors.foreground, size: 15),
      variants: {
        [.disabled]: .delta(color: colors.disable(colors.foreground)),
      },
    );
    final textStyle = FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>.from(
      typography.sm.copyWith(color: colors.foreground),
      variants: {
        [.disabled]: .delta(color: colors.disable(colors.foreground)),
      },
    );

    return .new(
      labelTextStyle: FVariants.from(
        typography.sm.copyWith(color: colors.foreground, fontWeight: .w600),
        variants: {
          [.disabled]: .delta(color: colors.disable(colors.foreground)),
        },
      ),
      dividerColor: .all(colors.border),
      dividerWidth: style.borderWidth,
      itemStyle: FItemStyle(
        backgroundColor: const .all(null),
        decoration: FVariants.from(
          const ShapeDecoration(shape: RoundedSuperellipseBorder()),
          variants: {
            [.focused, .hovered, .pressed]: .shapeDelta(
              shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md),
              color: colors.secondary,
            ),
            //
            [.disabled]: const .shapeDelta(),
          },
        ),
        contentStyle:
            .inherit(
              colors: colors,
              typography: typography,
              prefix: colors.foreground,
              foreground: colors.foreground,
              mutedForeground: colors.mutedForeground,
            ).copyWith(
              padding: const .value(padding),
              prefixIconStyle: iconStyle,
              prefixIconSpacing: 10,
              titleTextStyle: textStyle,
              titleSpacing: 4,
              suffixIconStyle: iconStyle,
            ),
        rawItemContentStyle: FRawItemContentStyle(
          padding: padding,
          prefixIconStyle: iconStyle,
          childTextStyle: textStyle,
        ),
        tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
        focusedOutlineStyle: null,
      ),
    );
  }
}

/// A selectable item in a [FSelect] that can optionally be nested in a [FSelectSection].
abstract class FSelectItem<T> extends StatefulWidget with FSelectItemMixin {
  /// The style. Defaults to the [FItemStyle] inherited from the parent [FSelectSection] or [FSelect].
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
  /// dart run forui style create select-section
  /// ```
  final FItemStyleDelta style;

  /// The value.
  final T value;

  /// True if the item is enabled. Disabled items cannot be selected, and is skipped during traversal.
  ///
  /// Defaults to the value inherited from the parent [FSelectSection] or [FSelect].
  final bool? enabled;

  /// A prefix.
  final Widget? prefix;

  /// {@template forui.widgets.FSelectItem.new}
  /// Creates a [FSelectItem] with a custom [title] and value.
  /// {@endtemplate}
  const factory FSelectItem({
    required Widget title,
    required T value,
    FItemStyleDelta style,
    bool? enabled,
    Widget? prefix,
    Widget? subtitle,
    // ignore: avoid_positional_boolean_parameters
    Widget? Function(BuildContext context, bool selected) suffixBuilder,
    Key? key,
  }) = _SelectItem<T>;

  /// Creates a [FSelectItem] with a custom [title] and value.
  ///
  /// This is identical to [FSelectItem.new]. It provides consistency with other [FSelectItemMixin] members when using
  /// dot-shorthands.
  const factory FSelectItem.item({
    required Widget title,
    required T value,
    FItemStyleDelta style,
    bool? enabled,
    Widget? prefix,
    Widget? subtitle,
    // ignore: avoid_positional_boolean_parameters
    Widget? Function(BuildContext context, bool selected) suffixBuilder,
    Key? key,
  }) = FSelectItem<T>;

  /// {@template forui.widgets.FSelectItem.raw}
  /// Creates a [FSelectItem] with a raw layout.
  /// {@endtemplate}
  const factory FSelectItem.raw({
    required Widget child,
    required T value,
    FItemStyleDelta style,
    bool? enabled,
    Widget? prefix,
    Key? key,
  }) = _RawSelectItem<T>;

  const FSelectItem._({required this.value, this.style = const .context(), this.enabled, this.prefix, super.key});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('value', value))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}

abstract class _State<W extends FSelectItem<T>, T> extends State<W> {
  late final FocusNode _focus = .new(debugLabel: widget.value.toString());

  @override
  void initState() {
    super.initState();

    // This is hacky but I'm not sure how to properly do this.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      final content = ContentData.of<T>(context);
      if (content.visible(widget.value)) {
        content.ensureVisible(context);
      }
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InheritedSelectController(:popover, :contains, :onPress) = .of<T>(context);
    final content = ContentData.of<T>(context);

    return _item(
      context,
      widget.enabled ?? content.enabled,
      contains(widget.value),
      content.autofocus(widget.value) || content.autofocusFirst,
      (previous, current) {
        final added = current.difference(previous);
        final removed = previous.difference(current);

        if (added.contains(FTappableVariant.hovered) ||
            (!previous.contains(FTappableVariant.hovered) && added.contains(FTappableVariant.pressed))) {
          _focus.requestFocus();
        } else if (removed.contains(FTappableVariant.hovered) ||
            (!current.contains(FTappableVariant.hovered) && removed.contains(FTappableVariant.pressed))) {
          _focus.unfocus();
        }
      },
      () => onPress(widget.value),
    );
  }

  Widget _item(
    BuildContext context,
    bool enabled,
    bool selected,
    bool focused,
    FTappableVariantChangeCallback onVariantChange,
    VoidCallback onPress,
  );
}

class _SelectItem<T> extends FSelectItem<T> {
  final Widget? subtitle;
  final Widget title;

  // ignore: avoid_positional_boolean_parameters
  final Widget? Function(BuildContext context, bool selected) suffixBuilder;

  const _SelectItem({
    required this.title,
    required super.value,
    this.subtitle,
    this.suffixBuilder = _defaultSuffixBuilder,
    super.style,
    super.enabled,
    super.prefix,
    super.key,
  }) : super._();

  @override
  State<_SelectItem<T>> createState() => _SelectItemState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder));
  }
}

class _SelectItemState<T> extends _State<_SelectItem<T>, T> {
  @override
  Widget _item(
    BuildContext context,
    bool enabled,
    bool selected,
    bool focused,
    FTappableVariantChangeCallback onVariantChange,
    VoidCallback onPress,
  ) => FItem(
    style: widget.style,
    enabled: enabled,
    selected: selected,
    autofocus: focused,
    focusNode: _focus,
    onVariantChange: onVariantChange,
    onPress: onPress,
    prefix: widget.prefix,
    title: widget.title,
    subtitle: widget.subtitle,
    suffix: widget.suffixBuilder(context, selected),
  );
}

class _RawSelectItem<T> extends FSelectItem<T> {
  final Widget child;

  const _RawSelectItem({required this.child, required super.value, super.style, super.enabled, super.prefix, super.key})
    : super._();

  @override
  _RawSelectItemState<T> createState() => _RawSelectItemState<T>();
}

class _RawSelectItemState<T> extends _State<_RawSelectItem<T>, T> {
  @override
  Widget _item(
    BuildContext context,
    bool enabled,
    bool selected,
    bool focused,
    FTappableVariantChangeCallback onVariantChange,
    VoidCallback onPress,
  ) => FItem.raw(
    style: widget.style,
    enabled: enabled,
    selected: selected,
    autofocus: focused,
    focusNode: _focus,
    onVariantChange: onVariantChange,
    onPress: onPress,
    prefix: widget.prefix,
    child: widget.child,
  );
}
