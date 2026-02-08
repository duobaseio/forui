// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

const alert = FAlert(
  // {@category "Variant"}
  variant: null,
  // {@endcategory}
  // {@category "Core"}
  style: .inherit(),
  icon: Icon(FIcons.circleAlert),
  title: Text('Alert Title'),
  subtitle: Text('Alert subtitle with more details'),
  // {@endcategory}
);

// {@category "Variant" "`Primary)`"}
/// The alert's primary variant.
const FAlertVariant? primary = null;

// {@category "Variant" "`Destructive`"}
/// The alert's destructive variant.
const FAlertVariant destructive = .destructive;
