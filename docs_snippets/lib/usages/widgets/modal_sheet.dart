// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final show = showFSheet(
  // {@category "Layout"}
  mainAxisMaxRatio: 9 / 16,
  constraints: const BoxConstraints(),
  useSafeArea: false,
  resizeToAvoidBottomInset: true,
  // {@endcategory}
  // {@category "Behavior"}
  draggable: true,
  onClosing: () {},
  // {@endcategory}
  // {@category "Barrier"}
  barrierLabel: 'Dismiss',
  barrierDismissible: true,
  // {@endcategory}
  // {@category "Navigation"}
  useRootNavigator: false,
  routeSettings: null,
  anchorPoint: null,
  transitionAnimationController: null,
  // {@endcategory}
  // {@category "Core"}
  context: context,
  style: const .delta(flingVelocity: 700),
  side: .btt,
  builder: (context) => const Padding(padding: .all(16), child: Text('Sheet content')),
  // {@endcategory}
);

final route = FModalSheetRoute<void>(
  // {@category "Layout"}
  mainAxisMaxRatio: 9 / 16,
  constraints: const BoxConstraints(),
  useSafeArea: false,
  resizeToAvoidBottomInset: true,
  // {@endcategory}
  // {@category "Behavior"}
  draggable: true,
  onClosing: () {},
  // {@endcategory}
  // {@category "Barrier"}
  barrierLabel: 'Dismiss',
  barrierDismissible: true,
  barrierOnTapHint: null,
  // {@endcategory}
  // {@category "Navigation"}
  capturedThemes: null,
  settings: null,
  anchorPoint: null,
  transitionAnimationController: null,
  // {@endcategory}
  // {@category "Core"}
  style: const FModalSheetStyle(),
  side: .btt,
  builder: (context) => const Padding(padding: .all(16), child: Text('Sheet content')),
  // {@endcategory}
);

BuildContext get context => throw UnimplementedError();
