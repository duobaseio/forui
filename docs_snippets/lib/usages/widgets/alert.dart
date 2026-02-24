// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

const alert = FAlert(
  // {@category "Variant"}
  variant: .primary,
  // {@endcategory}
  // {@category "Core"}
  style: .context(),
  icon: Icon(FIcons.circleAlert),
  title: Text('Alert Title'),
  subtitle: Text('Alert subtitle with more details'),
  // {@endcategory}
);

// {@category "Variant" "`Primary`"}
/// The alert's primary variant.
const FAlertVariant primary = .primary;

// {@category "Variant" "`Destructive`"}
/// The alert's destructive variant.
const FAlertVariant destructive = .destructive;
