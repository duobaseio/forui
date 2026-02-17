// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final dialog = FDialog(
  // {@category "Layout"}
  direction: .vertical,
  constraints: const BoxConstraints(minWidth: 280, maxWidth: 560),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Dialog',
  // {@endcategory}
  // {@category "Others"}
  animation: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(insetPadding: .value(.zero)),
  title: const Text('Title'),
  body: const Text('Body'),
  actions: [FButton(onPress: () {}, child: const Text('Action'))],
  // {@endcategory}
);

final adaptive = FDialog.adaptive(
  // {@category "Layout"}
  constraints: const BoxConstraints(minWidth: 280, maxWidth: 560),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Dialog',
  // {@endcategory}
  // {@category "Others"}
  animation: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(insetPadding: .value(.zero)),
  title: const Text('Title'),
  body: const Text('Body'),
  actions: [FButton(onPress: () {}, child: const Text('Action'))],
  // {@endcategory}
);

final raw = FDialog.raw(
  // {@category "Layout"}
  constraints: const BoxConstraints(minWidth: 280, maxWidth: 560),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Dialog',
  // {@endcategory}
  // {@category "Others"}
  animation: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(insetPadding: .value(.zero)),
  builder: (context, style) => const Text('Custom content'),
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
  builder: (context, style, animation) => FDialog(
    style: style,
    animation: animation,
    title: const Text('Title'),
    body: const Text('Body'),
    actions: [FButton(onPress: () => Navigator.of(context).pop(), child: const Text('Close'))],
  ),
  // {@endcategory}
);

BuildContext get context => throw UnimplementedError();
