import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';

/// A royalties payout form.
class PayoutPreferencesCard extends StatelessWidget {
  /// Creates a [PayoutPreferencesCard].
  const PayoutPreferencesCard({super.key});

  @override
  Widget build(BuildContext context) => PreviewCard(
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        const _Header(),
        const SizedBox(height: 16),
        const FTextField(
          control: .managed(initial: TextEditingValue(text: 'Synthetic Horizons Music LLC')),
          label: Text('Account Holder Name'),
        ),
        const SizedBox(height: 16),
        const _ReceivingMethod(),
        const SizedBox(height: 16),
        const FTextField(label: Text('IBAN / Account Number'), hint: 'DE89 3704 0044 ....'),
        const SizedBox(height: 24),
        FButton(onPress: null, child: const Text('Save Payout Settings')),
      ],
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              Text(
                'Payout Preferences',
                maxLines: 1,
                overflow: .ellipsis,
                style: theme.typography.body.sm.copyWith(color: colors.mutedForeground),
              ),
              const SizedBox(height: 2),
              Text('Receiving Method', maxLines: 1, overflow: .ellipsis, style: theme.cardStyle.titleTextStyle),
            ],
          ),
        ),
        const SizedBox(width: 12),
        const PreviewCardCloseButton(),
      ],
    );
  }
}

class _ReceivingMethod extends StatefulWidget {
  const _ReceivingMethod();

  @override
  State<_ReceivingMethod> createState() => _ReceivingMethodState();
}

class _ReceivingMethodState extends State<_ReceivingMethod> {
  bool _bank = true;

  @override
  Widget build(BuildContext context) => FLabel(
    layout: .vertical,
    label: const Text('Receiving Method'),
    child: Row(
      children: [
        Expanded(
          child: _MethodTile(
            title: 'Bank Transfer',
            description: 'SWIFT / IBAN',
            selected: _bank,
            onPress: () => setState(() => _bank = true),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _MethodTile(
            title: 'PayPal',
            description: 'Instant Payout',
            selected: !_bank,
            onPress: () => setState(() => _bank = false),
          ),
        ),
      ],
    ),
  );
}

class _MethodTile extends StatelessWidget {
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onPress;

  const _MethodTile({required this.title, required this.description, required this.selected, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;

    return FTappable(
      semanticsLabel: '$title, $description',
      selected: selected,
      onPress: onPress,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: selected ? colors.muted : null,
          border: Border.all(color: colors.border),
          borderRadius: theme.style.borderRadius.lg,
        ),
        child: Padding(
          padding: const .all(12),
          child: Row(
            children: [
              FRadio(
                style: const .delta(trailingLabelStyle: .delta(childPadding: .value(EdgeInsets.zero))),
                value: selected,
                onChange: (_) => onPress(),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .stretch,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: typography.body.sm.copyWith(color: colors.foreground, fontWeight: .w500),
                    ),
                    Text(
                      description,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: typography.body.xs.copyWith(color: colors.mutedForeground),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
