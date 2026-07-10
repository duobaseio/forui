// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final card = FCard(
  // {@category "Core"}
  style: const .delta(decoration: .shapeDelta(color: Color(0xFFFFFFFF))),
  clipBehavior: .none,
  builder: (context, style, child) => child!,
  child: const Text('Content'),
  // {@endcategory}
);
