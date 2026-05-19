import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/slider_value.dart';

/// Possible ways for a user to interact with a slider.
enum FSliderInteraction {
  /// Allows the user to interact with the slider by sliding anywhere on the track.
  slide,

  /// Allows the user to interact with the slider by sliding only the slider thumb.
  slideThumb,

  /// Allows the user to interact with the slider by tapping and sliding the slider thumb.
  tapAndSlideThumb,

  /// Allows the user to interact with the slider by tapping anywhere.
  tap,
}

/// The active thumb in a single-value slider.
enum FSliderActiveThumb {
  /// The thumb at the min edge is active.
  min,

  /// The thumb at the max edge is active.
  max,
}

/// The haptic feedback type.
enum FSliderHaptic {
  /// The active edge collided with a wall: the track's lower/upper limit, the other thumb, or a minimum range extent.
  collision,

  /// The active edge landed on a new discrete tick.
  tick,
}

/// A controller that manages a slider's active track.
///
/// This class should be extended to customize value. By default, the following controllers are provided:
/// * [FContinuousSliderController.new] for selecting a single continuous value.
/// * [FContinuousSliderController.range] for selecting continuous range.
/// * [FDiscreteSliderController.new] for selecting a discrete value.
/// * [FDiscreteSliderController.range] for selecting a discrete range.
abstract class FSliderController extends FChangeNotifier {
  /// The allowed ways to interaction with the slider. Defaults to [FSliderInteraction.tapAndSlideThumb].
  final FSliderInteraction interaction;

  /// Whether the active track is expandable at the min and max edges.
  final ({bool min, bool max}) active;

  /// The minimum absolute per-frame drag delta, in pixels, required for [FSliderHaptic.collision] to fire when an
  /// active edge collides with the track's limit, the other thumb, or a minimum range extent.
  ///
  /// ## Contract
  /// Should be a non-negative finite number.
  final double hapticFeedbackVelocity;

  final FSliderValue _initial;
  FSliderValue? _value;
  Set<double> _ticks = const {};

  /// Creates a [FSliderController] for selecting a single value.
  FSliderController({
    required FSliderValue value,
    this.interaction = .tapAndSlideThumb,
    this.hapticFeedbackVelocity = 6.5,
    FSliderActiveThumb thumb = .max,
  }) : active = (min: thumb == .min, max: thumb == .max),
       _initial = value,
       assert(0 <= hapticFeedbackVelocity, 'hapticFeedbackVelocity ($hapticFeedbackVelocity) must be >= 0');

  /// Creates a [FSliderController] for selecting a range.
  FSliderController.range({required FSliderValue value, this.hapticFeedbackVelocity = 6.5})
    : interaction = .tapAndSlideThumb,
      active = (min: true, max: true),
      _initial = value,
      assert(0 <= hapticFeedbackVelocity, 'hapticFeedbackVelocity ($hapticFeedbackVelocity) must be >= 0');

  /// Registers the controller to a slider with the given extent and marks.
  ///
  /// A controller can only be attached to a single slider at a time.
  void attach(double extent, List<FSliderMark> marks);

  /// Moves the active track on the [min] edge to the previous/next step.
  ///
  /// Returns `true` when the caller should fire a tick haptic.
  bool step({required bool min, required bool expand}) {
    if (_value case final old? when old != (value = old.step(min: min, expand: expand))) {
      final (from, to) = min ? (old.pixels.min, value.pixels.min) : (old.pixels.max, value.pixels.max);
      for (final tick in _ticks) {
        if (_cross(from, tick, to)) {
          return true;
        }
      }
    }

    return false;
  }

