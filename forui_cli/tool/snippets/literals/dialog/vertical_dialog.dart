import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

class VerticalDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget title;
  final Widget body;
  final List<Widget> actions;

  const VerticalDialog({
    required this.title,
    required this.body,
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
              padding: touch ? const .only(left: 8, right: 8, bottom: 9) : const .only(left: 8, right: 8, bottom: 5),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Flexible(
              child: Padding(
                padding: touch
                    ? const .only(left: 8, right: 8, bottom: 20)
                    : const .only(left: 8, right: 8, bottom: 16),
                child: DefaultTextStyle.merge(style: style.bodyTextStyle, child: body),
              ),
            ),
            Column(mainAxisSize: .min, spacing: touch ? 10 : 8, children: actions),
          ],
        ),
      );
    },
  );
}
