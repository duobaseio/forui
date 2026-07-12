import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

class VerticalTitleDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget title;
  final List<Widget> actions;

  const VerticalTitleDialog({
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
              padding: touch ? const .only(left: 8, right: 8, bottom: 20) : const .only(left: 8, right: 8, bottom: 16),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Column(mainAxisSize: .min, spacing: touch ? 10 : 8, children: actions),
          ],
        ),
      );
    },
  );
}
