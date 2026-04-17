import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FItemGroup', {
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
})
part 'item_group.design.dart';

/// A marker interface which denotes that mixed-in widgets can group items and be used in a [FItemGroup.merge].
mixin FItemGroupMixin on Widget {
  /// {@macro forui.widgets.FItemGroup.new}
  static FItemGroup group({
    required List<FItemMixin> children,
    FItemGroupStyleDelta style = const .context(),
    ScrollController? scrollController,
    double? cacheExtent,
    double maxHeight = .infinity,
    DragStartBehavior dragStartBehavior = .start,
    ScrollPhysics physics = const ClampingScrollPhysics(),
    bool? enabled,
    bool? intrinsicWidth,
    FItemDivider divider = .none,
    String? semanticsLabel,
    Key? key,
  }) => .new(
    style: style,
    scrollController: scrollController,
    cacheExtent: cacheExtent,
    maxHeight: maxHeight,
    dragStartBehavior: dragStartBehavior,
    physics: physics,
    enabled: enabled,
    intrinsicWidth: intrinsicWidth,
    divider: divider,
    semanticsLabel: semanticsLabel,
    key: key,
    children: children,
  );

  /// {@macro forui.widgets.FItemGroup.builder}
  static FItemGroup builder({
    required NullableIndexedWidgetBuilder itemBuilder,
    int? count,
    FItemGroupStyleDelta style = const .context(),
    ScrollController? scrollController,
    double? cacheExtent,
    double maxHeight = .infinity,
    DragStartBehavior dragStartBehavior = .start,
    ScrollPhysics physics = const ClampingScrollPhysics(),
    bool? enabled,
    FItemDivider divider = .none,
    String? semanticsLabel,
    Key? key,
  }) => .builder(
    itemBuilder: itemBuilder,
    count: count,
    style: style,
    scrollController: scrollController,
    cacheExtent: cacheExtent,
    maxHeight: maxHeight,
    dragStartBehavior: dragStartBehavior,
    physics: physics,
    enabled: enabled,
    divider: divider,
    semanticsLabel: semanticsLabel,
    key: key,
  );

  /// {@macro forui.widgets.FItemGroup.merge}
  static FItemGroup merge({
    required List<FItemGroupMixin> children,
    FItemGroupStyleDelta style = const .context(),
    ScrollController? scrollController,
    double? cacheExtent,
    double maxHeight = .infinity,
    DragStartBehavior dragStartBehavior = .start,
    ScrollPhysics physics = const ClampingScrollPhysics(),
    bool? enabled,
    bool? intrinsicWidth,
    FItemDivider divider = .full,
    String? semanticsLabel,
    Key? key,
  }) => .merge(
    style: style,
    scrollController: scrollController,
    cacheExtent: cacheExtent,
    maxHeight: maxHeight,
    dragStartBehavior: dragStartBehavior,
    physics: physics,
    enabled: enabled,
    intrinsicWidth: intrinsicWidth,
    divider: divider,
    semanticsLabel: semanticsLabel,
    key: key,
    children: children,
  );
}

/// An item group that groups multiple [FItemMixin]s together.
///
/// Items grouped together will be separated by a divider, specified by [divider].
///
/// ## Using [FItemGroup] in a [FPopover] when wrapped in a [FItemGroup]
/// When a [FPopover] is used inside an [FItemGroup], items & groups inside the popover will inherit styling from the
/// parent group. This happens because [FPopover]'s content shares the same `BuildContext` as its child, causing data
/// inheritance that may lead to unexpected rendering issues.
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
/// {@macro forui.foundation.doc_templates.overlay}
///
///
/// See:
/// * https://forui.dev/docs/data/item-group for working examples.
/// * [FItemGroupStyle] for customizing a item group's appearance.
class FItemGroup extends StatelessWidget with FItemGroupMixin {
  /// The style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FItemGroupStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create item-group
  /// ```
  final FItemGroupStyleDelta style;

  /// {@template forui.widgets.FItemGroup.scrollController}
  /// The scroll controller used to control the position to which this group is scrolled.
  ///
  /// Scrolling past the end of the group using the controller will result in undefined behavior.
  ///
  /// It is ignored if the group is part of a merged [FItemGroup].
  /// {@endtemplate}
  final ScrollController? scrollController;

