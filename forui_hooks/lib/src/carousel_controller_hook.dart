import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FCarouselController] that is automatically disposed.
FCarouselController useFCarouselController({required int length, int index = 0, List<Object?>? keys}) =>
    use(_CarouselControllerHook(length: length, index: index, keys: keys));

class _CarouselControllerHook extends Hook<FCarouselController> {
  final int length;
  final int index;

  const _CarouselControllerHook({required this.length, required this.index, super.keys});

  @override
  _CarouselControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('length', length))
      ..add(IntProperty('index', index));
  }
}

class _CarouselControllerHookState extends HookState<FCarouselController, _CarouselControllerHook> {
  late final _controller = FCarouselController(length: hook.length, index: hook.index);

  @override
  FCarouselController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFCarouselController';
}
