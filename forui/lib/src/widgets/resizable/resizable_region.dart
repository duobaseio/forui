import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/doubles.dart';
import 'package:forui/src/widgets/resizable/resizable.dart';

/// A resizable region that can be resized along the parent [FResizable]'s axis. It should always be in a [FResizable].
///
/// See https://forui.dev/docs/widgets/layout/resizable for working examples.
sealed class FResizableRegion extends StatelessWidget {
  /// The builder used to create a child to display in this region.
  final ValueWidgetBuilder<FResizableRegionData> builder;

  /// A height/width-independent widget which is passed back to the [builder].
  ///
  /// This argument is optional and can be null if the entire widget subtree the [builder] builds depends on the size of
  /// the region.
  final Widget? child;

  /// Creates a [FResizableRegion] with a concrete initial extent in logical pixels.
  factory FResizableRegion.fixed({
    required double extent,
    required ValueWidgetBuilder<FResizableRegionData> builder,
    double? minExtent,
    Widget? child,
    Key? key,
  }) = FixedResizableRegion;

  /// Creates a [FResizableRegion] that is sized proportionally from the remaining space.
  ///
  /// [flex] determines the region's share of the remaining space after concrete-extent regions are placed. The parent
  /// [FResizable] must have finite main-axis constraints.
  ///
  /// [minFlex] constrains how small the region can be resized, expressed as a flex proportion.
  const factory FResizableRegion.flex({
    required ValueWidgetBuilder<FResizableRegionData> builder,
    int flex,
    int? minFlex,
    Widget? child,
    Key? key,
  }) = FlexResizableRegion;

  const FResizableRegion({required this.builder, this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final InheritedData(:axis, :data) = InheritedData.of(context);
    return Semantics(
      container: true,
      child: GestureDetector(
        child: switch (axis) {
          .horizontal => SizedBox(width: data.extent.current, child: builder(context, data, child)),
          .vertical => SizedBox(height: data.extent.current, child: builder(context, data, child)),
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('builder', builder));
  }
}

@internal
class FixedResizableRegion extends FResizableRegion {
  final double extent;
  final double? minExtent;

  FixedResizableRegion({required this.extent, required super.builder, this.minExtent, super.child, super.key})
    : assert(0 < extent, 'extent ($extent) must be > 0'),
      assert(minExtent == null || 0 < minExtent, 'minExtent ($minExtent) must be > 0'),
      assert(
        minExtent == null || minExtent.lessOrAround(extent),
        'minExtent ($minExtent) must be < extent ($extent)',
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('extent', extent))
      ..add(DoubleProperty('minExtent', minExtent));
  }
}

@internal
class FlexResizableRegion extends FResizableRegion {
  final int flex;
  final int? minFlex;

  const FlexResizableRegion({required super.builder, this.flex = 1, this.minFlex, super.child, super.key})
    : assert(0 < flex, 'flex ($flex) must be > 0'),
      assert(minFlex == null || (0 < minFlex && minFlex <= flex), 'minFlex ($minFlex) must be > 0 and <= flex ($flex)');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('flex', flex))
      ..add(IntProperty('minFlex', minFlex));
  }
}