  /// Slides the active track to the given [offset] on the [min] edge, in logical pixels.
  ///
  /// The delta is relative to the origin defined by [FSlider.layout]. [velocity] is the absolute per-frame drag delta
  /// in pixels; it gates the [FSliderHaptic.collision] event via [hapticFeedbackVelocity].
  ///
  /// Returns the haptic type the caller should fire, or `null` when no haptic should fire.
  FSliderHaptic? slide(double offset, {required bool min, double velocity = 0}) {
    if (interaction == .tap) {
      return null;
    }

    assert(min ? active.min : active.max, 'Slider is not extendable at the ${min ? 'min' : 'max'} edge.');
    if (_value case final old? when old != (value = old.move(min: min, to: offset))) {
      final range = value.pixels.max - value.pixels.min;
      final oldRange = old.pixels.max - old.pixels.min;

      final minBound = value.pixels.min == 0 && 0 < old.pixels.min;
      final maxBound =
          value.pixels.max == value.pixelConstraints.extent && old.pixels.max < old.pixelConstraints.extent;
      final minRange = range == value.pixelConstraints.min && value.pixelConstraints.min < oldRange;
      final maxRange = range == value.pixelConstraints.max && oldRange < value.pixelConstraints.max;

      if ((minBound || maxBound || minRange || maxRange) && hapticFeedbackVelocity <= velocity.abs()) {
        return .collision;
      }

      final (from, to) = min ? (old.pixels.min, value.pixels.min) : (old.pixels.max, value.pixels.max);
      for (final tick in _ticks) {
        if (_cross(from, tick, to)) {
          return .tick;
        }
      }
    }

    return null;
  }

  bool _cross(double from, double tick, double to) {
    if (from < to) {
      return from < tick && tick <= to;
    } else if (to < from) {
      return to <= tick && tick < from;
    } else {
      return false;
    }
  }

  /// Taps the slider at given offset, in logical pixels, along the track.
  ///
  /// Returns a record where:
  /// * `thumb` is the edge that was moved, or `null` if no edge was moved.
  /// * `haptic` is `true` when the caller should fire a tick haptic.
  ///
  /// The offset is relative to the origin defined by [FSlider.layout].
  ({FSliderActiveThumb? thumb, bool haptic}) tap(double offset) {
    if (interaction == .slide || interaction == .slideThumb) {
      return (thumb: null, haptic: false);
    }

    FSliderActiveThumb? thumb;
    var haptic = false;

    if (_value case final old?) {
      thumb = switch (active) {
        (min: true, max: true) when offset < old.pixels.min => .min,
        (min: true, max: true) when old.pixels.max < offset => .max,
        (min: true, max: false) => .min,
        (min: false, max: true) => .max,
        _ => null,
      };

      if (thumb != null) {
        value = old.move(min: thumb == .min, to: offset);
        haptic = old != value && _ticks.contains(thumb == .min ? value.pixels.min : value.pixels.max);
      }
    }

    return (thumb: thumb, haptic: haptic);
  }

  /// Resets the controller to its initial state.
  void reset();

  /// The slider's active track/value.
  FSliderValue get value => _value ?? _initial;

  set value(FSliderValue? value) {
    if (value == null || _value == value) {
      return;
    }

    _value = value;
    notifyListeners();
  }
}

/// A controller that manages a slider's active track which represents a continuous range/value.
class FContinuousSliderController extends FSliderController {
  /// The percentage of the track that represents a single step. Defaults to 0.05.
  ///
  /// ## Contract
  /// Throws [AssertionError] if it is not between 0 and 1, inclusive.
  final double stepPercentage;

  /// Creates a [FContinuousSliderController] for selecting a single value.
  FContinuousSliderController({
    required super.value,
    this.stepPercentage = 0.05,
    super.interaction,
    super.thumb,
    super.hapticFeedbackVelocity,
  }) : assert(
         0 <= stepPercentage && stepPercentage <= 1,
         'stepPercentage ($stepPercentage) must be between 0 and 1, inclusive.',
       );

  /// Creates a [FContinuousSliderController] for selecting a range.
  FContinuousSliderController.range({required super.value, this.stepPercentage = 0.05, super.hapticFeedbackVelocity})
    : assert(
        0 <= stepPercentage && stepPercentage <= 1,
        'stepPercentage ($stepPercentage) must be between 0 and 1, inclusive.',
      ),
      super.range();

  @override
  @internal
  void attach(double extent, List<FSliderMark> marks) {
    final proposed = ContinuousValue(
      step: stepPercentage,
      extent: extent,
      constraints: value.constraints,
      min: value.min,
      max: value.max,
    );

    if (_value == null) {
      _value = proposed; // We don't want to notify listeners when performing initialization.
    } else {
      value = proposed;
    }

    _ticks = {
      for (final FSliderMark(:tick, :value) in marks)
        if (tick) value * extent,
    };
  }

  @override
  void reset() {
    if (_value case FSliderValue(:final pixelConstraints)) {
      value = ContinuousValue(
        step: stepPercentage,
        extent: pixelConstraints.extent,
        constraints: _initial.constraints,
        min: _initial.min,
        max: _initial.max,
      );
    }
  }
}

