import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

part 'overlay_controller.control.dart';

/// An [FOverlayControl] defines how an `FOverlay` is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FOverlayControl with Diagnosticable, _$FOverlayControlMixin {
  /// Creates a [FOverlayControl].
  const factory FOverlayControl.managed({
    OverlayPortalController? controller,
    bool? initial,
  }) = FOverlayManagedControl;

  /// Creates a [FOverlayControl] for controlling an overlay using lifted state.
  ///
  /// The [shown] parameter indicates whether the overlay is currently shown.
  /// The [onChange] callback is invoked when the user triggers a show/hide action.
  const factory FOverlayControl.lifted({
    required bool shown,
    required ValueChanged<bool> onChange,
  }) = _Lifted;

  const FOverlayControl._();

  (OverlayPortalController, bool) _update(
    FOverlayControl old,
    OverlayPortalController controller,
  );
}

/// An [FOverlayManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FOverlayManagedControl extends FOverlayControl with _$FOverlayManagedControlMixin {
  /// The controller.
  @override
  final OverlayPortalController? controller;

  /// Whether the overlay is initially shown. Defaults to false (hidden).
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final bool? initial;

  /// Creates a [FOverlayControl].
  const FOverlayManagedControl({this.controller, this.initial})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial. Pass initial visibility to the controller instead.',
      ),
      super._();

  @override
  OverlayPortalController createController() {
    final c = controller ?? OverlayPortalController();
    if (initial ?? false) {
      c.show();
    }
    return c;
  }
}

class _Lifted extends FOverlayControl with _$_LiftedMixin {
  @override
  final bool shown;
  @override
  final ValueChanged<bool> onChange;

  const _Lifted({required this.shown, required this.onChange}) : super._();

  @override
  OverlayPortalController createController() {
    final c = OverlayPortalController();
    if (shown) {
      c.show();
    }
    return c;
  }

  @override
  void _updateController(OverlayPortalController controller) {
    if (shown && !controller.isShowing) {
      controller.show();
    } else if (!shown && controller.isShowing) {
      controller.hide();
    }
  }
}
