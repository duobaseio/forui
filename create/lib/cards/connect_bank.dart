import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';
import 'components/preview_icons.dart';

/// An empty state prompting the artist to link a payout method for royalties.
class ConnectBankCard extends StatelessWidget {
  /// Creates a [ConnectBankCard].
  const ConnectBankCard({super.key});

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
                child: Center(child: PreviewIcons.of(context).icon(.creditCard, size: 22, color: colors.foreground)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Connect Bank',
              textAlign: .center,
              style: typography.body.lg.copyWith(color: colors.foreground, fontWeight: .w600),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const .symmetric(horizontal: 16),
              child: Text(
                'Link your payout method to receive monthly royalty distributions automatically.',
                textAlign: .center,
                style: typography.body.sm.copyWith(color: colors.mutedForeground, height: 1.5),
              ),
            ),
            const SizedBox(height: 16),
            FButton(mainAxisSize: .min, onPress: () {}, child: const Text('Set Up Payouts')),
          ],
        ),
      ),
    );
  }
}
