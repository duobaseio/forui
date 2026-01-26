// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final tappable = FTappable(
  // {@category "Core"}
  style: (style) => style,
  focusedOutlineStyle: const .merge(
    color: Colors.black,
  ),
  selected: false,
  behavior: .translucent,
  builder: (context, states, child) => child!,
  child: const Text('Tap me'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Tappable button',
  excludeSemantics: false,
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onPress: () {},
  onLongPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  onHoverChange: (hovered) {},
  onVariantChange: (delta) {},
  // {@endcategory}
);

final tappableStatic = FTappable.static(
  // {@category "Core"}
  style: (style) => style,
  focusedOutlineStyle: const .merge(color: Color(0xFF000000)),
  selected: false,
  behavior: .translucent,
  builder: (context, states, child) => child!,
  child: const Text('Tap me'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Tappable button',
  excludeSemantics: false,
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onPress: () {},
  onLongPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  onHoverChange: (hovered) {},
  onVariantChange: (delta) {},
  // {@endcategory}
);