/// A controller that manages a slider's active track which represents a discrete range/value.
class FDiscreteSliderController extends FSliderController {
  /// Creates a [FDiscreteSliderController] for selecting a single value.
  FDiscreteSliderController({required super.value, super.interaction, super.thumb, super.hapticFeedbackVelocity});

  /// Creates a [FDiscreteSliderController] for selecting a range.
  FDiscreteSliderController.range({required super.value, super.hapticFeedbackVelocity}) : super.range();

  @override
  void attach(double extent, List<FSliderMark> marks) {
    assert(marks.isNotEmpty, 'At least one mark is required.');

    final proposed = DiscreteValue(
      extent: extent,
      constraints: value.constraints,
      min: value.min,
      max: value.max,
      ticks: .fromIterable(marks.map((mark) => mark.value), value: (_) {}),
    );

    if (_value == null) {
      _value = proposed; // We don't want to notify listeners when performing initialization.
    } else {
      value = proposed;
    }

    _ticks = {
      for (final FSliderMark(:tick, :value) in marks)
        if (tick) value * extent,
    };
  }

  @override
  void reset() {
    if (_value case DiscreteValue(:final ticks, :final pixelConstraints)) {
      value = DiscreteValue(
        ticks: ticks,
        extent: pixelConstraints.extent,
        constraints: _initial.constraints,
        min: _initial.min,
        max: _initial.max,
      );
    }
  }
}

/// A proxy controller for lifted mode that forwards all changes to the parent's onSelect callback.
@internal
class ProxyContinuousSliderController extends FContinuousSliderController {
  ValueChanged<FSliderValue> _onChange;

  ProxyContinuousSliderController({
    required super.value,
    required this._onChange,
    required super.stepPercentage,
    required super.interaction,
    required super.thumb,
    super.hapticFeedbackVelocity,
  }) : super();

  ProxyContinuousSliderController.range({
    required super.value,
    required this._onChange,
    required super.stepPercentage,
    super.hapticFeedbackVelocity,
  }) : super.range();

  @override
  void attach(double extent, List<FSliderMark> marks) {
    // Directly set _value without triggering _onChange - attach is internal, not user-initiated
    _value = ContinuousValue(
      step: stepPercentage,
      extent: extent,
      constraints: value.constraints,
      min: value.min,
      max: value.max,
    );
    _ticks = {
      for (final FSliderMark(:tick, :value) in marks)
        if (tick) value * extent,
    };
  }

  void update({required FSliderValue value, required ValueChanged<FSliderValue> onChange}) {
    _onChange = onChange;
    // Update the value from parent without notifying (parent owns state)
    if (_value?.min != value.min || _value?.max != value.max) {
      _value = value;
      notifyListeners();
    }
  }

  @override
  set value(FSliderValue? value) {
    if (value == null || _value == value) {
      return;
    }

    _onChange(value);
  }
}

/// A proxy controller for lifted mode that forwards all changes to the parent's onSelect callback.
@internal
class ProxyDiscreteSliderController extends FDiscreteSliderController {
  ValueChanged<FSliderValue> _onChange;

  ProxyDiscreteSliderController({
    required super.value,
    required this._onChange,
    required super.interaction,
    required super.thumb,
    super.hapticFeedbackVelocity,
  }) : super();

  ProxyDiscreteSliderController.range({
    required super.value,
    required this._onChange,
    super.hapticFeedbackVelocity,
  }) : super.range();

  @override
  void attach(double extent, List<FSliderMark> marks) {
    assert(marks.isNotEmpty, 'At least one mark is required.');

    // Directly set _value without triggering _onChange - attach is internal, not user-initiated
    _value = DiscreteValue(
      extent: extent,
      constraints: value.constraints,
      min: value.min,
      max: value.max,
      ticks: .fromIterable(marks.map((mark) => mark.value), value: (_) {}),
    );
    _ticks = {
      for (final FSliderMark(:tick, :value) in marks)
        if (tick) value * extent,
    };
  }

  void update({required FSliderValue value, required ValueChanged<FSliderValue> onChange}) {
    _onChange = onChange;
    // Update the value from parent without notifying (parent owns state)
    if (_value?.min != value.min || _value?.max != value.max) {
      _value = value;
      notifyListeners();
    }
  }

  @override
  set value(FSliderValue? value) {
    if (value == null || _value == value) {
      return;
    }

    _onChange(value);
  }
}
