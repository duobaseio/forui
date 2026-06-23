import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Checkbox extends StatefulWidget {
  const Checkbox({super.key});

  @override
  State<Checkbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
  bool _value = false;
  bool _wasChecked = false;

  @override
  Widget build(BuildContext context) {
    final showError = !_value && _wasChecked;

    return Center(
      child: SizedBox(
        width: 316,
        child: Column(
          mainAxisAlignment: .center,
        children: [
          FCheckbox(
            label: const Text('Accept terms and conditions'),
            description: const Text('You agree to our terms and conditions.'),
            semanticsLabel: 'Accept terms and conditions',
            error: showError ? const Text('You must accept the terms and conditions.') : null,
            value: _value,
            onChange: (value) => setState(() {
              _value = value;
              if (value) _wasChecked = true;
            }),
          ),
          const SizedBox(height: 32),
          FCheckbox(
            label: const Text('Disabled'),
            description: const Text('This checkbox is disabled.'),
            enabled: false,
            value: false,
            onChange: (_) {},
          ),
        ],
        ),
      ),
    );
  }
}