  /// {@template forui.widgets.FItemGroup.cacheExtent}
  /// The scrollable area's cache extent in logical pixels.
  ///
  /// Items that fall in this cache area are laid out even though they are not (yet) visible on screen. It describes
  /// how many pixels the cache area extends before the leading edge and after the trailing edge of the viewport.
  ///
  /// It is ignored if the group is part of a merged [FItemGroup] or if [intrinsicWidth] is true.
  /// {@endtemplate}
  final double? cacheExtent;

  /// {@template forui.widgets.FItemGroup.maxHeight}
  /// The max height, in logical pixels. Defaults to infinity.
  ///
  /// It is ignored if the group is part of a merged [FItemGroup].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [maxHeight] is not positive.
  /// {@endtemplate}
  final double maxHeight;

  /// {@template forui.widgets.FItemGroup.dragStartBehavior}
  /// Determines the way that drag start behavior is handled. Defaults to [DragStartBehavior.start].
  ///
  /// It is ignored if the group is part of a merged [FItemGroup].
  /// {@endtemplate}
  final DragStartBehavior dragStartBehavior;

  /// {@template forui.widgets.FItemGroup.physics}
  /// The scroll physics of the group. Defaults to [ClampingScrollPhysics].
  /// {@endtemplate}
  final ScrollPhysics physics;

  /// {@template forui.widgets.FItemGroup.divider}
  /// The divider between items.
  /// {@endtemplate}
  ///
  /// Defaults to [FItemDivider.indented].
  final FItemDivider divider;

  /// True if the group is enabled. Defaults to true.
  final bool? enabled;

  /// {@template forui.widgets.FItemGroup.intrinsicWidth}
  /// Whether the group should intrinsically size to the widest child. Defaults to false.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * an [FItemGroup.builder] is used in an intrinsic [FItemGroup.merge].
  /// * a non-intrinsic [FItemGroup] is used in an intrinsic [FItemGroup.merge].
  /// * an intrinsic [FItemGroup] is used in a non-intrinsic [FItemGroup.merge].
  /// {@endtemplate}
  final bool? intrinsicWidth;

  /// The group's semantic label.
  ///
  /// It is ignored if the group is part of a merged [FItemGroup].
  final String? semanticsLabel;

  /// The delegate that builds the children.
  // ignore: avoid_positional_boolean_parameters
  final Widget Function(FItemGroupStyle style, bool enabled, bool intrinsicWidth) _builder;

