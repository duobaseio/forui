// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

const label = FLabel(
  // {@category "Core"}
  style: .delta(labelPadding: .zero),
  axis: .vertical,
  expands: false,
  variants: {},
  label: Text('Label'),
  description: Text('Description'),
  error: Text('Error message'),
  child: Placeholder(),
  // {@endcategory}
);
