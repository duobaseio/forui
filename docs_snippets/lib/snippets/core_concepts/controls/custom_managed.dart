import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
class CustomController extends FPopoverController {
  CustomController({required super.vsync});

  // Custom logic here.
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late final CustomController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CustomController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FPopover(
    // {@highlight}
    control: .managed(controller: _controller),
    // {@endhighlight}
    child: const Placeholder(),
    popoverBuilder: (_, _) => const Placeholder(),
  );
}
// {@endsnippet}
