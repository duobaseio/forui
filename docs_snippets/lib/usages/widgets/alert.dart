// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

const alert = FAlert(
  // {@category "Variants"}
  variants: {},
  // {@endcategory}
  // {@category "Core"}
  style: .inherit(),
  icon: Icon(FIcons.circleAlert),
  title: Text('Alert Title'),
  subtitle: Text('Alert subtitle with more details'),
  // {@endcategory}
);

// {@category "Variants" "`Primary)`"}
/// The alert's primary variant.
const Set<FAlertVariant> primary = {};

// {@category "Variants" "`Destructive`"}
/// The alert's destructive variant.
final Set<FAlertVariant> destructive = {.destructive};
