// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final switchWidget = FSwitch(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Enable notifications switch',
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(labelPadding: .value(.only(left: 8))),
  enabled: true,
  value: false,
  onChange: (value) {},
  dragStartBehavior: .start,
  label: const Text('Enable notifications'),
  description: const Text('Receive push notifications'),
  error: null,
  // {@endcategory}
);
