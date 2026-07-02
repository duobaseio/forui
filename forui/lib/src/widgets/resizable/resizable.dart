import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/widgets/resizable/divider.dart';
import 'package:forui/src/widgets/resizable/resizable_controller.dart';
import 'package:forui/src/widgets/resizable/resizable_region.dart';

@Variants('FResizableAxis', {
  'horizontal': (1, 'The horizontal resizable variant.'),
  'vertical': (1, 'The vertical resizable variant.'),
})
part 'resizable.design.dart';

/// A resizable allows its children to be resized along either the horizontal or vertical main axis.
///
/// Each child is either a [FResizableRegion.fixed] (concrete pixel size) or a [FResizableRegion.flex] (proportional
/// sizing from remaining space).
///
/// Using [FResizableRegion.flex] causes the [FResizable] to fill its parent's main-axis constraints, which must be
/// finite.
///
/// The children are arranged from top to bottom, or left to right, depending on the main [axis] and ambient text direction.
///
/// It is recommended that a [FResizable] contains at least 2 [FResizableRegion]s.
///
/// See:
/// * https://forui.dev/docs/widgets/layout/resizable for working examples.
/// * [FResizableStyles] for customizing a resizable's appearance.
class FResizable extends StatefulWidget {
  /// The default semantic label formatter that announces the extents of both regions.
  static String defaultSemanticFormatterCallback(FResizableRegionData left, FResizableRegionData right) =>
      '${left.extent.current}, ${right.extent.current}';

  /// The control that manages the resizing of regions. Defaults to [FResizableControl.managedCascade].
  final FResizableControl control;

  /// The divider' style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FResizableDividerStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create resizables
  /// ```
  final FResizableDividerStyleDelta style;

  /// The main axis along which the [children] can be resized.
  final Axis axis;

  /// The divider between resizable regions. Defaults to [FResizableDivider.dividerWithThumb].
  final FResizableDivider divider;

  /// The extent of the [children] along the non-resizable axis, in logical pixels. By default, it occupies as much
  /// space as possible.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [crossAxisExtent] is not positive.
  final double? crossAxisExtent;

  /// The extent of the gesture's hit region along the resizable axis, in logical pixels.
  ///
  /// Hit regions are centered around the dividers between resizable regions.
  ///
  /// Defaults to `60` on Android, iOS and Fuchsia, and `10` on other platforms. To change the platform variant, update
  /// the enclosing [FTheme.platform]/[FAdaptiveScope.platform].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [hitRegionExtent] <= 0.
  final double? hitRegionExtent;

  /// The percentage of the total extent by which regions are resized when using the keyboard. Defaults to 0.005 (0.5%).
  ///
  /// ## Contract
  /// Throws [AssertionError] if [resizePercentage] is <= 0 or >= 1.
  final double resizePercentage;

  /// A callback that formats the semantic label for the resizable. Defaults to announcing the extents of both regions.
  final String Function(FResizableRegionData first, FResizableRegionData second) semanticFormatterCallback;

  /// The children that may be resized.
  final List<FResizableRegion> children;

  /// Creates a [FResizable].
  const FResizable({
    required this.axis,
    required this.children,
    this.control = const .managedCascade(),
    this.style = const .context(),
    this.divider = .dividerWithThumb,
    this.crossAxisExtent,
    this.hitRegionExtent,
    this.resizePercentage = 0.005,
    this.semanticFormatterCallback = defaultSemanticFormatterCallback,
    super.key,
  }) : assert(crossAxisExtent == null || 0 < crossAxisExtent, 'crossAxisExtent ($crossAxisExtent) must be > 0'),
       assert(hitRegionExtent == null || 0 < hitRegionExtent, 'hitRegionExtent ($hitRegionExtent) must be > 0');

  @override
  State<StatefulWidget> createState() => _FResizableState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(ObjectFlagProperty.has('style', style))
      ..add(EnumProperty('axis', axis))
      ..add(EnumProperty('divider', divider))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(DoubleProperty('hitRegionExtent', hitRegionExtent))
      ..add(PercentProperty('resizePercentage', resizePercentage))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(IterableProperty('children', children));
  }
}

