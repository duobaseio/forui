import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

part 'carousel_controller.control.dart';

/// A controller that controls which [FCarousel] slide is selected.
class FCarouselController extends ValueNotifier<int> {
  int _length;

  /// Creates a [FCarouselController].
  ///
  /// ## Contract
  /// * Throws [AssertionError] if [length] <= 0.
  /// * Throws [AssertionError] if [index] is not in the range `0 <= index < length`.
  FCarouselController({required int length, int index = 0})
    : assert(0 < length, 'length ($length) should be > 0'),
      assert(0 <= index && index < length, 'index ($index) must be between 0 and length ($length), exclusive.'),
      _length = length,
      super(index);

  /// The number of slides.
  ///
  /// Setting this clamps [value] to `length - 1` if it would otherwise be out of range.
  ///
  /// ## Contract
  /// * Throws [AssertionError] if [length] <= 0.
  int get length => _length;

  set length(int length) {
    assert(0 < length, 'length ($length) should be > 0');
    if (_length == length) {
      return;
    }

    _length = length;
    if (length <= super.value) {
      super.value = length - 1;
    } else {
      notifyListeners();
    }
  }

  /// Moves to the next slide, wrapping around to the first slide after the last.
  void next() {
    if (_length <= 1) {
      return;
    }

    _rawValue = (super.value + 1) % _length;
  }

  /// Moves to the previous slide, wrapping around to the last slide before the first.
  void previous() {
    if (_length <= 1) {
      return;
    }

    _rawValue = (super.value - 1 + _length) % _length;
  }

  @override
  set value(int value) {
    if (value >= _length || value < 0) {
      throw StateError('The index must be within the allowed range.');
    }

    _rawValue = value;
  }

  int get _rawValue => super.value;

  set _rawValue(int value) => super.value = value;
}

class _ProxyController extends FCarouselController {
  int _unsynced;
  ValueChanged<int> _onChange;

  _ProxyController(this._unsynced, this._onChange, int length) : super(length: length, index: _unsynced);

  void update(int index, ValueChanged<int> onChange, int length) {
    assert(0 < length, 'length ($length) should be > 0');
    assert(0 <= index && index < length, 'index ($index) must be between 0 and length ($length), exclusive.');
    final changed = _length != length;
    _onChange = onChange;
    _length = length;

    if (super._rawValue != index) {
      _unsynced = index;
      super._rawValue = index;
    } else if (_unsynced != index || changed) {
      _unsynced = index;
      notifyListeners();
    }
  }

  @override
  set _rawValue(int value) {
    if (super.value != value) {
      _unsynced = value;
      _onChange(value);
    }
  }
}

/// A [FCarouselControl] defines how a [FCarousel] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FCarouselControl with Diagnosticable, _$FCarouselControlMixin {
  /// Creates a [FCarouselControl].
  const factory FCarouselControl.managed({
    FCarouselController? controller,
    int? initial,
    int? length,
    ValueChanged<int>? onChange,
  }) = FCarouselManagedControl;

  /// Creates a [FCarouselControl] for controlling a carousel using lifted state.
  ///
  /// The [index] parameter contains the current slide index.
  /// The [onChange] callback is invoked when the user changes the slide.
  const factory FCarouselControl.lifted({
    required int index,
    required ValueChanged<int> onChange,
    required int length,
  }) = _Lifted;

  const FCarouselControl._();

  (FCarouselController, bool) _update(
    FCarouselControl old,
    FCarouselController controller,
    VoidCallback callback,
  );
}

/// A [FCarouselManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FCarouselManagedControl extends FCarouselControl with Diagnosticable, _$FCarouselManagedControlMixin {
  /// The controller.
  @override
  final FCarouselController? controller;

  /// The initial slide index. Defaults to 0.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final int? initial;

  /// The number of slides. Defaults to 1.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [length] and [controller] are both provided.
  @override
  final int? length;

  /// Called when the slide changes.
  @override
  final ValueChanged<int>? onChange;

  /// Creates a [FCarouselControl].
  const FCarouselManagedControl({this.controller, this.initial, this.length, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial index. Pass initial index to the controller.',
      ),
      assert(
        controller == null || length == null,
        'Cannot provide both controller and length. Pass length to the controller.',
      ),
      super._();

  @override
  FCarouselController createController() =>
      controller ?? .new(length: length ?? 1, index: initial ?? 0);
}

class _Lifted extends FCarouselControl with _$_LiftedMixin {
  @override
  final int index;
  @override
  final ValueChanged<int> onChange;
  @override
  final int length;

  const _Lifted({required this.index, required this.onChange, required this.length}) : super._();

  @override
  FCarouselController createController() => _ProxyController(index, onChange, length);

  @override
  void _updateController(FCarouselController controller) =>
      (controller as _ProxyController).update(index, onChange, length);
}
