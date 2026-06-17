// ignore_for_file: avoid_redundant_argument_values

import 'package:forui/forui.dart';

final grid = FCalendar.grid(
  // {@category "Control"}
  control: FGridCalendarControl(
    selectable: (date) => true,
    start: .utc(1900),
    today: .now(),
    initial: .now(),
    end: .utc(2100),
  ),
  // {@endcategory}
  // {@category "Selection"}
  selectionControl: .managedSingle(),
  // {@endcategory}
  // {@category "Appearance"}
  headerBuilder: FCalendar.defaultHeaderBuilder,
  footerBuilder: FCalendar.defaultFooterBuilder,
  dayBuilder: FCalendar.defaultDayBuilder,
  monthBuilder: FCalendar.defaultMonthBuilder,
  yearBuilder: FCalendar.defaultYearBuilder,
  // {@endcategory}
  // {@category "Scroll"}
  dayScrollPhysics: null,
  dayScrollCacheExtent: null,
  dayScrollBehavior: null,
  monthScrollPhysics: null,
  monthScrollCacheExtent: null,
  monthScrollBehavior: null,
  yearScrollPhysics: null,
  yearScrollCacheExtent: null,
  yearScrollBehavior: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onDayPress: (date) {},
  onDayLongPress: (date) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(padding: .value(.zero)),
  fixedWeeks: false,
  // {@endcategory}
);

final splitGrid = FCalendar.splitGrid(
  // {@category "Control"}
  control: FGridSplitCalendarControl(
    selectable: (date) => true,
    start: .utc(1900),
    today: .now(),
    initial: .now(),
    end: .utc(2100),
  ),
  // {@endcategory}
  // {@category "Selection"}
  selectionControl: .managedSingle(),
  // {@endcategory}
  // {@category "Appearance"}
  headerBuilder: FCalendar.defaultHeaderBuilder,
  footerBuilder: FCalendar.defaultFooterBuilder,
  dayBuilder: FCalendar.defaultDayBuilder,
  monthBuilder: FCalendar.defaultMonthBuilder,
  yearBuilder: FCalendar.defaultYearBuilder,
  // {@endcategory}
  // {@category "Scroll"}
  dayScrollPhysics: null,
  dayScrollCacheExtent: null,
  dayScrollBehavior: null,
  yearScrollPhysics: null,
  yearScrollCacheExtent: null,
  yearScrollBehavior: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onDayPress: (date) {},
  onDayLongPress: (date) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(padding: .value(.zero)),
  fixedWeeks: false,
  // {@endcategory}
);

final wheel = FCalendar.wheel(
  // {@category "Control"}
  control: FWheelCalendarControl(
    selectable: (date) => true,
    start: .utc(1900),
    today: .now(),
    initial: .now(),
    end: .utc(2100),
  ),
  // {@endcategory}
  // {@category "Selection"}
  selectionControl: .managedSingle(),
  // {@endcategory}
  // {@category "Appearance"}
  headerBuilder: FCalendar.defaultHeaderBuilder,
  footerBuilder: FCalendar.defaultFooterBuilder,
  dayBuilder: FCalendar.defaultDayBuilder,
  // {@endcategory}
  // {@category "Scroll"}
  dayScrollPhysics: null,
  dayScrollCacheExtent: null,
  dayScrollBehavior: null,
  // {@endcategory}
  // {@category "Wheel"}
  loop: false,
  monthFlex: 1,
  yearFlex: 1,
  // {@endcategory}
  // {@category "Callbacks"}
  onDayPress: (date) {},
  onDayLongPress: (date) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(padding: .value(.zero)),
  fixedWeeks: false,
  // {@endcategory}
);

// {@category "Selection" "`.lifted()`"}
/// Lifts selection state to the parent for external state management.
final FDateSelectionControl<Object?> selectionLifted = .lifted(selected: (date) => false, select: (date) {});

// {@category "Selection" "`.managedSingle()` with internal controller"}
/// Single date selection managed internally.
final FDateSelectionControl<DateTime?> selectionSingleInternal = .managedSingle(
  initial: null,
  toggleable: true,
  onChange: (date) {},
);

// {@category "Selection" "`.managedSingle()` with external controller"}
/// Single date selection with an external controller.
final FDateSelectionControl<DateTime?> selectionSingleExternal = .managedSingle(
  // Don't create a controller inline. Store it in a State instead.
  controller: FDateSelectionController.single(initial: null, toggleable: true),
  onChange: (date) {},
);

// {@category "Selection" "`.managedMulti()` with internal controller"}
/// Multiple dates selection managed internally.
final FDateSelectionControl<Set<DateTime>> selectionMultiInternal = .managedMulti(initial: {}, onChange: (dates) {});

// {@category "Selection" "`.managedMulti()` with external controller"}
/// Multiple dates selection with an external controller.
final FDateSelectionControl<Set<DateTime>> selectionMultiExternal = .managedMulti(
  // Don't create a controller inline. Store it in a State instead.
  controller: FDateSelectionController.multi(initial: {}),
  onChange: (dates) {},
);

// {@category "Selection" "`.managedRange()` with internal controller"}
/// Range selection managed internally.
final FDateSelectionControl<(DateTime, DateTime)?> selectionRangeInternal = .managedRange(
  initial: null,
  onChange: (range) {},
);

// {@category "Selection" "`.managedRange()` with external controller"}
/// Range selection with an external controller.
final FDateSelectionControl<(DateTime, DateTime)?> selectionRangeExternal = .managedRange(
  // Don't create a controller inline. Store it in a State instead.
  controller: FDateSelectionController.range(initial: (.utc(2026, 7, 17), .utc(2026, 7, 20))),
  onChange: (range) {},
);

// {@category "Selection" "`.none()`"}
/// Displays a read-only calendar that selects nothing.
final FDateSelectionControl<Object?> selectionNone = .none();
