// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final dialog = FDialog(
  // {@category "Layout"}
  constraints: const BoxConstraints(minWidth: 280, maxWidth: 560),
  resizeToAvoidInsets: true,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Dialog',
  // {@endcategory}
  // {@category "Others"}
  animation: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(insetPadding: .value(.zero)),
  clipBehavior: .none,
  builder: (context, style) => const Text('Custom content'),
  // {@endcategory}
);

final adaptive = FDialog.adaptive(
  // {@category "Layout"}
  constraints: const BoxConstraints(minWidth: 280, maxWidth: 560),
  resizeToAvoidInsets: true,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Dialog',
  // {@endcategory}
  // {@category "Others"}
  animation: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(insetPadding: .value(.zero)),
  clipBehavior: .none,
  horizontalBuilder: (context, style) => const Text('Horizontal content'),
  verticalBuilder: (context, style) => const Text('Vertical content'),
  // {@endcategory}
);

final show = showFDialog(
  // {@category "Barrier"}
  barrierLabel: 'Dismiss',
  barrierDismissible: true,
  // {@endcategory}
  // {@category "Navigation"}
  useRootNavigator: false,
  useSafeArea: false,
  routeSettings: null,
  anchorPoint: null,
  transitionAnimationController: null,
  // {@endcategory}
  // {@category "Core"}
  context: context,
  style: const .delta(insetPadding: .value(.zero)),
  routeStyle: const .delta(motion: .delta()),
  builder: (context, style, animation) => FDialog.adaptive(
    style: style,
    animation: animation,
    horizontalBuilder: (context, style) => const Text('Horizontal content'),
    verticalBuilder: (context, style) => const Text('Vertical content'),
  ),
  // {@endcategory}
);

BuildContext get context => throw UnimplementedError();
