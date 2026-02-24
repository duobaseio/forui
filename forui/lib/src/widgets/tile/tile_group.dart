import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/tile/tile.dart';

part 'tile_group.design.dart';

/// A tile group that groups multiple [FTileMixin]s together.
///
/// Tiles grouped together will be separated by a divider, specified by [divider].
///
/// ## Using [FTileGroup] in a [FPopover] when wrapped in a [FTileGroup]
/// When a [FPopover] is used inside an [FTileGroup], tiles & groups inside the popover will inherit styling from the
/// parent group. This happens because [FPopover]'s content shares the same `BuildContext` as its child, causing data
/// inheritance that may lead to unexpected rendering issues.
///
/// To prevent this styling inheritance, wrap the popover in a [FInheritedItemData] with null data to reset the
/// inherited data:
/// ```dart
/// FTileGroup(
///   children: [
///     FTile(title: Text('Tile with popover')),
///     FPopoverWrapperTile(
///       popoverBuilder: (_, _) => FInheritedItemData(
///         child: FTileGroup(
///           children: [
///             FTile(title: Text('Popover Tile 1')),
///             FTile(title: Text('Popover Tile 2')),
///           ],
///         ),
///       ),
///       child: FButton(child: Text('Open Popover')),
///     ),
///   ],
/// );
/// ```
///
/// {@macro forui.widgets.label.error_transition}
///
///
/// See:
/// * https://forui.dev/docs/tile/tile-group for working examples.
/// * [FTileGroupStyle] for customizing a tile group's appearance.
class FTileGroup extends StatelessWidget with FTileGroupMixin {
  /// The style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FTileGroupStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tile-group
  /// ```
  final FTileGroupStyleDelta style;

  /// {@template forui.widgets.FTileGroup.scrollController}
  /// The scroll controller used to control the position to which this group is scrolled.
  ///
  /// Scrolling past the end of the group using the controller will result in undefined behavior.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  /// {@endtemplate}
  final ScrollController? scrollController;

  /// {@template forui.widgets.FTileGroup.cacheExtent}
  /// The scrollable area's cache extent in logical pixels.
  ///
  /// Items that fall in this cache area are laid out even though they are not (yet) visible on screen. It describes
  /// how many pixels the cache area extends before the leading edge and after the trailing edge of the viewport.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  /// {@endtemplate}
  final double? cacheExtent;

  /// {@template forui.widgets.FTileGroup.maxHeight}
  /// The max height, in logical pixels. Defaults to infinity.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [maxHeight] is not positive.
  /// {@endtemplate}
  final double maxHeight;

  /// {@template forui.widgets.FTileGroup.dragStartBehavior}
  /// Determines the way that drag start behavior is handled. Defaults to [DragStartBehavior.start].
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  /// {@endtemplate}
  final DragStartBehavior dragStartBehavior;

  /// {@template forui.widgets.FTileGroup.physics}
  /// The scroll physics of the group. Defaults to [ClampingScrollPhysics].
  /// {@endtemplate}
  final ScrollPhysics physics;

  /// {@template forui.widgets.FTileGroup.divider}
  /// The divider between tiles.
  /// {@endtemplate}
  ///
  /// Defaults to [FItemDivider.indented].
  final FItemDivider divider;

  /// True if the group is enabled. Defaults to true.
  final bool? enabled;

  /// The group's semantic label.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  final String? semanticsLabel;

  /// The label above the group.
  ///
  /// It is not rendered if the group is disabled or part of a merged [FTileGroup].
  final Widget? label;

  /// The description below the group.
  ///
  /// It is not rendered if the group is disabled or part of a merged [FTileGroup].
  final Widget? description;

  /// The error below the [description].
  ///
  /// It is not rendered if the group is disabled or part of a merged [FTileGroup].
  final Widget? error;

  /// The delegate that builds the sliver children.
  // ignore: avoid_positional_boolean_parameters
  final Widget Function(FTileGroupStyle style, bool scrollable) _builder;

