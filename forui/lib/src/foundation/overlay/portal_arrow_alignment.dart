import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// How an arrow is positioned along the portal's edge that faces its child.
///
/// See:
/// * [FPortalArrowDecoration] for painting an arrow.
/// * [FPortalArrowStyle] for customizing the appearance of a portal's arrow.
abstract interface class FPortalArrowAlignment {
  /// Centers the arrow on the child, shifting it inward if it clashes with the portal's [FPortalArrowStyle.cornerSpacing].
  ///
  /// ```diagram
  ///   ┌────────────┐          ┌────────────┐          ┌────────────┐
  ///   │   portal   │          │   portal   │          │   portal   │
  ///   ╰────╮  ╭────╯          ╰───────╮  ╭─╯          ╰────────────╯
  ///         ╲╱                         ╲╱
  ///      ┌──────┐                     ┌──────┐                     ┌──────┐
  ///      │child │                     │child │                     │child │
  ///      └──────┘                     └──────┘                     └──────┘
  ///      centered              shifted inward                    hidden
  /// ```
  static const FPortalArrowAlignment childCenter = _ChildCenter();

  /// Places the arrow [offset] from the portal edge's start.
  ///
  /// The start is the:
  /// * Left if horizontal and LTR.
  /// * Right if horizontal and RTL.
  /// * Top if vertical.
  const factory start(double offset) = _Start;

  /// Places the arrow [offset] from the portal edge's end.
  ///
  /// The end is the:
  /// * Right if horizontal and LTR.
  /// * Left if horizontal and RTL.
  /// * Bottom if vertical.
  const factory end(double offset) = _End;

  /// Places the arrow at a [fraction] of the portal edge's length from its start.
  ///
  /// The start is the:
  /// * Left if horizontal and LTR.
  /// * Right if horizontal and RTL.
  /// * Top if vertical.
  const factory fraction(double fraction) = _Fraction;

  /// Returns the arrow's center along the edge, or null to hide the arrow.
  ///
  /// [axis] is the edge's axis.
  ///
  /// [direction] is the ambient text direction.
  ///
  /// [length] is the edge's length.
  ///
  /// [min] and [max] bound the center to keep the arrow off the corners. [min] may exceed [max] if the edge is too
  /// short.
  ///
  /// [childStart] and [childEnd] are the child's extent.
  double? call({
    required Axis axis,
    required TextDirection direction,
    required double length,
    required double min,
    required double max,
    required double childStart,
    required double childEnd,
  });
}

class const _ChildCenter() implements FPortalArrowAlignment {
  @override
  double? call({
    required Axis axis,
    required TextDirection direction,
    required double length,
    required double min,
    required double max,
    required double childStart,
    required double childEnd,
  }) {
    if (max < min) {
      return null;
    }

    final center = ((childStart + childEnd) / 2).clamp(min, max);
    return childStart <= center && center <= childEnd ? center : null;
  }
}

class const _Start(final double offset) with Diagnosticable implements FPortalArrowAlignment {
  @override
  double? call({
    required Axis axis,
    required TextDirection direction,
    required double length,
    required double min,
    required double max,
    required double childStart,
    required double childEnd,
  }) {
    if (max < min) {
      return null;
    }

    final flipped = axis == .horizontal && direction == .rtl ? length - offset : offset;
    return flipped.clamp(min, max);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('offset', offset));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Start && runtimeType == other.runtimeType && offset == other.offset;

  @override
  int get hashCode => offset.hashCode;
}

class const _End(final double offset) with Diagnosticable implements FPortalArrowAlignment {
  @override
  double? call({
    required Axis axis,
    required TextDirection direction,
    required double length,
    required double min,
    required double max,
    required double childStart,
    required double childEnd,
  }) {
    if (max < min) {
      return null;
    }

    final flipped = axis == .horizontal && direction == .rtl ? offset : length - offset;
    return flipped.clamp(min, max);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('offset', offset));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _End && runtimeType == other.runtimeType && offset == other.offset;

  @override
  int get hashCode => offset.hashCode;
}

class const _Fraction(final double fraction) with Diagnosticable implements FPortalArrowAlignment {
  @override
  double? call({
    required Axis axis,
    required TextDirection direction,
    required double length,
    required double min,
    required double max,
    required double childStart,
    required double childEnd,
  }) {
    if (max < min) {
      return null;
    }

    final flipped = axis == .horizontal && direction == .rtl ? 1 - fraction : fraction;
    return (length * flipped).clamp(min, max);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('fraction', fraction));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Fraction && runtimeType == other.runtimeType && fraction == other.fraction;

  @override
  int get hashCode => fraction.hashCode;
}
