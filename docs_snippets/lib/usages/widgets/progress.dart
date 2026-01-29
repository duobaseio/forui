// ignore_for_file: avoid_redundant_argument_values

import 'package:forui/forui.dart';

const progress = FProgress(
  // {@category "Core"}
  style: .delta(constraints: .tightFor(height: 10.0)),
  semanticsLabel: 'Loading',
  // {@endcategory}
);

const circularProgress = FCircularProgress(
  // {@category "Core"}
  style: .delta(iconStyle: .delta()),
  icon: FIcons.loaderCircle,
  semanticsLabel: 'Loading',
  // {@endcategory}
);

const circularProgressLoader = FCircularProgress.loader(
  // {@category "Core"}
  style: .delta(iconStyle: .delta()),
  semanticsLabel: 'Loading',
  // {@endcategory}
);

const circularProgressPinwheel = FCircularProgress.pinwheel(
  // {@category "Core"}
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
