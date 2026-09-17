import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Toast extends StatelessWidget {
  const Toast({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        FButton(
          key: const ValueKey('show'),
          variant: .outline,
          size: .sm,
          mainAxisSize: .min,
          prefix: const Icon(FLucideIcons.calendarCheck),
          onPress: () => showFToast(
            context: context,
            icon: const Icon(FLucideIcons.calendarCheck),
            title: const Text('Event has been created'),
            description: const Text('Friday, May 23, 2025 at 9:00 AM'),
          ),
          child: const Text('Show'),
        ),
        FButton(
          key: const ValueKey('pin'),
          variant: .outline,
          size: .sm,
          mainAxisSize: .min,
          prefix: const Icon(FLucideIcons.pin),
          onPress: () => showFToast(
            context: context,
            variant: .destructive,
            duration: null,
            icon: const Icon(FLucideIcons.wifiOff),
            title: const Text('No internet connection'),
            description: const Text('Reconnect to sync your changes.'),
          ),
          child: const Text('Pin'),
        ),
        FButton(
          key: const ValueKey('undo'),
          variant: .outline,
          size: .sm,
          mainAxisSize: .min,
          prefix: const Icon(FLucideIcons.undo2),
          onPress: () => showFToast(
            context: context,
            icon: const Icon(FLucideIcons.trash2),
            title: const Text('Message deleted'),
            description: const Text('1 message removed.'),
            suffixBuilder: (context, entry) => IntrinsicHeight(
              child: FButton(
                style: .delta(
                  contentStyle: .delta(
                    padding: const .value(.symmetric(horizontal: 12, vertical: 7.5)),
                    textStyle: FVariants.all(
                      context.theme.typography.body.xs.copyWith(color: context.theme.colors.primaryForeground),
                    ),
                  ),
                ),
                onPress: entry.dismiss,
                child: const Text('Undo'),
              ),
            ),
          ),
          child: const Text('Undo'),
        ),
      ],
    ),
  );
}
