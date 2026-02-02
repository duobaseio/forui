import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

@internal
class InheritedVariants extends InheritedWidget {
  static InheritedVariants of(BuildContext context) {
    assert(debugCheckHasAncestor<InheritedVariants>('$FSlider', context));
    return context.dependOnInheritedWidgetOfExactType<InheritedVariants>()!;
  }

  final Set<FVariant> variants;

  const InheritedVariants({required this.variants, required super.child, super.key});

  @override
  bool updateShouldNotify(InheritedVariants old) => !setEquals(variants, old.variants);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('variants', variants));
  }
}
