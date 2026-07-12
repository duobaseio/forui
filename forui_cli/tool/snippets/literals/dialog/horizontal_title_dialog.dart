import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

class HorizontalTitleDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget title;
  final List<Widget> actions;

  const HorizontalTitleDialog({
    required this.title,
    required this.actions,
    this.style = const .context(),
    this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FDialog(
    style: style,
    animation: animation,
    builder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Padding(
              padding: touch ? const .only(left: 8, right: 8, bottom: 20) : const .only(bottom: 16),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Row(
              mainAxisAlignment: .end,
              spacing: touch ? 10 : 8,
              children: touch ? [for (final action in actions) Expanded(child: action)] : actions,
            ),
          ],
        ),
      );
    },
  );
}
