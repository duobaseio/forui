import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Tooltip extends StatelessWidget {
  const Tooltip({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: FTooltipGroup(
      child: Row(
        mainAxisSize: .min,
        spacing: 2,
        children: [
          FTooltip(
            tipBuilder: (context, _) => const Text('Bold'),
            child: FButton.icon(
              variant: .ghost,
              size: .sm,
              onPress: () {},
              child: const Icon(FIcons.bold),
            ),
          ),
          FTooltip(
            tipBuilder: (context, _) => const Text('Italic'),
            child: FButton.icon(
              variant: .ghost,
              size: .sm,
              onPress: () {},
              child: const Icon(FIcons.italic),
            ),
          ),
          FTooltip(
            tipBuilder: (context, _) => const Text('Underline'),
            child: FButton.icon(
              variant: .ghost,
              size: .sm,
              onPress: () {},
              child: const Icon(FIcons.underline),
            ),
          ),
          FTooltip(
            tipBuilder: (context, _) => const Text('Strikethrough'),
            child: FButton.icon(
              variant: .ghost,
              size: .sm,
              onPress: () {},
              child: const Icon(FIcons.strikethrough),
            ),
          ),
        ],
      ),
    ),
  );
}
