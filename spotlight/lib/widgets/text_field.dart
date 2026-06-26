import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class TextField extends StatelessWidget {
  const TextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: .min,
          spacing: 24,
          children: [
            const FTextField(
              label: Text('Username'),
              hint: 'JaneDoe',
              description: Text('Please enter your username.'),
            ),
            FTextField(
              label: const Text('Search'),
              prefixBuilder: (context, style, variants) =>
                  FTextField.prefixIconBuilder(context, style, variants, const Icon(FLucideIcons.search)),
              control: const .managed(initial: TextEditingValue(text: 'forui')),
              clearable: (value) => value.text.isNotEmpty,
            ),
            FTextField.password(
              control: const .managed(initial: TextEditingValue(text: 'My password')),
            ),
          ],
        ),
      ),
    );
  }
}
