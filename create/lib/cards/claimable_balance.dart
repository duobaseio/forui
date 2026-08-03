import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';

/// The status dot's amber.
const _amber = Color(0xFFEAB308);

/// A royalties balance.
class ClaimableBalanceCard extends StatelessWidget {
  /// Creates a [ClaimableBalanceCard].
  const ClaimableBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;

    return PreviewCard(
      footer: Text(
        r'Once your bank is connected, balances over $10.00 are automatically eligible for monthly distribution on the '
        '15th of each month.',
        style: typography.body.xs.copyWith(color: colors.mutedForeground, height: 1.5),
      ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          Text('Claimable Balance', style: typography.body.lg.copyWith(color: colors.mutedForeground)),
          const SizedBox(height: 4),
          Text(
            r'$0.00',
            style: typography.display.xl4.copyWith(color: colors.foreground, fontWeight: .w600, height: 1.1),
          ),
          const SizedBox(height: 12),
          const Align(alignment: .centerStart, child: _Status()),
          const SizedBox(height: 16),
          const _Summary(),
        ],
      ),
    );
  }
}

class _Status extends StatelessWidget {
  const _Status();

  @override
  Widget build(BuildContext context) => FBadge(
    variant: .outline,
    child: const Row(
      mainAxisSize: .min,
      children: [
        SizedBox.square(
          dimension: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(color: _amber, shape: .circle),
          ),
        ),
        SizedBox(width: 6),
        Text('Pending Setup', softWrap: false, overflow: .visible),
      ],
    ),
  );
}

class _Summary extends StatelessWidget {
  const _Summary();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.muted.withValues(alpha: 0.5),
        borderRadius: theme.style.borderRadius.lg,
      ),
      child: Padding(
        padding: const .all(16),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            const _Row(label: 'Net Royalties', value: r'$0.00'),
            const SizedBox(height: 12),
            const _Row(label: 'Processing Fee', value: r'-$0.00'),
            FDivider(
              style: .delta(color: theme.colors.border, padding: .value(const .symmetric(vertical: 12))),
            ),
            const _Row(label: 'Total Ready to Claim', value: r'$0.00 USD', emphasized: true),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasized;

  const _Row({required this.label, required this.value, this.emphasized = false});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final body = theme.typography.body.sm;

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            overflow: .ellipsis,
            style: emphasized
                ? body.copyWith(color: colors.foreground, fontWeight: .w600)
                : body.copyWith(color: colors.mutedForeground),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: body.copyWith(color: colors.foreground, fontWeight: emphasized ? .w600 : .w500),
        ),
      ],
    );
  }
}
