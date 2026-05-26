import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class PointPortalPage extends StatefulExample {
  PointPortalPage({@queryParam super.theme});

  @override
  State<PointPortalPage> createState() => _State();
}

class _State extends StatefulExampleState<PointPortalPage> {
  final _controller = OverlayPortalController();
  Offset _point = const Offset(75, 50);

  @override
  Widget example(BuildContext context) => FPointPortal(
    control: .managed(controller: _controller),
    point: _point,
    padding: const .all(5),
    portalBuilder: (context, _) => Container(
      decoration: BoxDecoration(
        color: context.theme.colors.background,
        border: .all(color: context.theme.colors.border),
        borderRadius: .circular(4),
      ),
      padding: const .only(left: 20, top: 14, right: 20, bottom: 10),
      child: SizedBox(
        width: 288,
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text('Dimensions', style: context.theme.typography.md),
            const SizedBox(height: 7),
            Text(
              'Set the dimensions for the layer.',
              style: context.theme.typography.sm.copyWith(
                color: context.theme.colors.mutedForeground,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 15),
            for (final (label, value) in [('Width', '100%'), ('Max. Width', '300px')]) ...[
              Row(
                children: [
                  Expanded(child: Text(label, style: context.theme.typography.sm)),
                  Expanded(
                    flex: 2,
                    child: FTextField(
                      control: .managed(initial: TextEditingValue(text: value)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
            ],
          ],
        ),
      ),
    ),
    child: GestureDetector(
      onTapDown: (d) {
        setState(() => _point = d.localPosition);
        _controller.show();
      },
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(color: context.theme.colors.muted, borderRadius: .circular(4)),
        alignment: .center,
        child: Text('Tap anywhere', style: context.theme.typography.sm),
      ),
    ),
  );
}
