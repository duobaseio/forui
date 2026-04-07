// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

part 'tooltip_controller.control.dart';

/// A controller that controls whether a [FTooltip] is shown or hidden.
///
/// ## Contract
/// Each controller should generally be used with a single [FTooltip]. Sharing a controller between multiple tooltips
/// is undefined behavior.
class FTooltipController extends FChangeNotifier {
  final OverlayPortalController _overlay = .new();
  late final AnimationController _animation;
  late final CurvedAnimation _curveFade;
  late final CurvedAnimation _curveScale;
  late Animation<double> _fade;
  late Animation<double> _scale;
  FTooltipMotion _motion;

  /// Creates a [FTooltipController] with the given [vsync] and [shown].
  FTooltipController({required TickerProvider vsync, bool shown = false}) : _motion = const FTooltipMotion() {
    if (shown) {
      _overlay.show();
    }

    _animation = AnimationController(
      vsync: vsync,
      value: shown ? 1 : 0,
      duration: _motion.entranceDuration,
      reverseDuration: _motion.exitDuration,
    );
    _curveFade = CurvedAnimation(parent: _animation, curve: _motion.fadeInCurve, reverseCurve: _motion.fadeOutCurve);
    _curveScale = CurvedAnimation(parent: _animation, curve: _motion.expandCurve, reverseCurve: _motion.collapseCurve);
    _fade = _motion.fadeTween.animate(_curveFade);
    _scale = _motion.scaleTween.animate(_curveScale);
  }

  /// Convenience method for showing/hiding the tooltip.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> toggle({bool animated = true}) =>
      _animation.status.isForwardOrCompleted ? hide(animated: animated) : show(animated: animated);

  /// Shows the tooltip.
  ///
  /// If already shown, calling this method brings the tooltip to the top.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> show({bool animated = true}) async {
    if (_animation.isForwardOrCompleted) {
      return;
    }

    _overlay.show();
    if (animated) {
      await _animation.forward();
    } else {
      _animation.value = 1;
    }
    notifyListeners();
  }

  /// Hides the tooltip.
  ///
  /// Once hidden, the tooltip will be removed from the widget tree the next time the widget tree rebuilds, and stateful
  /// widgets in the tooltip may lose their states as a result.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> hide({bool animated = true}) async {
    if (!_animation.isForwardOrCompleted) {
      return;
    }

    if (animated) {
      await _animation.reverse();
    } else {
      _animation.value = 0;
    }
    _overlay.hide();
    notifyListeners();
  }

  /// The current status.
  ///
  /// [AnimationStatus.dismissed] - The tooltip is hidden.
  /// [AnimationStatus.forward] - The tooltip is transitioning from hidden to shown.
  /// [AnimationStatus.completed] - The tooltip is shown.
  /// [AnimationStatus.reverse] - The tooltip is transitioning from shown to hidden.
  AnimationStatus get status => _animation.status;

  @override
  void dispose() {
    _curveFade.dispose();
    _curveScale.dispose();
    _animation.dispose();
    super.dispose();
  }
}

@internal
extension InternalTooltipController on FTooltipController {
  OverlayPortalController get overlay => _overlay;

  Animation<double> get fade => _fade;

  Animation<double> get scale => _scale;

  void updateMotion(FTooltipMotion motion) {
    if (_motion != motion) {
      _animation
        ..duration = motion.entranceDuration
        ..reverseDuration = motion.exitDuration;
      _curveFade
        ..curve = motion.fadeInCurve
        ..reverseCurve = motion.fadeOutCurve;
      _curveScale
        ..curve = motion.expandCurve
        ..reverseCurve = motion.collapseCurve;
      _scale = motion.scaleTween.animate(_curveScale);
      _fade = motion.fadeTween.animate(_curveFade);
      _motion = motion;
    }
  }
}

class _ProxyController extends FTooltipController {
  int _monotonic;
  ValueChanged<bool> _onChange;

  _ProxyController(this._onChange, {required super.vsync, super.shown}) : _monotonic = 0;

  void update(bool shown, ValueChanged<bool> onChange) {
    _onChange = onChange;

    final current = ++_monotonic;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (current == _monotonic) {
        if (!shown && status.isForwardOrCompleted) {
          await _animation.reverse();
          if (current == _monotonic) {
            _overlay.hide();
            notifyListeners();
          }
        } else if (shown && !status.isForwardOrCompleted) {
          _overlay.show();
          await _animation.forward();
          notifyListeners();
        }
      }
    });
  }

  @override
  Future<void> show({bool animated = true}) async => _onChange(true);

  @override
  Future<void> hide({bool animated = true}) async => _onChange(false);
}

/// A [FTooltipControl] defines how a [FTooltip] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FTooltipControl with Diagnosticable, _$FTooltipControlMixin {
  /// Creates a [FTooltipControl].
  const factory FTooltipControl.managed({FTooltipController? controller, bool? initial, ValueChanged<bool>? onChange}) =
      FTooltipManagedControl;

  /// Creates a [FTooltipControl] for controlling a tooltip using lifted state.
  ///
  /// The [shown] parameter indicates whether the tooltip is currently shown.
  /// The [onChange] callback is invoked when the user triggers a show/hide action.
  const factory FTooltipControl.lifted({required bool shown, required ValueChanged<bool> onChange}) = _Lifted;

  const FTooltipControl._();

  (FTooltipController, bool) _update(
    FTooltipControl old,
    FTooltipController controller,
    VoidCallback callback,
    TickerProvider vsync,
  );
}

/// A [FTooltipManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FTooltipManagedControl extends FTooltipControl with Diagnosticable, _$FTooltipManagedControlMixin {
  /// The controller.
  @override
  final FTooltipController? controller;

  /// Whether the tooltip is initially shown. Defaults to false (hidden).
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final bool? initial;

  /// Called when the shown state changes.
  @override
  final ValueChanged<bool>? onChange;

  /// Creates a [FTooltipControl].
  const FTooltipManagedControl({this.controller, this.initial, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both initially shown and controller. Pass initially shown to the controller instead.',
      ),
      super._();

  @override
  FTooltipController createController(TickerProvider vsync) =>
      controller ?? .new(vsync: vsync, shown: initial ?? false);
}

class _Lifted extends FTooltipControl with _$_LiftedMixin {
  @override
  final bool shown;
  @override
  final ValueChanged<bool> onChange;

  const _Lifted({required this.shown, required this.onChange}) : super._();

  @override
  FTooltipController createController(TickerProvider vsync) => _ProxyController(vsync: vsync, shown: shown, onChange);

  @override
  void _updateController(FTooltipController controller, TickerProvider vsync) =>
      (controller as _ProxyController).update(shown, onChange);
}
