// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

const pagination = FPagination(
  // {@category "Control"}
  control: .managed(),
  // {@endcategory}
  // {@category "Core"}
  style: .delta(itemPadding: .value(.symmetric(horizontal: 2))),
  previous: Icon(FIcons.chevronLeft),
  next: Icon(FIcons.chevronRight),
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the pagination's page.
final FPaginationControl lifted = .lifted(page: 0, pages: 10, siblings: 1, showEdges: true, onChange: (page) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the pagination state internally.
final FPaginationControl managedInternal = .managed(
  initial: 0,
  pages: 10,
  siblings: 1,
  showEdges: true,
  onChange: (page) {},
);

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller to control the pagination's state.
final FPaginationControl managedExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: FPaginationController(page: 0, pages: 10, siblings: 1, showEdges: true),
  onChange: (page) {},
);
