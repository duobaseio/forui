// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

const scaffold = FScaffold(
  // {@category "Core"}
  scaffoldStyle: .delta(childPadding: .value(.zero)),
  childPad: true,
  resizeToAvoidBottomInset: true,
  header: Text('Header'),
  sidebar: Text('Sidebar'),
  footer: Text('Footer'),
  child: Text('Content'),
  // {@endcategory}
);
