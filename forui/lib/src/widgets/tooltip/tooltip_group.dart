import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

@internal
class TooltipGroupScope extends InheritedWidget {
  static TooltipGroupScope? maybeOf(BuildContext context) => context.getInheritedWidgetOfExactType<TooltipGroupScope>();

  final bool active;
  final VoidCallback show;
  final VoidCallback hide;
  final bool hover;
  final Duration hoverEnterDuration;
  final Duration hoverExitDuration;
  final bool longPress;
  final Duration longPressExitDuration;

  const TooltipGroupScope._(
    this.active,
    this.show,
    this.hide, {
    required this.hover,
    required this.hoverEnterDuration,
    required this.hoverExitDuration,
    required this.longPress,
    required this.longPressExitDuration,
    required super.child,
  });

  @override
  bool updateShouldNotify(TooltipGroupScope old) =>
      active != old.active ||
      show != old.show ||
      hide != old.hide ||
      hover != old.hover ||
      hoverEnterDuration != old.hoverEnterDuration ||
      hoverExitDuration != old.hoverExitDuration ||
      longPress != old.longPress ||
      longPressExitDuration != old.longPressExitDuration;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('active', value: active, ifTrue: 'active'))
      ..add(ObjectFlagProperty.has('show', show))
      ..add(ObjectFlagProperty.has('hide', hide))
      ..add(FlagProperty('hover', value: hover, ifTrue: 'hover'))
      ..add(DiagnosticsProperty('hoverEnterDuration', hoverEnterDuration))
      ..add(DiagnosticsProperty('hoverExitDuration', hoverExitDuration))
      ..add(FlagProperty('longPress', value: longPress, ifTrue: 'longPress'))
      ..add(DiagnosticsProperty('longPressExitDuration', longPressExitDuration));
  }
}

/// Groups [FTooltip]s together such that subsequent tooltips after the first one appears instantly until the group
/// becomes inactive after [activeDuration].
///
/// [FTheme] contains a tooltip group by default.
///
/// See:
/// * https://forui.dev/docs/overlay/tooltip for working examples.
/// * [FTooltip] for the tooltip.
class FTooltipGroup extends StatefulWidget {
  /// The default duration to wait before showing child [FTooltip]s after hovering.
  static const defaultHoverEnterDuration = Duration(milliseconds: 500);

  /// The default duration to wait before hiding child [FTooltip]s after the user has stopped hovering.
  static const defaultHoverExitDuration = Duration.zero;

  /// The default duration to wait before hiding child [FTooltip]s after the user has stopped pressing.
  static const defaultLongPressExitDuration = Duration(milliseconds: 1500);

  /// The duration subsequent tooltips in this group will appear instantly on hover. Defaults to 300ms.
  final Duration activeDuration;

  /// True if child [FTooltip]s should be shown when hovered over. Defaults to true.
  final bool hover;

  /// The duration to wait before showing child [FTooltip]s after hovering. Defaults to 500ms.
  final Duration hoverEnterDuration;

  /// The duration to wait before hiding child [FTooltip]s after the user has stopped hovering. Defaults to 0ms.
  final Duration hoverExitDuration;

  /// True if child [FTooltip]s should be shown when long pressed. Defaults to true.
  final bool longPress;

  /// The duration to wait before hiding child [FTooltip]s after the user has stopped pressing. Defaults to 1500ms.
  final Duration longPressExitDuration;

  /// The child widget tree containing [FTooltip]s.
  final Widget child;

  /// Creates a tooltip group.
  const FTooltipGroup({
    required this.child,
    this.activeDuration = const Duration(milliseconds: 300),
    this.hover = true,
    this.hoverEnterDuration = defaultHoverEnterDuration,
    this.hoverExitDuration = defaultHoverExitDuration,
    this.longPress = true,
    this.longPressExitDuration = defaultLongPressExitDuration,
    super.key,
  });

  @override
  State<FTooltipGroup> createState() => _FTooltipGroupState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('activeDuration', activeDuration))
      ..add(FlagProperty('hover', value: hover, ifTrue: 'hover'))
      ..add(DiagnosticsProperty('hoverEnterDuration', hoverEnterDuration))
      ..add(DiagnosticsProperty('hoverExitDuration', hoverExitDuration))
      ..add(FlagProperty('longPress', value: longPress, ifTrue: 'longPress'))
      ..add(DiagnosticsProperty('longPressExitDuration', longPressExitDuration));
  }
}

class _FTooltipGroupState extends State<FTooltipGroup> {
  Timer? _timer;
  bool _active = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TooltipGroupScope._(
    _active,
    _show,
    _hide,
    hover: widget.hover,
    hoverEnterDuration: widget.hoverEnterDuration,
    hoverExitDuration: widget.hoverExitDuration,
    longPress: widget.longPress,
    longPressExitDuration: widget.longPressExitDuration,
    child: widget.child,
  );

  void _show() {
    _timer?.cancel();
    setState(() {
      _active = true;
    });
  }

  void _hide() {
    _timer = Timer(widget.activeDuration, () {
      setState(() {
        _active = false;
      });
    });
  }
}
