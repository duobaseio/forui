import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

@internal
class InheritedSelectController<T> extends InheritedWidget {
  static InheritedSelectController<T> of<T>(BuildContext context) {
    assert(
      debugCheckHasAncestor<InheritedSelectController<T>>('${FSelect<T>}/${FMultiSelect<T>}', context, generic: true),
    );
    return context.dependOnInheritedWidgetOfExactType<InheritedSelectController<T>>()!;
  }

  final FPopoverController popover;
  final bool Function(T) contains;
  final ValueChanged<T> onPress;

  const InheritedSelectController({
    required this.popover,
    required this.contains,
    required this.onPress,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(InheritedSelectController<T> old) =>
      popover != old.popover || contains != old.contains || onPress != old.onPress;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popover', popover))
      ..add(ObjectFlagProperty.has('contains', contains))
      ..add(ObjectFlagProperty.has('onPress', onPress));
  }
}
