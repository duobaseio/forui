import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';

const _accounts = [
  r'Main Checking (··8402) · $12,450.00',
  r'High Yield Savings (··1192) · $42,100.00',
  r'Brokerage (··7734) · $18,920.00',
  r'Joint Checking (··5561) · $6,340.00',
];

/// A funds transfer form.
class TransferFundsCard extends StatelessWidget {
  /// Creates a [TransferFundsCard].
  const TransferFundsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;
    final items = {for (final account in _accounts) account: account};

    return PreviewCard(
      title: 'Transfer Funds',
      subtitle: 'Move money between your connected accounts.',
      action: const PreviewCardCloseButton(),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          FTextField(
            control: const .managed(initial: TextEditingValue(text: '1,200.00')),
            label: const Text('Amount to Transfer'),
            keyboardType: .numberWithOptions(decimal: true),
            prefixBuilder: (_, _, _) => Padding(
              padding: const .directional(start: 12, end: 6),
              child: Text(r'$', style: typography.body.sm.copyWith(color: colors.mutedForeground)),
            ),
          ),
          const SizedBox(height: 16),
          FSelect<String>(
            label: const Text('From Account'),
            control: .managed(initial: _accounts[0]),
            items: items,
          ),
          const SizedBox(height: 16),
          FSelect<String>(
            label: const Text('To Account'),
            control: .managed(initial: _accounts[1]),
            items: items,
          ),
          const SizedBox(height: 16),
          const _Summary(),
          const SizedBox(height: 20),
          FButton(onPress: () {}, child: const Text('Confirm Transfer')),
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return DecoratedBox(
      decoration: BoxDecoration(color: theme.colors.muted, borderRadius: theme.style.borderRadius.lg),
      child: Padding(
        padding: const .symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: const [
            _Row(label: 'Estimated arrival', value: 'Today, Apr 14'),
            SizedBox(height: 10),
            _Row(label: 'Transaction fee', value: r'$0.00'),
            SizedBox(height: 10),
            _Row(label: 'Total amount', value: r'$1,200.00', emphasized: true),
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
          style: emphasized
              ? body.copyWith(color: colors.foreground, fontWeight: .w600)
              : body.copyWith(color: colors.mutedForeground),
        ),
      ],
    );
  }
}
