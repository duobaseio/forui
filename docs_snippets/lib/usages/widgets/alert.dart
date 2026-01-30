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

// {@category "Variant" "`Primary)`"}
/// The alert's primary style.
const Set<FAlertVariant> primary = {};

// {@category "Style" "`Destructive`"}
/// The alert's destructive style.
final Set<FAlertVariant> destructive = {.destructive};
    