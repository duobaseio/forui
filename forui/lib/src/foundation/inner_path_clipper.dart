
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

/// A [CustomClipper] that clips to the inner path of a [Decoration].
///
/// The inner path is the region inside the decoration's border, following any rounded corners. Useful for clipping
/// a decorated box's child so it doesn't overlap the border ring.
///
/// * For [ShapeDecoration], this uses `shape.getInnerPath(...)`.
/// * For [BoxDecoration], the inner path is assembled from the decoration's `border.dimensions`, `borderRadius`, and
///   `shape` — [BoxBorder.getInnerPath] is not used because it ignores `BoxDecoration.borderRadius`.
/// * For other [Decoration] types, falls back to the outer path via [Decoration.getClipPath].
@internal
class InnerPathClipper extends CustomClipper<Path> {
  /// The decoration whose inner path is used as the clip.
  final Decoration decoration;

  /// The text direction used to resolve directional shapes.
  final TextDirection direction;

  /// Creates an [InnerPathClipper].
  const InnerPathClipper({required this.decoration, this.direction = .ltr});

  @override
  Path getClip(Size size) {
    final rect = Offset.zero & size;
    return switch (decoration) {
      ShapeDecoration(:final shape) => shape.getInnerPath(rect, textDirection: direction),
      // Only rectangular BoxDecorations can have non-uniform borders.
      BoxDecoration(:final shape, :final border?, :final borderRadius) => switch (shape) {
        .circle => CircleBorder(side: border.top).getInnerPath(rect, textDirection: direction),
        .rectangle when borderRadius != null => RoundedRectangleBorder(
          side: border.top,
          borderRadius: borderRadius,
        ).getInnerPath(rect, textDirection: direction),
        .rectangle => border.getInnerPath(rect, textDirection: direction),
      },
      final decoration => decoration.getClipPath(rect, direction),
    };
  }

  @override
  bool shouldReclip(covariant InnerPathClipper old) => old.decoration != decoration || old.direction != direction;
}
