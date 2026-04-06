import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

@internal
class TooltipGroupScope extends InheritedWidget {
  static TooltipGroupScope? maybeOf(BuildContext context) => context.getInheritedWidgetOfExactType<TooltipGroupScope>();

  final FTooltipStyle style;
  final bool active;
  final VoidCallback show;
  final VoidCallback hide;
  final bool hover;
  final bool longPress;

  const TooltipGroupScope._(
    this.style,
    this.active,
    this.show,
    this.hide,
    this.hover,
    this.longPress, {
    required super.child,
  });

  @override
  bool updateShouldNotify(TooltipGroupScope old) =>
      style != old.style ||
      active != old.active ||
      show != old.show ||
      hide != old.hide ||
      hover != old.hover ||
      longPress != old.longPress;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('active', value: active, ifTrue: 'active'))
      ..add(ObjectFlagProperty.has('show', show))
      ..add(ObjectFlagProperty.has('hide', hide))
      ..add(FlagProperty('hover', value: hover, ifTrue: 'hover'))
      ..add(FlagProperty('longPress', value: longPress, ifTrue: 'longPress'));
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
  /// The tooltip's style.
  ///
  /// This style is passed down to all child [FTooltip]s in this group. Individual tooltips can override this style
  /// using their own [FTooltip.style] parameter.
  final FTooltipStyleDelta style;

  /// The duration subsequent tooltips in this group will appear instantly on hover. Defaults to 300ms.
  final Duration activeDuration;

  /// True if child [FTooltip]s should be shown when hovered over. Defaults to true.
  final bool hover;

  /// True if child [FTooltip]s should be shown when long pressed. Defaults to true.
  final bool longPress;

  /// The child widget tree containing [FTooltip]s.
  final Widget child;

  /// Creates a tooltip group.
  const FTooltipGroup({
    required this.child,
    this.style = const .context(),
    this.activeDuration = const Duration(milliseconds: 300),
    this.hover = true,
    this.longPress = true,
    super.key,
  });

  @override
  State<FTooltipGroup> createState() => _FTooltipGroupState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('activeDuration', activeDuration))
      ..add(FlagProperty('hover', value: hover, ifTrue: 'hover'))
      ..add(FlagProperty('longPress', value: longPress, ifTrue: 'longPress'));
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
    widget.style(context.theme.tooltipStyle),
    _active,
    _show,
    _hide,
    widget.hover,
    widget.longPress,
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
