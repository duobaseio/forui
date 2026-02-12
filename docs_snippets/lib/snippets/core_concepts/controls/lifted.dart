import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool _shown = false;

  @override
  Widget build(BuildContext context) =>
      // {@snippet constructor}
      FPopover(
        control: .lifted(shown: _shown, onChange: (shown) => setState(() => _shown = shown)),
        child: const Placeholder(),
        popoverBuilder: (_, _) => const Placeholder(),
      );
  // {@endsnippet}
}
