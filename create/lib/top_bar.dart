import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:remixicon/remixicon.dart' as remix;
import 'package:url_launcher/url_launcher.dart';

/// The header.
class TopBar extends StatelessWidget {
  /// Opens the sidebar sheet.
  ///
  /// Should be null on wide layouts where the sidebar is inline.
  final VoidCallback? onMenu;

  const TopBar({this.onMenu, super.key});

  @override
  Widget build(BuildContext context) {
    final compact = onMenu != null;

    return Padding(
      padding: compact ? const .all(8) : const .fromLTRB(26, 8, 20, 12),
      child: Row(
        spacing: 8,
        children: [
          if (onMenu case final onMenu?)
            FButton.icon(
              key: const ValueKey('menu'),
              variant: .ghost,
              onPress: onMenu,
              child: const Icon(FLucideIcons.menu),
            ),
          _Logo(height: compact ? 20 : 24),
          const Spacer(),
          FButton(
            variant: .ghost,
            prefix: const Icon(remix.RemixIcons.github_fill),
            onPress: () => launchUrl(Uri.parse('https://github.com/forus-labs/forui')),
            child: const Text('GitHub'),
          ),
          if (!compact)
            FButton(
              variant: .ghost,
              onPress: () => launchUrl(Uri.parse('https://forui.dev')),
              child: const Text('forui.dev'),
            ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final double height;

  const _Logo({required this.height});

  @override
  Widget build(BuildContext context) => Image.asset(
    context.theme.colors.brightness == Brightness.dark ? 'assets/logos/dark_logo.png' : 'assets/logos/light_logo.png',
    height: height,
  );
}