class _FResizableState extends State<FResizable> {
  static bool _listEquals(List<FResizableRegion> a, List<FResizableRegion> b) {
    if (a.length != b.length) {
      return false;
    }

    for (final (i, region) in a.indexed) {
      final same = switch ((region, b[i])) {
        (FixedResizableRegion(:final extent, :final minExtent), final FixedResizableRegion other) =>
          extent == other.extent && minExtent == other.minExtent,
        (FlexResizableRegion(:final flex, :final minFlex), final FlexResizableRegion other) =>
          flex == other.flex && minFlex == other.minFlex,
        _ => false,
      };
      if (!same) {
        return false;
      }
    }

    return true;
  }

  late FResizableController _controller;
  late double _hitRegionExtent;
  bool _dirty = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _hitRegionExtent = widget.hitRegionExtent ?? (context.platformVariant.touch ? 60 : 10);
  }

  @override
  void didUpdateWidget(FResizable old) {
    super.didUpdateWidget(old);
    final (controller, updated) = widget.control.update(old.control, _controller, () {});
    if (updated) {
      _controller = controller;
    }

    final extent = widget.hitRegionExtent ?? (context.platformVariant.touch ? 60 : 10);
    if (extent != _hitRegionExtent || widget.axis != old.axis || !_listEquals(old.children, widget.children)) {
      _hitRegionExtent = extent;
      _dirty = true;
    }
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, () {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = context.theme.resizableStyles;
    if (widget.axis == .horizontal) {
      final dividerStyle = widget.style(styles.resolve({FResizableAxisVariant.horizontal, context.platformVariant}));
      return SizedBox(
        height: widget.crossAxisExtent,
        child: LayoutBuilder(
          builder: (_, constraints) {
            // This isn't ideal but the alternative to create a custom RenderObject, compute the layout, and pipe it to
            // the controller, which is overkill.
            if (_dirty || _controller.regions.length != widget.children.length) {
              _dirty = false;
              _reset(constraints.maxWidth);
            } else {
              _scale(constraints.maxWidth);
            }

            return ListenableBuilder(
              listenable: _controller,
              builder: (_, _) => Stack(
                children: [
                  Row(
                    mainAxisSize: .min,
                    children: [
                      for (final (i, child) in widget.children.indexed)
                        InheritedData(
                          controller: _controller,
                          axis: widget.axis,
                          data: _controller.regions[i],
                          child: child,
                        ),
                    ],
                  ),
                  for (var i = 0; i < widget.children.length - 1; i++)
                    HorizontalDivider(
                      controller: _controller,
                      style: dividerStyle,
                      type: widget.divider,
                      left: i,
                      right: i + 1,
                      crossAxisExtent: constraints.maxHeight.isFinite ? constraints.maxHeight : widget.crossAxisExtent,
                      hitRegionExtent: _hitRegionExtent,
                      resizePercentage: widget.resizePercentage,
                      cursor: SystemMouseCursors.resizeLeftRight,
                      semanticFormatterCallback: widget.semanticFormatterCallback,
                    ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      final dividerStyle = widget.style(styles.resolve({context.platformVariant, FResizableAxisVariant.vertical}));
      return SizedBox(
        width: widget.crossAxisExtent,
        child: LayoutBuilder(
          builder: (_, constraints) {
            // This isn't ideal but the alternative to create a custom RenderObject, compute the layout, and pipe it to
            // the controller, which is overkill.
            if (_dirty || _controller.regions.length != widget.children.length) {
              _dirty = false;
              _reset(constraints.maxHeight);
            } else {
              _scale(constraints.maxHeight);
            }
            return ListenableBuilder(
              listenable: _controller,
              builder: (_, _) => Stack(
                children: [
                  Column(
                    mainAxisSize: .min,
                    children: [
                      for (final (i, child) in widget.children.indexed)
                        InheritedData(
                          controller: _controller,
                          axis: widget.axis,
                          data: _controller.regions[i],
                          child: child,
                        ),
                    ],
                  ),
                  for (var i = 0; i < widget.children.length - 1; i++)
                    VerticalDivider(
                      controller: _controller,
                      style: dividerStyle,
                      type: widget.divider,
                      left: i,
                      right: i + 1,
                      crossAxisExtent: constraints.maxWidth.isFinite ? constraints.maxWidth : widget.crossAxisExtent,
                      hitRegionExtent: _hitRegionExtent,
                      resizePercentage: widget.resizePercentage,
                      cursor: SystemMouseCursors.resizeUpDown,
                      semanticFormatterCallback: widget.semanticFormatterCallback,
                    ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  /// Lays out the regions by keeping their current extents and adjusting them to fit the new [constraint].
  ///
  /// Fixed regions keep their extent and flex regions grow or shrink to fill the rest. The fixed ones change only if the
  /// flex regions can't. Called when only the constraint changed, so the user's resizing is kept.
  void _scale(double constraint) {
    final (total, totalMinExtent, remaining, totalFlex) = _constraints(constraint);

    // Start from each region's current extent (what the user dragged it to), kept within its new min and max.
    final bounds = <(double, double)>[];
    final extents = <double>[];

    for (final (i, region) in widget.children.indexed) {
      final minExt = switch (region) {
        FixedResizableRegion(:final minExtent) => max(minExtent ?? 0, _hitRegionExtent),
        FlexResizableRegion(:final minFlex?) => max(remaining * minFlex / totalFlex, _hitRegionExtent),
        FlexResizableRegion() => _hitRegionExtent,
      };
      final maxExt = total - totalMinExtent + minExt;

      bounds.add((minExt, maxExt));
      extents.add(clampDouble(_controller.regions[i].extent.current, minExt, maxExt));
    }

    // The regions' extents rarely add up to `total`, so grow or shrink them by the difference (`delta`) until they
    // match it. The flex regions change first, the fixed ones only if the flex regions can't grow or shrink further.
    // Repeat, since each region can only change until it reaches its min or max.
    const eps = 1e-9;
    var delta = total - extents.fold(0.0, (sum, extent) => sum + extent);
    for (final flexOnly in [true, false]) {
      for (var pass = 0; pass < extents.length && eps < delta.abs(); pass++) {
        final grow = delta > 0;

        final weights = List.filled(extents.length, 0.0);
        var weightTotal = 0.0;
        for (final (i, extent) in extents.indexed) {
          if (flexOnly && widget.children[i] is! FlexResizableRegion) {
            continue;
          }

          final (minExt, maxExt) = bounds[i];
          if (grow ? extent < maxExt : extent > minExt) {
            weights[i] = grow ? max(extent, eps) : max(extent - minExt, eps);
            weightTotal += weights[i];
          }
        }

        if (weightTotal == 0) {
          break;
        }

        var moved = 0.0;
        for (final (i, extent) in extents.indexed) {
          if (weights[i] == 0) {
            continue;
          }

          final (minExt, maxExt) = bounds[i];
          final resized = clampDouble(extent + delta * weights[i] / weightTotal, minExt, maxExt);
          moved += resized - extent;
          extents[i] = resized;
        }
        delta -= moved;
        if (moved.abs() <= eps) {
          break;
        }
      }
    }

    // Turn the final extents into regions. The last region ends exactly at `total` so they add up perfectly.
    final regions = <FResizableRegionData>[];
    var offset = 0.0;
    for (var index = 0; index < extents.length; index++) {
      final maxOffset = index == extents.length - 1 ? total : offset + extents[index];
      regions.add(
        FResizableRegionData(
          index: index,
          extent: (min: bounds[index].$1, max: bounds[index].$2, total: total),
          offset: (min: offset, max: maxOffset),
        ),
      );
      offset = maxOffset;
    }

    _controller.regions
      ..clear()
      ..addAll(regions);
  }

  /// Lays out the regions from their declared configuration, discarding any current extents.
  ///
  /// Fixed regions take their declared extent and flex regions their share of the remaining space. Called on the first
  /// layout and whenever the configuration changes, where there is nothing to preserve.
  void _reset(double constraint) {
    final (total, totalMinExtent, remaining, totalFlex) = _constraints(constraint);

    final regions = <FResizableRegionData>[];
    var offset = 0.0;
    for (final (index, region) in widget.children.indexed) {
      switch (region) {
        case FixedResizableRegion(:final extent, :final minExtent):
          final minExt = max(minExtent ?? 0, _hitRegionExtent);
          final maxExt = total - totalMinExtent + minExt;
          regions.add(
            FResizableRegionData(
              index: index,
              extent: (min: minExt, max: maxExt, total: total),
              offset: (min: offset, max: offset += extent),
            ),
          );

        case FlexResizableRegion(:final flex, :final minFlex):
          final minExt = minFlex == null ? _hitRegionExtent : max(remaining * minFlex / totalFlex, _hitRegionExtent);
          final maxExt = total - totalMinExtent + minExt;
          regions.add(
            FResizableRegionData(
              index: index,
              extent: (min: minExt, max: maxExt, total: total),
              offset: (min: offset, max: offset += remaining * flex / totalFlex),
            ),
          );
      }
    }

    _controller.regions
      ..clear()
      ..addAll(regions);
  }

  /// Measures the layout for the current children at the given [constraint].
  (double total, double totalMinExtent, double remaining, double totalFlex) _constraints(double constraint) {
    var totalFlex = 0.0;
    var totalFixed = 0.0;
    var totalMinExtent = 0.0;
    for (final child in widget.children) {
      switch (child) {
        case FlexResizableRegion(:final flex):
          totalFlex += flex;
        case FixedResizableRegion(:final extent, :final minExtent):
          totalFixed += extent;
          totalMinExtent += max(minExtent ?? 0, _hitRegionExtent);
      }
    }

    final double total;
    if (0 < totalFlex) {
      assert(
        constraint.isFinite,
        'FResizable must have a finite main-axis constraint when children use flex. Consider wrapping FResizable in a '
        'SizedBox or Expanded.',
      );
      assert(
        totalFixed <= constraint,
        'Fixed regions require $totalFixed px but only $constraint px is available. '
        'Increase the available space or reduce the fixed extents.',
      );
      total = constraint;
    } else {
      total = totalFixed;
    }

    final remaining = total - totalFixed;
    for (final child in widget.children) {
      if (child case FlexResizableRegion(:final minFlex)) {
        totalMinExtent += minFlex == null ? _hitRegionExtent : max(remaining * minFlex / totalFlex, _hitRegionExtent);
      }
    }

    return (total, totalMinExtent, remaining, totalFlex);
  }
}

/// A [FResizable]'s style.
extension type FResizableStyles(
  FVariants<FResizableAxisVariantConstraint, FResizableAxisVariant, FResizableDividerStyle, FResizableDividerStyleDelta>
  _
) implements
    FVariants<
      FResizableAxisVariantConstraint,
      FResizableAxisVariant,
      FResizableDividerStyle,
      FResizableDividerStyleDelta
    > {
  /// Creates a [FResizableStyles] that inherits its properties.
  factory FResizableStyles.inherit({
    required FColors colors,
    required FIcons icons,
    required FStyle style,
    required FHapticFeedback hapticFeedback,
  }) {
    FResizableDividerStyle dividerStyle({required FIconBuilder icon, required double height, required double width}) =>
        FResizableDividerStyle(
          color: colors.border,
          focusedOutlineStyle: style.focusedOutlineStyle,
          thumbStyle: FResizableDividerThumbStyle(
            decoration: ShapeDecoration(
              shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md),
              color: colors.border,
            ),
            foregroundColor: colors.foreground,
            icon: icon,
            height: height,
            width: width,
          ),
          hapticFeedback: hapticFeedback.lightImpact,
        );

    final horizontal = dividerStyle(icon: icons.gripVertical, height: 20, width: 10);
    return FResizableStyles(
      FVariants(
        horizontal,
        variants: {
          [.horizontal]: horizontal,
          [.vertical]: dividerStyle(icon: icons.gripHorizontal, height: 10, width: 20),
        },
      ),
    );
  }

  /// The horizontal resizable divider style.
  FResizableDividerStyle get horizontal => resolve({FResizableAxisVariant.horizontal});

  /// The vertical resizable divider style.
  FResizableDividerStyle get vertical => resolve({FResizableAxisVariant.vertical});
}

@internal
class InheritedData extends InheritedWidget {
  static InheritedData of(BuildContext context) {
    assert(debugCheckHasAncestor<InheritedData>('$FResizable', context));
    return context.dependOnInheritedWidgetOfExactType<InheritedData>()!;
  }

  final FResizableController controller;
  final Axis axis;
  final FResizableRegionData data;

  const InheritedData({
    required this.controller,
    required this.axis,
    required this.data,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(InheritedData old) => controller != old.controller || axis != old.axis || data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(EnumProperty('axis', axis))
      ..add(DiagnosticsProperty('data', data));
  }
}
