// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final checkbox = FCheckbox(
  // {@category "Accessibility"}
  semanticsLabel: 'Accept terms checkbox',
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(size: 20),
  enabled: true,
  value: false,
  onChange: (value) {},
  label: const Text('Accept terms'),
  description: const Text('You agree to our terms of service'),
  error: null,
  // {@endcategory}
);
