import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';

const _orderTypes = ['Market Order', 'Limit Order', 'Stop Order'];

/// A brokerage order form.
class BuyInvestmentCard extends StatelessWidget {
  /// Creates a [BuyInvestmentCard].
  const BuyInvestmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;

    return PreviewCard(
      title: 'Buy Investment',
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          FTextField(
            control: const .managed(initial: TextEditingValue(text: '1,000.00')),
            label: const Text('Amount to Invest'),
            keyboardType: .numberWithOptions(decimal: true),
            prefixBuilder: (_, _, _) => Padding(
              padding: const .directional(start: 12, end: 6),
              child: Text(r'$', style: typography.body.sm.copyWith(color: colors.mutedForeground)),
            ),
          ),
          const SizedBox(height: 16),
          FSelect<String>(
            label: const Text('Order Type'),
            description: const Text('Market orders execute at the current price.'),
            control: .managed(initial: _orderTypes[0]),
            items: {for (final type in _orderTypes) type: type},
          ),
          const SizedBox(height: 20),
          const _Row(label: 'Estimated Shares', value: '1.95'),
          const SizedBox(height: 8),
          const _Row(label: 'Buying Power', value: r'$12,450.00'),
          const SizedBox(height: 24),
          const _Submit(),
        ],
      ),
    );
  }
}

class _Submit extends StatelessWidget {
  const _Submit();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        FButton(onPress: () {}, child: const Text('Review Order')),
        const SizedBox(height: 10),
        Text(
          'Typically filled within minutes during market hours.',
          textAlign: .center,
          style: theme.typography.body.xs.copyWith(color: theme.colors.mutedForeground, height: 1.5),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;

  const _Row({required this.label, required this.value});

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
            style: body.copyWith(color: colors.mutedForeground),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: body.copyWith(color: colors.foreground, fontWeight: .w600),
        ),
      ],
    );
  }
}
