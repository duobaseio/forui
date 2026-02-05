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

  const TooltipGroupScope._(this.active, this.show, this.hide, {required super.child});

  @override
  bool updateShouldNotify(TooltipGroupScope old) => false;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('active', value: active, ifTrue: 'active'))
      ..add(ObjectFlagProperty.has('show', show))
      ..add(ObjectFlagProperty.has('hide', hide));
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
  /// The duration subsequent tooltips in this group will appear instantly on hover. Defaults to 300ms.
  final Duration activeDuration;

  /// The child widget tree containing [FTooltip]s.
  final Widget child;

  /// Creates a tooltip group.
  const FTooltipGroup({required this.child, this.activeDuration = const Duration(milliseconds: 300), super.key});

  @override
  State<FTooltipGroup> createState() => _FTooltipGroupState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('activeDuration', activeDuration));
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
  Widget build(BuildContext context) => TooltipGroupScope._(_active, _show, _hide, child: widget.child);

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
