// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final radio = FRadio(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Option radio',
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(motion: .delta()),
  enabled: true,
  value: false,
  onChange: (value) {},
  label: const Text('Option'),
  description: const Text('Description'),
  error: null,
  // {@endcategory}
);
