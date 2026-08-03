import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';

/// A loading state shown while the user's linked accounts are being synced.
class SyncingAccountsCard extends StatelessWidget {
  /// Creates a [SyncingAccountsCard].
  const SyncingAccountsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;

    return PreviewCard(
      child: Padding(
        padding: const .symmetric(vertical: 20),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: colors.muted, borderRadius: theme.style.borderRadius.lg),
              child: SizedBox.square(
                dimension: 48,
                child: Center(
                  child: FCircularProgress(
                    style: .delta(iconStyle: .delta(color: colors.foreground, size: 22)),
                    semanticsLabel: 'Syncing your accounts',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Syncing your accounts',
              textAlign: .center,
              style: typography.body.lg.copyWith(color: colors.foreground, fontWeight: .w600),
            ),
            const SizedBox(height: 6),
            Text(
              "We're pulling in your latest transactions.\nThis usually takes a few seconds.",
              textAlign: .center,
              style: typography.body.sm.copyWith(color: colors.mutedForeground, height: 1.5),
            ),
            const SizedBox(height: 16),
            FButton(variant: .outline, mainAxisSize: .min, onPress: () {}, child: const Text('Cancel')),
          ],
        ),
      ),
    );
  }
}
