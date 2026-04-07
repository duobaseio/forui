import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';
import 'package:forui/src/widgets/popover_menu/popover_menu.dart';

@internal
class SubmenuTrigger extends StatefulWidget {
  final FPopoverController controller;
  final Widget child;

  const SubmenuTrigger({required this.controller, required this.child, super.key});

  @override
  State<SubmenuTrigger> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', controller));
  }
}

class _State extends State<SubmenuTrigger> {
  final Key _key = UniqueKey();
  ValueNotifier<(Key?, bool)>? _active;
  FPopoverController? _parent;
  FPopoverMenuStyle? _style;
  int _monotonic = 0;
  bool _hovered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final current = PopoverMenuScope.maybeOf(context);
    if (current?.active != _active) {
      _active?.removeListener(_handleSiblingShow);
      _active = current?.active;
      _active?.addListener(_handleSiblingShow);
    }
    if (current?.controller != _parent) {
      _parent?.removeStatusListener(_handleParentHide);
      _parent = current?.controller;
      _parent?.addStatusListener(_handleParentHide);
    }
    _style = current?.style;
  }

  @override
  void dispose() {
    _active?.removeListener(_handleSiblingShow);
    _parent?.removeStatusListener(_handleParentHide);
    super.dispose();
  }

  // Hide this submenu without animation when a sibling becomes active, so rapid switches between siblings don't
  // produce jarring overlapping show/hide animations.
  void _handleSiblingShow() {
    if (_active?.value case (final key, final hovered) when key != _key) {
      widget.controller.hide(animated: !hovered);
    }
  }

  // Cascade hiding to this submenu when the parent popover hides, otherwise it stays visible until the parent's
  // animation completes and then abruptly disappears.
  Future<void> _handleParentHide(AnimationStatus status) async {
    if (status == .reverse) {
      await widget.controller.hide();
      _active?.value = (null, false);
    }
  }

  @override
  Widget build(BuildContext context) => switch ((_active, _style)) {
    (final active?, final style?) => FInheritedItemCallbacks(
      onHoverEnter: () async {
        _hovered = true;

        final (key, hovered) = active.value;
        active.value = (key, true);

        final token = _monotonic;
        await Future.delayed(style.hoverEnterDuration);

        if (token == _monotonic && mounted) {
          active.value = (_key, true);
          unawaited(widget.controller.show(animated: !hovered));
        }
      },
      onHoverExit: () {
        _hovered = false;
        _monotonic++;
      },
      onPress: _toggle,
      onLongPress: () {
        unawaited(style.hapticFeedback());
        _toggle();
      },
      child: widget.child,
    ),
    (_, _) => widget.child,
  };

  void _toggle() {
    if (_hovered) {
      return;
    }

    final (key, hovered) = _active!.value;
    if (key == _key) {
      _active!.value = (null, false);
      widget.controller.hide(animated: !hovered);
    } else {
      _active!.value = (_key, hovered);
      widget.controller.show(animated: !hovered);
    }
  }
}
