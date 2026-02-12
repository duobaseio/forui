import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class TextFormFieldPage extends StatefulExample {
  TextFormFieldPage({@queryParam super.theme}) : super(top: 20);

  @override
  State<TextFormFieldPage> createState() => _TextFormFieldPageState();
}

class _TextFormFieldPageState extends StatefulExampleState<TextFormFieldPage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget example(BuildContext _) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      children: [
        FTextFormField.email(
          hint: 'janedoe@foruslabs.com',
          autovalidateMode: .onUserInteraction,
          validator: (value) => (value?.contains('@') ?? false) ? null : 'Please enter a valid email.',
        ),
        const SizedBox(height: 10),
        FTextFormField.password(
          autovalidateMode: .onUserInteraction,
          validator: (value) => 8 <= (value?.length ?? 0) ? null : 'Password must be at least 8 characters long.',
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: .end,
          children: [
            FButton(
              size: .sm,
              mainAxisSize: .min,
              child: const Text('Login'),
              onPress: () {
                if (_key.currentState!.validate()) {
                  // Form is valid, do something.
                }
              },
            ),
          ],
        ),
      ],
    ),
  );
}
