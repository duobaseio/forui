import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@internal
class Caret extends StatefulWidget {
  final Color color;
  final double width;
  final double height;
  final bool cursorOpacityAnimates;

  const Caret({
    required this.color,
    required this.width,
    required this.height,
    required this.cursorOpacityAnimates,
    super.key,
  });

  @override
  State<Caret> createState() => _CaretState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('height', height))
      ..add(FlagProperty('cursorOpacityAnimates', value: cursorOpacityAnimates));
  }
}

class _CaretState extends State<Caret> with SingleTickerProviderStateMixin {
  /// The duration of half a blink.
  static const _blink = Duration(milliseconds: 500);

  late AnimationController _controller;
  late _DiscreteKeyFrameSimulation _simulation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)..addListener(() => setState(() {}));
    _simulation = _DiscreteKeyFrameSimulation();
    _startBlinking();
  }

  @override
  void didUpdateWidget(covariant Caret old) {
    super.didUpdateWidget(old);
    if (old.cursorOpacityAnimates != widget.cursorOpacityAnimates) {
      _timer?.cancel();
      _controller.stop();
      _startBlinking();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startBlinking() {
    _controller.value = 1.0;
    if (widget.cursorOpacityAnimates) {
      // Schedule as async task to avoid blocking tester.pumpAndSettle indefinitely.
      // See Flutter's editable_text.dart:4694–4701.
      _controller.animateWith(_simulation).whenComplete(() => _timer = Timer(.zero, _startBlinking));
    } else {
      _timer = .periodic(_blink, (_) => setState(() => _controller.value = _controller.value == 0 ? 1 : 0));
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: widget.width,
    height: widget.height,
    child: ColoredBox(color: widget.color.withValues(alpha: widget.color.a * _controller.value)),
  );
}

// Based on Flutter 3.41.5's _DiscreteKeyFrameSimulation in editable_text.dart:533.
class _DiscreteKeyFrameSimulation extends Simulation {
  // Based on Flutter 3.41.5's _KeyFrame in editable_text.dart:511.
  //
  // Values extracted from iOS 15.4 UIKit.
  static const _iOSBlinkingCaretKeyFrames = [
    (time: 0.0, value: 1.0),
    (time: 0.5, value: 1.0),
    (time: 0.5375, value: 0.75),
    (time: 0.575, value: 0.5),
    (time: 0.6125, value: 0.25),
    (time: 0.65, value: 0.0),
    (time: 0.85, value: 0.0),
    (time: 0.8875, value: 0.25),
    (time: 0.925, value: 0.5),
    (time: 0.9625, value: 0.75),
    (time: 1.0, value: 1.0),
  ];

  static const maxDuration = 1.0;

  // The index of the keyframe corresponds to the most recent input `time`.
  int _lastKeyFrame = 0;

  _DiscreteKeyFrameSimulation();

  @override
  double x(double time) {
    // Perform a linear search in the sorted key frame list, starting from the last key frame found, since the input
    // `time` usually monotonically increases by a small amount.
    int current;
    final int end;
    if (time < _iOSBlinkingCaretKeyFrames[_lastKeyFrame].time) {
      // The simulation may have restarted. Search within the index range [0, _lastKeyFrame).
      current = 0;
      end = _lastKeyFrame;
    } else {
      current = _lastKeyFrame;
      end = _iOSBlinkingCaretKeyFrames.length;
    }

    // Find the target key frame. Don't have to check (end - 1): if (end - 2) doesn't work we'll have to pick (end - 1)
    // anyways.
    while (current < end - 1) {
      assert(_iOSBlinkingCaretKeyFrames[current].time <= time);
      if (time < _iOSBlinkingCaretKeyFrames[current + 1].time) {
        break;
      }
      current += 1;
    }

    _lastKeyFrame = current;
    return _iOSBlinkingCaretKeyFrames[_lastKeyFrame].value;
  }

  @override
  double dx(double time) => 0;

  @override
  bool isDone(double time) => maxDuration <= time;
}
