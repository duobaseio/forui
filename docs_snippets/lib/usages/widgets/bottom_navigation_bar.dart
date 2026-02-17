// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final bottomNavigationBar = FBottomNavigationBar(
  // {@category "Safe Area"}
  safeAreaTop: false,
  safeAreaBottom: false,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(padding: .value(.zero)),
  index: 0,
  onChange: (index) {},
  children: const [FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home'))],
  // {@endcategory}
);

final bottomNavigationBarItem = FBottomNavigationBarItem(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  // {@endcategory}
  // {@category "Callbacks"}
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(padding: .value(.zero)),
  icon: const Icon(FIcons.house),
  label: const Text('Home'),
  // {@endcategory}
);
