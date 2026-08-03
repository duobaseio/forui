import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';

/// A notification preferences form with a select-all checkbox and individual toggles.
class NotificationsCard extends StatelessWidget {
  /// Creates a [NotificationsCard].
  const NotificationsCard({super.key});

  @override
  Widget build(BuildContext context) => PreviewCard(
    title: 'Notifications',
    subtitle: 'Choose what you want to be notified about.',
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        const _Preferences(),
        const SizedBox(height: 24),
        FButton(onPress: () {}, child: const Text('Save Preferences')),
      ],
    ),
  );
}

class _Preferences extends StatefulWidget {
  const _Preferences();

  @override
  State<_Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<_Preferences> {
  bool _transactions = true;
  bool _security = true;
  bool _goals = false;
  bool _market = false;

  bool get _all => _transactions && _security && _goals && _market;

  void _selectAll(bool value) => setState(() {
    _transactions = value;
    _security = value;
    _goals = value;
    _market = value;
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    crossAxisAlignment: .stretch,
    spacing: 16,
    children: [
      FCheckbox(label: const Text('Select all'), value: _all, onChange: _selectAll),
      FCheckbox(
        label: const Text('Transaction alerts'),
        description: const Text('Deposits, withdrawals, and transfers.'),
        value: _transactions,
        onChange: (value) => setState(() => _transactions = value),
      ),
      FCheckbox(
        label: const Text('Security alerts'),
        description: const Text('Login attempts and account changes.'),
        value: _security,
        onChange: (value) => setState(() => _security = value),
      ),
      FCheckbox(
        label: const Text('Goal milestones'),
        description: const Text('Updates at 25%, 50%, 75%, and 100%.'),
        value: _goals,
        onChange: (value) => setState(() => _goals = value),
      ),
      FCheckbox(
        label: const Text('Market updates'),
        description: const Text('Daily portfolio summary and price alerts.'),
        value: _market,
        onChange: (value) => setState(() => _market = value),
      ),
    ],
  );
}
