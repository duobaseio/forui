// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final overlay = FOverlay(
  // {@category "Core"}
  controller: null,
  overlay: const [
    Positioned(
      top: 42,
      left: 0,
      child: Text('Overlay content'),
    ),
  ],
  overlayBuilder: (context, controller, childRenderBox, overlay) => overlay,
  builder: (context, controller, child) => child!,
  child: const Text('Child'),
  // {@endcategory}
);
