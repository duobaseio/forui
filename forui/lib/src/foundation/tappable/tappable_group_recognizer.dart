import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:collection/collection.dart';

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
  Future<void> Function() slidePressHapticFeedback;
  TappableGroupGestureRecognizerState _state;
  GroupEntry? _current;
  Timer? _longPressTimer;
  bool _accepted = false;
  Offset _origin = .zero;
  Offset _lastPosition = .zero;

  /// The entry whose tap is awaiting arena resolution, paired with the [TapUpDetails] captured at PointerUp. Only set
  /// for same-child taps (pressing → idle) where we defer to the arena sweep — this lets scroll recognizers win the
  /// sweep when competing. [acceptGesture] fires `onPressUp` + `onPress`; [rejectGesture] fires `onPressCancel`.
  (GroupEntry, TapUpDetails)? _pending;

  TappableGroupGestureRecognizer(this.entries, this.slidePressHapticFeedback) : _state = .idle;

  @override
  @protected
  bool isPointerAllowed(PointerDownEvent event) =>
      (event.buttons & kPrimaryButton != 0) && entries.any((e) => e.hitTest(event.position));

  @override
  @protected
  void handleEvent(PointerEvent event) {
    switch (event) {
      case PointerDownEvent(:final buttons, :final position, :final kind):
        assert(
          _state == .idle,
          '_state ($_state) must be idle. '
          'This is likely a bug in Forui. Please file a bug report: https://github.com/duobaseio/forui/issues/new?template=bug_report.md',
        );

        // Pressed down on an entry.
        if (entries.firstWhereOrNull((e) => e.hitTest(position)) case final entry?) {
          _state = .pressing;
          _current = entry;
          _origin = position;
          _lastPosition = position;
          _start(entry, buttons, position, kind);
        }

      case PointerMoveEvent(:final buttons, :final position, :final kind, :final delta):
        _lastPosition = position;

        // Internal movement over the current entry.
        if (_current case final current? when current.hitTest(position)) {
          if (_state == .longPressing) {
            current.onLongPressMove?.call(
              LongPressMoveUpdateDetails(
                globalPosition: position,
                localPosition: current.localPosition(position),
                offsetFromOrigin: position - _origin,
                localOffsetFromOrigin: current.localPosition(position) - current.localPosition(_origin),
              ),
            );
          } else {
            current.onPressMove?.call(
              TapMoveDetails(
                globalPosition: position,
                localPosition: current.localPosition(position),
                kind: kind,
                delta: delta,
              ),
            );
          }

          return;
        }

        // Moved out of the current.
        if (_current case final current?) {
          current.exit();
          if (_state == .longPressing) {
            current.onLongPressEnd?.call(
              LongPressEndDetails(globalPosition: position, localPosition: current.localPosition(position)),
            );
          } else {
            current.onPressCancel?.call();
            current.onLongPressCancel?.call();
          }
        }
        _current = null;
        _state = .sliding;
        _cancel();

        // Moved into another entry.
        if (entries.firstWhereOrNull((e) => e.hitTest(position)) case final entry?) {
          _state = .slidePressing;
          unawaited(slidePressHapticFeedback());
          _current = entry;
          _origin = position;
          _start(entry, buttons, position, kind);
        }

      case PointerUpEvent(:final pointer, :final position, :final kind):
        _lastPosition = position;

        switch (_state) {
          // It is possible that the gesture is accepted before [PointerUpEvent] is called.
          case .slidePressing || .pressing when _accepted:
            if (_current case final current?) {
              current.release();
              current.onPressUp?.call(
                TapUpDetails(globalPosition: position, localPosition: current.localPosition(position), kind: kind),
              );
              current.onPress?.call();
              current.onLongPressCancel?.call();
            }

          // Tap not yet accepted. Defer so scroll recognizers can still win the sweep.
          case .slidePressing || .pressing:
            if (_current case final current?) {
              current.release();
              _pending = (
                current,
                TapUpDetails(globalPosition: position, localPosition: current.localPosition(position), kind: kind),
              );
              // onLongPressCancel doesn't depend on arena; fire immediately.
              current.onLongPressCancel?.call();
            }

          // Long-press recognized but current has no onLongPress. Fire onPress as the documented
          // slide-across-after-long-press fallback, alongside the long-press end callbacks.
          //
          // No deferral: long-press already won the arena via the timer's resolve(.accepted) so scroll can't take this
          // anymore.
          case .longPressing when _current?.onLongPress == null:
            if (_current case final current?) {
              current.release();
              current.onPressUp?.call(
                TapUpDetails(globalPosition: position, localPosition: current.localPosition(position), kind: kind),
              );
              current.onPress?.call();
              current.onLongPressEnd?.call(
                LongPressEndDetails(globalPosition: position, localPosition: current.localPosition(position)),
              );
            }

          // Long-press completed normally — fire end, no tap callbacks.
          case .longPressing:
            if (_current case final current?) {
              current.release();
              current.onLongPressEnd?.call(
                LongPressEndDetails(globalPosition: position, localPosition: current.localPosition(position)),
              );
            }

          default:
        }

        _state = .idle;
        _accepted = false;
        _current = null;
        _cancel();
        stopTrackingPointer(pointer);

      case PointerCancelEvent():
        if (_current case final current?) {
          current.exit();
          // Both press and long press started, so we need to cancel both. We do not need to cancel anything when long
          // pressed as the timer already cancels presses.
          if (_state != .longPressing) {
            current.onPressCancel?.call();
            current.onLongPressCancel?.call();
          }
        }
        _current = null;
        _state = .idle;
        _cancel();
        resolve(.rejected);
    }
  }

  /// Begins a press on [entry]: fires the internal `onPressStart` hook, the user-facing `onPressDown` and
  /// `onLongPressDown` callbacks, and arms the long-press timer.
  void _start(GroupEntry entry, int buttons, Offset position, PointerDeviceKind kind) {
    entry.enter(buttons);

    final localPosition = entry.localPosition(position);
    entry.onPressDown?.call(TapDownDetails(globalPosition: position, localPosition: localPosition, kind: kind));
    entry.onLongPressDown?.call(
      LongPressDownDetails(globalPosition: position, localPosition: localPosition, kind: kind),
    );

    _longPressTimer = Timer(kLongPressTimeout, () {
      if (_current == entry && (_state == .pressing || _state == .slidePressing)) {
        _state = .longPressing;
        // Match Flutter's LongPressGestureRecognizer ordering: onLongPressStart fires before onLongPress, and
        // onTapCancel fires when the tap is rejected by long-press winning the arena.
        entry.onLongPressStart?.call(
          LongPressStartDetails(globalPosition: _lastPosition, localPosition: entry.localPosition(_lastPosition)),
        );
        entry.onLongPress?.call();
        entry.onPressCancel?.call();
        resolve(.accepted);
      }
    });
  }

  @override
  void acceptGesture(int pointer) {
    _accepted = true;
    if (_pending case (final entry, final details)?) {
      entry.onPressUp?.call(details);
      entry.onPress?.call();
    }
    _pending = null;
  }

  @override
  void rejectGesture(int pointer) {
    if (_current case final current?) {
      current.exit();
      // Both press and long press started, so we need to cancel both. We do not need to cancel anything when long
      // pressed as the timer already cancels presses.
      if (_state != .longPressing) {
        current.onPressCancel?.call();
        current.onLongPressCancel?.call();
      }
    }

    // Pending tap (PointerUp already arrived, awaiting arena) is now rejected — fire its cancel.
    if (_pending case (final entry, _)?) {
      entry.onPressCancel?.call();
    }

    _current = null;
    _pending = null;
    _state = .idle;
    _accepted = false;
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

  void _cancel() {
    _longPressTimer?.cancel();
    _longPressTimer = null;
  }

  @override
  String get debugDescription => 'slide across tappables';

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty('entries', entries))
      ..add(ObjectFlagProperty.has('slidePressHapticFeedback', slidePressHapticFeedback));
  }
}
