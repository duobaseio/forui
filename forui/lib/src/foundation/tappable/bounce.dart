import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

@internal
class Bounce extends SingleChildRenderObjectWidget {
  final Animation<double> bounce;
  final double? bounceFloor;

  const Bounce({required this.bounce, required this.bounceFloor, required super.child, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) => RenderBounce(bounce, bounceFloor);

  @override
  void updateRenderObject(BuildContext context, RenderBounce renderObject) {
    renderObject
      ..bounce = bounce
      ..bounceFloor = bounceFloor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('bounce', bounce))
      ..add(DoubleProperty('bounceFloor', bounceFloor));
  }
}

@internal
class RenderBounce extends RenderProxyBox {
  Animation<double> _bounce;
  double? _bounceFloor;

  RenderBounce(this._bounce, this._bounceFloor) {
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
      _bounce.removeListener(markNeedsPaint);
      _bounce = value..addListener(markNeedsPaint);
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
