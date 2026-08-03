import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';

/// A summary of the savings goals.
class SavingsTargetsCard extends StatelessWidget {
  /// Creates a [SavingsTargetsCard].
  const SavingsTargetsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;

    return PreviewCard(
      title: 'Savings Targets',
      subtitle: 'Active milestones for 2024',
      action: FButton(variant: .outline, size: .sm, mainAxisSize: .min, onPress: () {}, child: const Text('New Goal')),
      actionAlignment: .center,
      tintedFooter: true,
      footer: Text(
        'You have not met your targets for this year.',
        style: typography.body.sm.copyWith(color: colors.mutedForeground),
      ),
      child: const Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          _Goal(label: 'RETIREMENT', target: r'$420,000', saved: r'$273,000', value: 0.65),
          SizedBox(height: 16),
          _Goal(label: 'REAL ESTATE', target: r'$85,000', saved: r'$27,200', value: 0.32),
        ],
      ),
    );
  }
}

class _Goal extends StatelessWidget {
  final String label;
  final String target;
  final String saved;
  final double value;

  const _Goal({required this.label, required this.target, required this.saved, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.muted.withValues(alpha: 0.5), borderRadius: theme.style.borderRadius.lg),
      child: Padding(
        padding: const .all(16),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            Text(label, style: typography.body.xs.copyWith(color: colors.mutedForeground, letterSpacing: 0.6)),
            const SizedBox(height: 4),
            Text(target, style: typography.display.lg.copyWith(fontWeight: .w700)),
            const SizedBox(height: 6),
            FDeterminateProgress(value: value),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${(value * 100).round()}% achieved',
                    overflow: .ellipsis,
                    style: typography.body.sm.copyWith(color: colors.mutedForeground),
                  ),
                ),
                const SizedBox(width: 8),
                Text(saved, style: typography.body.sm.copyWith(fontWeight: .w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
