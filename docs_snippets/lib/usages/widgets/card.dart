// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final card = FCard(
  // {@category "Core"}
  style: const .delta(decoration: .shapeDelta(color: Color(0xFFFFFFFF))),
  mainAxisSize: .min,
  image: const Placeholder(),
  title: const Text('Title'),
  subtitle: const Text('Subtitle'),
  child: const Text('Content'),
  // {@endcategory}
);

const raw = FCard.raw(
  // {@category "Core"}
  style: .delta(decoration: .shapeDelta(color: Color(0xFFFFFFFF))),
  child: Text('Content'),
  // {@endcategory}
);
