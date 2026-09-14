import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// A portal's geometry after all transformations.
///
/// `child` is relative to the portal's top-left corner and is:
/// * The linked child's rectangle in [FPortal].
/// * The anchor point as a zero-sized rectangle in [FPointPortal].
typedef FPortalGeometry = ({Rect child, Size portal});

@internal
class GeometryNotifier([var FPortalGeometry? _value]) extends ValueNotifier<FPortalGeometry?> {
  this : super(null);

  @override
  FPortalGeometry? get value => _value;

  @override
  set value(FPortalGeometry? value) {
    if (_value == value) {
      return;
    }

    _value = value;
    SchedulerBinding.instance.addPostFrameCallback((_) => notifyListeners(), debugLabel: 'FPortalGeometry.notify');
  }
}
