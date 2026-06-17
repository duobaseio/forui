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
        builder: (context, style, animation) => FDialog(
          style: style,
          animation: animation,
          direction: .horizontal,
          title: const Text('Are you absolutely sure?'),
          body: const Text(
            'This action cannot be undone. This will permanently delete your account and '
            'remove your data from our servers.',
          ),
          actions: [
            FButton(
              size: .sm,
              onPress: () => Navigator.of(context).pop(),
              child: const Text('Continue'),
            ),
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
