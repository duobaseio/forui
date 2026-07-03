// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final carousel = FCarousel(
  // {@category "Control"}
  control: .managed(),
  // {@endcategory}
  // {@category "Core"}
  style: .context(),
  showIndicator: true,
  autoPlay: Duration(seconds: 4),
  children: [
    ColoredBox(color: Color(0xFF2563EB)),
    ColoredBox(color: Color(0xFF16A34A)),
    ColoredBox(color: Color(0xFFDC2626)),
  ],
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the carousel's slide index.
final FCarouselControl lifted = .lifted(index: 0, length: 3, onChange: (index) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the carousel state internally.
final FCarouselControl managedInternal = .managed(initial: 0, length: 3, onChange: (index) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller to control the carousel's state.
final FCarouselControl managedExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: FCarouselController(length: 3),
  onChange: (index) {},
);