  /// {@template forui.widgets.FTileGroup.new}
  /// Creates a [FTileGroup].
  /// {@endtemplate}
  FTileGroup({
    required List<FTileMixin> children,
    this.style = const .context(),
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.dragStartBehavior = .start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.divider = .indented,
    this.semanticsLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       _builder = ((style, enabled) => SliverList.list(
         children: [
           for (final (index, child) in children.indexed)
             FInheritedItemData.merge(
               styles: style.tileStyles.toItemStyles(),
               enabled: enabled,
               dividerColor: style.dividerColor,
               dividerWidth: style.dividerWidth,
               divider: divider,
               index: index,
               last: index == children.length - 1,
               child: child,
             ),
         ],
       ));

  /// Creates a [FTileGroup] that lazily builds its children.
  ///
  /// {@template forui.widgets.FTileGroup.builder}
  /// The [tileBuilder] is called for each tile that should be built. The current level's [FInheritedItemData] is **not**
  /// visible to `tileBuilder`.
  /// * It may return null to signify the end of the group.
  /// * It may be called more than once for the same index.
  /// * It will be called only for indices <= [count] if [count] is given.
  ///
  /// The [count] is the number of tiles to build. If null, [tileBuilder] will be called until it returns null.
  ///
  /// ## Notes
  /// May result in an infinite loop or run out of memory if:
  /// * Placed in a parent widget that does not constrain its size, i.e. [Column].
  /// * [count] is null and [tileBuilder] always provides a zero-size widget, i.e. SizedBox(). If possible, provide
  ///   tiles with non-zero size, return null from builder, or set [count] to non-null.
  /// {@endtemplate}
  FTileGroup.builder({
    required NullableIndexedWidgetBuilder tileBuilder,
    int? count,
    this.style = const .context(),
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.dragStartBehavior = .start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.divider = .indented,
    this.semanticsLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       assert(count == null || 0 <= count, 'count ($count) must be >= 0'),
       _builder = ((style, enabled) => SliverList.builder(
         itemCount: count,
         itemBuilder: (context, index) {
           if (tileBuilder(context, index) case final tile?) {
             return FInheritedItemData.merge(
               styles: style.tileStyles.toItemStyles(),
               enabled: enabled,
               dividerColor: style.dividerColor,
               dividerWidth: style.dividerWidth,
               divider: divider,
               index: index,
               last: (count != null && index == count - 1) || tileBuilder(context, index + 1) == null,
               child: tile,
             );
           }

           return null;
         },
       ));

  /// {@template forui.widgets.FTileGroup.merge}
  /// Creates a [FTileGroup] that merges multiple [FTileGroupMixin]s together.
  ///
  /// All group labels will be ignored.
  /// {@endtemplate}
  FTileGroup.merge({
    required List<FTileGroupMixin> children,
    this.style = const .context(),
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.dragStartBehavior = .start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.divider = .full,
    this.semanticsLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       _builder = ((style, enabled) => SliverMainAxisGroup(
         slivers: [
           for (final (index, child) in children.indexed)
             FInheritedItemData.merge(
               styles: style.tileStyles.toItemStyles(),
               enabled: enabled,
               dividerColor: style.dividerColor,
               dividerWidth: style.dividerWidth,
               divider: divider,
               index: index,
               last: index == children.length - 1,
               child: child,
             ),
         ],
       ));

  @override
  Widget build(BuildContext context) {
    final data = FInheritedItemData.maybeOf(context);
    final style = this.style(FTileGroupStyleData.of(context));
    final enabled = this.enabled ?? data?.enabled ?? true;

    final sliver = _builder(style, enabled);
    if (data != null) {
      return sliver;
    }

    Widget child = FTileGroupStyleData(
      style: style,
      child: CustomScrollView(
        controller: scrollController,
        cacheExtent: cacheExtent,
        dragStartBehavior: dragStartBehavior,
        shrinkWrap: true,
        physics: physics,
        slivers: [sliver],
      ),
    );

    if (maxHeight.isInfinite && style.slideableTiles.resolve({context.platformVariant})) {
      child = FTappableGroup(child: child);
    }

    return FLabel(
      style: style,
      axis: .vertical,
      variants: {if (!enabled) .disabled, if (error != null) .error},
      label: label,
      description: description,
      error: error,
      child: Semantics(
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
      ..add(EnumProperty('divider', divider))
      ..add(StringProperty('semanticsLabel', semanticsLabel));
  }
}

/// An inherited widget that provides the [FTileGroupStyle] to its descendants.
class FTileGroupStyleData extends InheritedWidget {
  /// Returns the [FTileGroupStyle] in the given [context], or null if none is found.
  static FTileGroupStyle? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FTileGroupStyleData>()?.style;

  /// Returns the [FTileGroupStyle] in the given [context].
  static FTileGroupStyle of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FTileGroupStyleData>()?.style ?? context.theme.tileGroupStyle;

  /// The style of the group.
  final FTileGroupStyle style;

  /// Creates a [FTileGroupStyleData].
  const FTileGroupStyleData({required this.style, required super.child, super.key});

  @override
  bool updateShouldNotify(FTileGroupStyleData old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A [FTileGroup]'s style.
class FTileGroupStyle extends FLabelStyle with _$FTileGroupStyleFunctions {
  /// The group's decoration.
  @override
  final Decoration decoration;

  /// The divider's style.
  @override
  final FVariants<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta> dividerColor;

  /// The divider's width.
  @override
  final double dividerWidth;

  /// The tile's styles.
  @override
  final FVariants<FItemVariantConstraint, FItemVariant, FTileStyle, FTileStyleDelta> tileStyles;

  /// Whether the tiles support pressing a tile and sliding to another. Defaults to true.
  ///
  /// This is ignored if the tile group's content is scrollable, i.e. `maxHeight` is finite.
  @override
  final FVariants<FItemGroupVariantConstraint, FItemGroupVariant, bool, Delta> slideableTiles;

  /// Creates a [FTileGroupStyle].
  FTileGroupStyle({
    required this.decoration,
    required this.dividerColor,
    required this.dividerWidth,
    required this.tileStyles,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.slideableTiles = const .all(true),
    super.labelPadding = const .symmetric(vertical: 7.7),
    super.descriptionPadding = const .only(top: 7.5),
    super.errorPadding = const .only(top: 5),
    super.childPadding,
    super.labelMotion,
  });

  /// Creates a [FTileGroupStyle] that inherits from the given arguments.
  factory FTileGroupStyle.inherit({required FColors colors, required FTypography typography, required FStyle style}) =>
      .new(
        decoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(
            side: BorderSide(color: colors.border, width: style.borderWidth),
            borderRadius: style.borderRadius.md,
          ),
        ),
        dividerColor: .all(colors.border),
        dividerWidth: style.borderWidth,
        slideableTiles: const .all(true),
        labelTextStyle: FVariants.from(
          typography.md.copyWith(
            color: style.formFieldStyle.labelTextStyle.base.color ?? colors.foreground,
            fontWeight: .w600,
          ),
          variants: {
            [.disabled]: .delta(color: colors.disable(colors.foreground)),
          },
        ),
        tileStyles: FVariants.from(
          .inherit(
            colors: colors,
            typography: typography,
            style: style,
          ).copyWith(decoration: .delta([.all(const .shapeDelta(shape: RoundedSuperellipseBorder()))])),
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
                prefix: colors.destructive,
                color: colors.destructive,
              ),
            ),
          },
        ),
        descriptionTextStyle: style.formFieldStyle.descriptionTextStyle.apply([
          .all(.delta(fontSize: typography.xs.fontSize, height: typography.xs.height)),
        ]),
        errorTextStyle: style.formFieldStyle.errorTextStyle.apply([
          .all(.delta(fontSize: typography.xs.fontSize, height: typography.xs.height, fontWeight: .w400)),
        ]),
      );
}
