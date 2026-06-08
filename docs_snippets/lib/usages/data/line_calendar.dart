// ignore_for_file: avoid_redundant_argument_values

import 'package:forui/forui.dart';

final lineCalendar = FLineCalendar(
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Scroll"}
  scrollControl: const .managed(),
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(itemSpacing: 10),
  scrollCacheExtent: null,
  keyboardDismissBehavior: .manual,
  physics: null,
  selectable: (date) => true,
  builder: (context, data, child) => child!,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the line calendar's date.
final FLineCalendarControl lifted = .lifted(date: .now(), onChange: (date) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the line calendar state internally.
final FLineCalendarControl managedInternal = .managed(initial: .now(), toggleable: false, onChange: (date) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller to control the line calendar's state.
final FLineCalendarControl managedExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: .single(initial: .now()),
  onChange: (date) {},
);

// {@category "Scroll" "`.managed()` with internal controller"}
/// Manages the line calendar scroll internally.
final FLineCalendarScrollControl scrollManagedInternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  start: .utc(1900),
  end: .utc(2100),
  today: .now(),
  initialDate: .now(),
  initialAlignment: .center,
  onChange: (offset) {},
);

// {@category "Scroll" "`.managed()` with external controller"}
/// Uses an external [FLineCalendarScrollController] to drive programmatic scrolling.
final FLineCalendarScrollControl scrollManagedExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: FLineCalendarScrollController(
    start: .utc(1900),
    end: .utc(2100),
    today: .now(),
    initialDate: .now(),
    initialAlignment: .center,
  ),
  onChange: (offset) {},
);
