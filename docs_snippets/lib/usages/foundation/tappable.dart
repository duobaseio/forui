// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final tappable = FTappable(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Tappable button',
  excludeSemantics: false,
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Primary gestures"}
  onPressDown: (details) {},
  onPressCancel: () {},
  onPressMove: (details) {},
  onPressUp: (details) {},
  onPress: () {},
  onLongPressDown: (details) {},
  onLongPressCancel: () {},
  onLongPressStart: (details) {},
  onLongPressMove: (details) {},
  onLongPressEnd: (details) {},
  onLongPress: () {},
  onDoubleTapDown: (details) {},
  onDoubleTapCancel: () {},
  onDoubleTap: () {},
  // {@endcategory}
  // {@category "Secondary gestures"}
  onSecondaryPressDown: (details) {},
  onSecondaryPressCancel: () {},
  onSecondaryPressUp: (details) {},
  onSecondaryPress: () {},
  onSecondaryLongPressDown: (details) {},
  onSecondaryLongPressCancel: () {},
  onSecondaryLongPressStart: (details) {},
  onSecondaryLongPressMove: (details) {},
  onSecondaryLongPressEnd: (details) {},
  onSecondaryLongPress: () {},
  // {@endcategory}
  // {@category "State callbacks"}
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(motion: FTappableMotion.none),
  focusedOutlineStyle: const .delta(color: Colors.black),
  selected: false,
  behavior: .translucent,
  builder: (context, states, child) => child!,
  child: const Text('Tap me'),
  // {@endcategory}
);

final tappableStatic = FTappable.static(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Tappable button',
  excludeSemantics: false,
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Primary gestures"}
  onPressDown: (details) {},
  onPressCancel: () {},
  onPressMove: (details) {},
  onPressUp: (details) {},
  onPress: () {},
  onLongPressDown: (details) {},
  onLongPressCancel: () {},
  onLongPressStart: (details) {},
  onLongPressMove: (details) {},
  onLongPressEnd: (details) {},
  onLongPress: () {},
  onDoubleTapDown: (details) {},
  onDoubleTapCancel: () {},
  onDoubleTap: () {},
  // {@endcategory}
  // {@category "Secondary gestures"}
  onSecondaryPressDown: (details) {},
  onSecondaryPressCancel: () {},
  onSecondaryPressUp: (details) {},
  onSecondaryPress: () {},
  onSecondaryLongPressDown: (details) {},
  onSecondaryLongPressCancel: () {},
  onSecondaryLongPressStart: (details) {},
  onSecondaryLongPressMove: (details) {},
  onSecondaryLongPressEnd: (details) {},
  onSecondaryLongPress: () {},
  // {@endcategory}
  // {@category "State callbacks"}
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(motion: FTappableMotion.none),
  focusedOutlineStyle: const .delta(color: Color(0xFF000000)),
  selected: false,
  behavior: .translucent,
  builder: (context, states, child) => child!,
  child: const Text('Tap me'),
  // {@endcategory}
);