  /// {@template forui.widgets.FItemGroup.new}
  /// Creates a [FItemGroup].
  /// {@endtemplate}
  FItemGroup({
    required List<FItemMixin> children,
    this.style = const .context(),
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.dragStartBehavior = .start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.intrinsicWidth,
    this.divider = .none,
    this.semanticsLabel,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       _builder = ((style, enabled, intrinsicWidth) {
         final nested = [
           for (final (index, child) in children.indexed)
             FInheritedItemData.merge(
               styles: style.itemStyles,
               spacing: style.spacing,
               enabled: enabled,
               intrinsicWidth: intrinsicWidth,
               dividerColor: style.dividerColor,
               dividerWidth: style.dividerWidth,
               divider: divider,
               index: index,
               last: index == children.length - 1,
               child: child,
             ),
         ];
         return intrinsicWidth ? Column(mainAxisSize: .min, children: nested) : SliverList.list(children: nested);
       });

  /// {@template forui.widgets.FItemGroup.builder}
  /// Creates a [FItemGroup] that lazily builds its children.
  ///
  /// The [itemBuilder] is called for each item that should be built. The current level's [FInheritedItemData] is **not**
  /// visible to `itemBuilder`.
  /// * It may return null to signify the end of the group.
  /// * It may be called more than once for the same index.
  /// * It will be called only for indices <= [count] if [count] is given.
  ///
  /// The [count] is the number of items to build. If null, [itemBuilder] will be called until it returns null.
  ///
  /// # Contract
  /// Throws [AssertionError] if used in a intrinsic [FItemGroup.merge].
  ///
  /// ## Notes
  /// May result in an infinite loop or run out of memory if:
  /// * Placed in a parent widget that does not constrain its size, i.e. [Column].
  /// * [count] is null and [itemBuilder] always provides a zero-size widget, i.e. SizedBox(). If possible, provide
  ///   items with non-zero size, return null from builder, or set [count] to non-null.
  /// {@endtemplate}
  FItemGroup.builder({
    required NullableIndexedWidgetBuilder itemBuilder,
    int? count,
    this.style = const .context(),
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.dragStartBehavior = .start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.divider = .none,
    this.semanticsLabel,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       assert(count == null || 0 <= count, 'count ($count) must be >= 0'),
       intrinsicWidth = null,
       _builder = ((style, enabled, intrinsicWidth) {
         assert(!intrinsicWidth, 'FItemGroup.builder does not support intrinsic width.');
         return SliverList.builder(
           itemCount: count,
           itemBuilder: (context, index) {
             if (itemBuilder(context, index) case final item?) {
               return FInheritedItemData.merge(
                 styles: style.itemStyles,
                 spacing: style.spacing,
                 enabled: enabled,
                 dividerColor: style.dividerColor,
                 dividerWidth: style.dividerWidth,
                 divider: divider,
                 index: index,
                 last: (count != null && index == count - 1) || itemBuilder(context, index + 1) == null,
                 child: item,
               );
             }

             return null;
           },
         );
       });

  /// {@template forui.widgets.FItemGroup.merge}

  /// Creates a [FItemGroup] that merges multiple [FItemGroupMixin]s together.
  ///
  /// All group labels will be ignored.
  /// {@endtemplate}
  FItemGroup.merge({
    required List<FItemGroupMixin> children,
    this.style = const .context(),
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.dragStartBehavior = .start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.intrinsicWidth,
    this.divider = .full,
    this.semanticsLabel,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       _builder = ((style, enabled, intrinsicWidth) {
         final nested = [
           for (final (index, child) in children.indexed)
             FInheritedItemData.merge(
               styles: style.itemStyles,
               spacing: style.spacing,
               enabled: enabled,
               intrinsicWidth: intrinsicWidth,
               dividerColor: style.dividerColor,
               dividerWidth: style.dividerWidth,
               divider: divider,
               index: index,
               last: index == children.length - 1,
               child: child,
             ),
         ];
         return intrinsicWidth ? Column(mainAxisSize: .min, children: nested) : SliverMainAxisGroup(slivers: nested);
       });

  /// {@macro forui.widgets.FItemGroup.new}
  ///
  /// This function is a shorthand for [FItemGroup.new].
  FItemGroup.group({
    required List<FItemMixin> children,
    FItemGroupStyleDelta style = const .context(),
    ScrollController? scrollController,
    double? cacheExtent,
    double maxHeight = .infinity,
    DragStartBehavior dragStartBehavior = .start,
    ScrollPhysics physics = const ClampingScrollPhysics(),
    bool? enabled,
    bool? intrinsicWidth,
    FItemDivider divider = .none,
    String? semanticsLabel,
    Key? key,
  }) : this(
         children: children,
         style: style,
         scrollController: scrollController,
         cacheExtent: cacheExtent,
         maxHeight: maxHeight,
         dragStartBehavior: dragStartBehavior,
         physics: physics,
         enabled: enabled,
         intrinsicWidth: intrinsicWidth,
         divider: divider,
         semanticsLabel: semanticsLabel,
         key: key,
       );

  @override
  Widget build(BuildContext context) {
    final data = FInheritedItemData.maybeOf(context);
    final style = this.style(FItemGroupStyleData.of(context));
    final enabled = this.enabled ?? data?.enabled ?? true;
    final intrinsicWidth = this.intrinsicWidth ?? data?.intrinsicWidth ?? false;

    // When nested.
    if (data != null) {
      return _builder(style, enabled, intrinsicWidth);
    }

    // When root.
    Widget child = FItemGroupStyleData(
      style: style,
      child: intrinsicWidth
          ? IntrinsicWidth(
              child: SingleChildScrollView(
                controller: scrollController,
                dragStartBehavior: dragStartBehavior,
                physics: physics,
                child: _builder(style, enabled, true),
              ),
            )
          : CustomScrollView(
              controller: scrollController,
              cacheExtent: cacheExtent,
              dragStartBehavior: dragStartBehavior,
              shrinkWrap: true,
              physics: physics,
              slivers: [_builder(style, enabled, false)],
            ),
    );

    if (maxHeight.isInfinite && style.slideableItems.resolve({context.platformVariant})) {
      child = FTappableGroup(slidePressHapticFeedback: style.slidePressHapticFeedback, child: child);
    }

    return Semantics(
      container: true,
      label: semanticsLabel,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        // We use a Container instead of DecoratedBox as using a DecoratedBox will cause the border to be clipped.
        // ignore: use_decorated_box
        child: Container(
          decoration: style.decoration,
          child: switch (style.decoration) {
            ShapeDecoration(:final shape) => ClipPath(
              clipper: ShapeBorderClipper(shape: shape, textDirection: Directionality.maybeOf(context)),
              child: child,
            ),
            BoxDecoration(:final borderRadius?) => ClipRRect(borderRadius: borderRadius, child: child),
            _ => child,
          },
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('controller', scrollController))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('intrinsicWidth', value: intrinsicWidth, ifTrue: 'intrinsicWidth'))
      ..add(EnumProperty('divider', divider))
      ..add(StringProperty('semanticsLabel', semanticsLabel));
  }
}

/// An inherited widget that provides the [FItemGroupStyle] to its descendants.
class FItemGroupStyleData extends InheritedWidget {
  /// Returns the [FItemGroupStyle] in the given [context], or null if none is found.
  static FItemGroupStyle? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FItemGroupStyleData>()?.style;

  /// Returns the [FItemGroupStyle] in the given [context].
  static FItemGroupStyle of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FItemGroupStyleData>()?.style ?? context.theme.itemGroupStyle;

  /// The style of the group.
  final FItemGroupStyle style;

  /// Creates a [FItemGroupStyleData].
  const FItemGroupStyleData({required this.style, required super.child, super.key});

  @override
  bool updateShouldNotify(FItemGroupStyleData old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// An [FItemGroup]'s style.
///
/// {@template forui.widgets.item.FItemGroupStyle}
/// ```diagram
/// ┌─ decoration ───────────────────────────────┐
/// │  ↕ spacing                                 │
/// │  ┌─ FItemStyle ──────────────────────────┐ │
/// │  │  item                                 │ │
/// │  └───────────────────────────────────────┘ │
/// │  ── dividerColor ── ↕ dividerWidth ─────── │
/// │  ┌─ FItemStyle ──────────────────────────┐ │
/// │  │  item                                 │ │
/// │  └───────────────────────────────────────┘ │
/// │  ↕ spacing                                 │
/// └────────────────────────────────────────────┘
/// ```
/// {@endtemplate}
class FItemGroupStyle with Diagnosticable, _$FItemGroupStyleFunctions {
  /// The group's decoration, painted below [FItemStyle.backgroundColor] and [FItemStyle.contentDecoration].
  ///
  /// As it is below [FItemStyle.backgroundColor], setting a [FItemStyle.backgroundColor]/[FItemStyle.contentDecoration]
  /// will paint over the decoration's color.
  @override
  final Decoration decoration;

  /// The vertical spacing at the top and bottom of each group. Defaults to 4.
  @override
  final double spacing;

  /// The divider's style.
  @override
  final FVariants<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta> dividerColor;

  /// The divider's width.
  @override
  final double dividerWidth;

  /// The item's styles.
  @override
  final FVariants<FItemVariantConstraint, FItemVariant, FItemStyle, FItemStyleDelta> itemStyles;

  /// Whether the items support pressing an item and sliding to another. Defaults to true.
  ///
  /// This is ignored if the item group's content is scrollable, i.e. `maxHeight` is finite.
  @override
  final FVariants<FItemGroupVariantConstraint, FItemGroupVariant, bool, Delta> slideableItems;

  /// The haptic feedback for when the user slides from one item to another when [slideableItems] is enabled.
  @override
  final Future<void> Function() slidePressHapticFeedback;

  /// Creates a [FItemGroupStyle].
  FItemGroupStyle({
    required this.decoration,
    required this.dividerColor,
    required this.dividerWidth,
    required this.itemStyles,
    required this.slidePressHapticFeedback,
    this.slideableItems = const .all(true),
    this.spacing = 4,
  });

  /// Creates a [FItemGroupStyle] that inherits from the given arguments.
  FItemGroupStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required FHapticFeedback hapticFeedback,
    required bool touch,
  }) : this(
         decoration: ShapeDecoration(shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md)),
         dividerColor: .all(colors.border),
         dividerWidth: style.borderWidth,
         slideableItems: const .all(true),
         slidePressHapticFeedback: hapticFeedback.selectionClick,
         itemStyles: FItemStyles.inherit(colors: colors, typography: typography, style: style, touch: touch),
       );
}
