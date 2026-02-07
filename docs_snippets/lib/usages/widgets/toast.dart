// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

const toast = FToast(
  // {@category "Core"}
  style: .delta(titleSpacing: 5),
  icon: Icon(FIcons.info),
  title: Text('Title'),
  description: Text('Description'),
  suffix: Icon(FIcons.x),
  // {@endcategory}
);

const toaster = FToaster(
  // {@category "Core"}
  style: .delta(padding: .all(16)),
  child: Placeholder(),
  // {@endcategory}
);

final showToast = showFToast(
  // {@category "Core"}
  context: context,
  style: const .delta(padding: .all(16)),
  icon: const Icon(FIcons.info),
  title: const Text('Title'),
  description: const Text('Description'),
  suffixBuilder: (context, entry) => GestureDetector(onTap: entry.dismiss, child: const Icon(FIcons.x)),
  // {@category "Behavior"}
  alignment: .bottomEnd,
  swipeToDismiss: const [.right],
  duration: const Duration(seconds: 5),
  onDismiss: () {},
  // {@endcategory}
);

final showRawToast = showRawFToast(
  // {@category "Behavior"}
  alignment: .bottomEnd,
  swipeToDismiss: const [.right],
  duration: const Duration(seconds: 5),
  onDismiss: () {},
  // {@endcategory}
  // {@category "Core"}
  context: context,
  style: const .delta(padding: .all(16)),
  builder: (context, entry) => const Text('Custom toast content'),
  // {@endcategory}
);

BuildContext get context => throw UnimplementedError();
