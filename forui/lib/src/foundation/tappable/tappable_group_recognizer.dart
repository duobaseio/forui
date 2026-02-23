import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:forui/src/foundation/tappable/tappable_group.dart';

/// The possible states of a [TappableGroupGestureRecognizer].
///
/// A [TappableGroupGestureRecognizer] always start and end in the [idle] state.
@internal
enum TappableGroupGestureRecognizerState {
  /// No gesture in progress.
  ///
  /// Transitions to [pressing] on pointer down over an entry.
  idle,

  /// Pointer down on an entry, gesture unresolved.
  ///
  /// Transitions to:
  /// * [idle] — pointer up, pointer cancel, or gesture rejected.
  /// * [longPressing] — long press timer fires.
  /// * [sliding] — pointer moves to empty space.
  /// * [slidePressing] — pointer moves to a different entry.
  pressing,

  /// Long press timer fired, gesture resolved.
  ///
  /// Transitions to [idle] on pointer up or pointer cancel.
  longPressing,

  /// Over empty space during slide-across, gesture unresolved.
  ///
  /// Transitions to:
  /// * [idle] — pointer up (nothing fires), pointer cancel, or gesture rejected.
  /// * [slidePressing] — pointer moves onto an entry.
  sliding,

  /// Pressing a different entry during slide-across, gesture unresolved.
  ///
  /// Transitions to:
  /// * [idle] — pointer up (fires onPress) or pointer cancel.
  /// * [longPressing] — long press timer fires.
  /// * [sliding] — pointer moves to empty space.
  slidePressing,
}

/// A custom gesture recognizer that recognizes sliding across tappables.
@internal
class TappableGroupGestureRecognizer extends OneSequenceGestureRecognizer {
  List<GroupEntry> entries;
  TappableGroupGestureRecognizerState _state;
  GroupEntry? _current;
  Timer? _longPressTimer;
  bool _accepted = false;

  /// Stored callback to fire after winning the arena. Only set for same-child taps (pressing → idle) where we defer to
  /// the arena sweep — this lets scroll recognizers win the sweep when competing.
  VoidCallback? _pendingOnPress;

  TappableGroupGestureRecognizer(this.entries) : _state = .idle;

  @override
  @protected
  bool isPointerAllowed(PointerDownEvent event) =>
      (event.buttons & kPrimaryButton != 0) && entries.any((e) => e.hitTest(event.position));

  @override
  @protected
  void handleEvent(PointerEvent event) {
    switch (event) {
      case PointerDownEvent(:final buttons, :final position):
        assert(
          _state == .idle,
          '_state ($_state) must be idle. '
          'This is likely a bug in Forui. Please file a bug report: https://github.com/duobaseio/forui/issues/new?template=bug_report.md',
        );

        if (entries.firstWhereOrNull((e) => e.hitTest(position)) case final entry?) {
          _state = .pressing;
          _current = entry;
          _current!.onPressStart(buttons);
          _start();
        }

      case PointerMoveEvent(:final buttons, :final position):
        if (_current?.hitTest(position) ?? false) {
          // Internal movements.
          return;
        }

        _state = .sliding;
        _current?.onPressCancel();
        _current = null;
        _cancel();

        if (entries.firstWhereOrNull((e) => e.hitTest(position)) case final entry?) {
          _state = .slidePressing;
          _current = entry;
          _current!.onPressStart(buttons);
          _start();
        }

      case PointerUpEvent(:final pointer):
        switch (_state) {
          // It is possible that the gesture is accepted before [PointerUpEvent] is called.
          case .slidePressing || .pressing when _accepted:
            _current?.onPressEnd();
            _current?.onPress?.call();

          case .slidePressing || .pressing:
            _current?.onPressEnd();
            _pendingOnPress = _current?.onPress;

          // These two cases provide consistency with .slidePressing triggering onPress even if the tappable which was
          // slided to has been held for a long time.
          case .longPressing when _current?.onLongPress == null && _accepted:
            _current?.onPressEnd();
            _current?.onPress?.call();

          case .longPressing when _current?.onLongPress == null:
            _current?.onPressEnd();
            _pendingOnPress = _current?.onPress;

          case .longPressing:
            _current?.onPressEnd();

          default:
        }

        _state = .idle;
        _accepted = false;
        _current = null;
        _cancel();
        stopTrackingPointer(pointer);

      case PointerCancelEvent():
        _state = .idle;
        _current?.onPressCancel();
        _current = null;
        _cancel();
        resolve(.rejected);
    }
  }

  @override
  void acceptGesture(int pointer) {
    _accepted = true;
    _pendingOnPress?.call();
    _pendingOnPress = null;
  }

  @override
  void rejectGesture(int pointer) {
    _state = .idle;
    _accepted = false;
    _pendingOnPress = null;
    _current?.onPressCancel();
    _current = null;
    _cancel();
    stopTrackingPointer(pointer);
  }

  @override
  @protected
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void dispose() {
    _cancel();
    super.dispose();
  }

  void _start() {
    final current = _current;
    _longPressTimer = Timer(kLongPressTimeout, () {
      if (_current == current && (_state == .pressing || _state == .slidePressing)) {
        _state = .longPressing;
        _current?.onLongPress?.call(); // We immediately call this to mirror [LongPressGestureRecognizer]'s behaviour.
        resolve(.accepted);
      }
    });
  }

  void _cancel() {
    _longPressTimer?.cancel();
    _longPressTimer = null;
  }

  @override
  String get debugDescription => 'slide across tappables';

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('entries', entries));
  }
}
