// ignore_for_file: avoid_redundant_argument_values

import 'package:forui/forui.dart';

const progress = FProgress(
  // {@category "Core"}
  style: .delta(constraints: .tightFor(height: 10.0)),
  semanticsLabel: 'Loading',
  // {@endcategory}
);

final circularProgress = FCircularProgress(
  // {@category "Core"}
  size: .md,
  style: const .delta(iconStyle: .delta()),
  icon: FIcons.iconData(FLucideIcons.flag),
  semanticsLabel: 'Loading',
  // {@endcategory}
);

const circularProgressLoader = FCircularProgress.loader(
  // {@category "Core"}
  size: .md,
  style: .delta(iconStyle: .delta()),
  semanticsLabel: 'Loading',
  // {@endcategory}
);

const circularProgressPinwheel = FCircularProgress.pinwheel(
  // {@category "Core"}
  size: .md,
  style: .delta(iconStyle: .delta()),
  semanticsLabel: 'Loading',
  // {@endcategory}
);

const determinateProgress = FDeterminateProgress(
  // {@category "Core"}
  style: .delta(constraints: .tightFor(height: 10.0)),
  semanticsLabel: 'Loading 50%',
  value: 0.5,
  // {@endcategory}
);

// {@category "Size" "Small"}
/// The circular progress's small size.
const FCircularProgressSizeVariant sm = .sm;

// {@category "Size" "Medium"}
/// The circular progress's medium (default) size.
const FCircularProgressSizeVariant md = .md;

// {@category "Size" "Large"}
/// The circular progress's large size.
const FCircularProgressSizeVariant lg = .lg;
