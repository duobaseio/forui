import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class OverlayPage extends StatefulExample {
  OverlayPage({@queryParam super.theme});

  @override
  State<OverlayPage> createState() => _State();
}

class _State extends StatefulExampleState<OverlayPage> {
  @override
  Widget example(BuildContext context) => FOverlay(
    overlay: [
      Positioned(
        top: -50,
        left: 0,
        child: Container(
          padding: const .symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: context.theme.colors.background,
            border: .all(color: context.theme.colors.border),
            borderRadius: .circular(4),
          ),
          child: Text('Overlay content', style: context.theme.typography.sm),
        ),
      ),
    ],
    builder: (context, controller, _) => FButton(
      variant: .outline,
      size: .sm,
      mainAxisSize: .min,
      onPress: controller.toggle,
      child: const Text('Toggle Overlay'),
    ),
  );
}
