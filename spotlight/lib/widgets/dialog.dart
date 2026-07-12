import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Dialog extends StatelessWidget {
  const Dialog({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: FButton(
      variant: .outline,
      size: .sm,
      mainAxisSize: .min,
      onPress: () => showFDialog(
        context: context,
        builder: (context, style, animation) => HorizontalDialog(
          style: style,
          animation: animation,
          title: const Text('Are you absolutely sure?'),
          body: const Text(
            'This action cannot be undone. This will permanently delete your account and '
            'remove your data from our servers.',
          ),
          actions: [
            FButton(size: .sm, onPress: () => Navigator.of(context).pop(), child: const Text('Continue')),
            FButton(
              variant: .outline,
              size: .sm,
              onPress: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    ),
  );
}

class HorizontalDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget title;
  final Widget body;
  final List<Widget> actions;

  const HorizontalDialog({
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
              padding: touch ? const .only(left: 8, right: 8, bottom: 9) : const .only(bottom: 5),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Flexible(
              child: Padding(
                padding: touch ? const .only(left: 8, right: 8, bottom: 20) : const .only(bottom: 16),
                child: DefaultTextStyle.merge(style: style.bodyTextStyle, child: body),
              ),
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
