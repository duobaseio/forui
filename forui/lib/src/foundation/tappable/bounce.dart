import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

@internal
class const Bounce({
  required final Animation<double> _bounce,
  required final double? _bounceFloor,
  required super.child,
  super.key,
}) extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) => RenderBounce(_bounce, _bounceFloor);

  @override
  void updateRenderObject(BuildContext context, RenderBounce renderObject) {
    renderObject
      ..bounce = _bounce
      ..bounceFloor = _bounceFloor;
  }
}

@internal
class RenderBounce(var Animation<double> _bounce, var double? _bounceFloor) extends RenderProxyBox {
  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _bounce.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _bounce.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    }

    if (_bounce.value == 1.0) {
      context.paintChild(child!, offset);
      return;
    }

    final double scale;
    if (_bounceFloor case final bounceFloor?) {
      final floor = 1.0 - (bounceFloor / size.longestSide);
      scale = _bounce.value.clamp(floor, 1.0);
    } else {
      scale = _bounce.value;
    }

    final center = size.center(.zero);
    context.pushTransform(
      needsCompositing,
      offset,
      .identity()
        ..translateByDouble(center.dx, center.dy, 1, 1)
        ..scaleByDouble(scale, scale, 1, 1)
        ..translateByDouble(-center.dx, -center.dy, 1, 1),
      super.paint,
    );
  }

  Animation<double> get bounce => _bounce;

  set bounce(Animation<double> value) {
    if (_bounce != value) {
      if (attached) {
        _bounce.removeListener(markNeedsPaint);
        value.addListener(markNeedsPaint);
      }
      _bounce = value;
      markNeedsPaint();
    }
  }

  double? get bounceFloor => _bounceFloor;

  set bounceFloor(double? value) {
    if (_bounceFloor != value) {
      _bounceFloor = value;
      markNeedsPaint();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('bounce', bounce))
      ..add(DoubleProperty('bounceFloor', bounceFloor));
  }
}
