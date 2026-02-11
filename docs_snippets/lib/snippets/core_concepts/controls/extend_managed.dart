import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
class CustomController extends FPopoverController {
  final int customValue;

  CustomController({required this.customValue, required super.vsync});
}

class CustomManagedControl extends FPopoverManagedControl {
  final int customValue;

  CustomManagedControl({required this.customValue});

  @override
  CustomController createController(TickerProvider vsync) => CustomController(
    customValue: customValue,
    vsync: vsync,
  );
}

// Usage:
final example = FPopover(
  control: CustomManagedControl(customValue: 42),
  child: const Placeholder(),
  popoverBuilder: (_, _) => const Placeholder(),
);
// {@endsnippet}
