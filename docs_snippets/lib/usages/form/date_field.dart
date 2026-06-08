// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final dateField = FDateField(
  // {@category "Selection"}
  selectionControl: .managedSingle(),
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Label'),
  description: const Text('Description'),
  onSaved: (date) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  validator: (date) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  formFieldKey: null,
  // {@endcategory}
  // {@category "Field"}
  textInputAction: null,
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  expands: false,
  onEditingComplete: () {},
  onSubmit: (date) {},
  mouseCursor: null,
  canRequestFocus: true,
  clearable: false,
  baselineInputYear: 2025,
  builder: (context, style, states, child) => child,
  prefixBuilder: FDateField.defaultIconBuilder,
  suffixBuilder: null,
  // {@endcategory}
  // {@category "Calendar"}
  calendar: const FDateFieldGridCalendarProperties(),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
  // {@category "Core"}
  size: .md,
  style: .delta(fieldStyles: .delta([])),
  enabled: true,
  // {@endcategory}
);

final calendar = FDateField.calendar(
  // {@category "Selection"}
  selectionControl: .managedSingle(),
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Label'),
  description: const Text('Description'),
  onSaved: (date) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  validator: (date) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  formFieldKey: null,
  // {@endcategory}
  // {@category "Field"}
  format: FDateField.defaultFormat,
  hint: null,
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  expands: false,
  mouseCursor: .defer,
  canRequestFocus: true,
  clearable: false,
  builder: (context, style, states, child) => child,
  prefixBuilder: FDateField.defaultIconBuilder,
  suffixBuilder: null,
  // {@endcategory}
  // {@category "Calendar"}
  calendar: const FDateFieldGridCalendarProperties(),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
  // {@category "Core"}
  size: .md,
  style: .delta(fieldStyles: .delta([])),
  enabled: true,
  // {@endcategory}
);

final input = FDateField.input(
  // {@category "Selection"}
  selectionControl: .managedSingle(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Label'),
  description: const Text('Description'),
  validator: (date) => null,
  onSaved: (date) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  formFieldKey: null,
  // {@endcategory}
  // {@category "Field"}
  textInputAction: null,
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  expands: false,
  onEditingComplete: () {},
  onSubmit: (date) {},
  mouseCursor: null,
  canRequestFocus: true,
  clearable: false,
  baselineInputYear: 2025,
  builder: (context, style, states, child) => child,
  prefixBuilder: FDateField.defaultIconBuilder,
  suffixBuilder: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
  // {@category "Core"}
  size: .md,
  style: .delta(fieldStyles: .delta([])),
  enabled: true,
  // {@endcategory}
);

// {@category "Selection" "`.lifted()`"}
/// Externally controls the selected date.
final FDateSelectionControl<Object?> selectionLifted = .lifted(selected: (date) => false, select: (date) {});

// {@category "Selection" "`.managedSingle()` with internal controller"}
/// Manages the selected date internally.
final FDateSelectionControl<DateTime?> selectionManaged = .managedSingle(initial: .utc(2026), onChange: (date) {});

// {@category "Selection" "`.managedSingle()` with external controller"}
/// Uses an external `FDateSelectionController` to control the selected date.
final FDateSelectionControl<DateTime?> selectionExternal = .managedSingle(
  // Don't create a controller inline. Store it in a State instead.
  controller: FDateSelectionController.single(),
  onChange: (date) {},
);

// {@category "Popover Control" "`.lifted()`"}
/// Externally controls the popover's visibility.
final FPopoverControl popoverLifted = .lifted(shown: false, onChange: (shown) {});

// {@category "Popover Control" "`.managed()` with internal controller"}
/// Manages the popover's visibility internally.
final FPopoverControl popoverInternal = .managed(initial: true, onChange: (shown) {});

// {@category "Popover Control" "`.managed()` with external controller"}
/// Uses an external `FPopoverController` to control the popover's visibility.
final FPopoverControl popoverExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: FPopoverController(vsync: vsync, shown: true),
  onChange: (shown) {},
);

// {@category "Calendar" "Grid"}
/// A calendar that cycles through the day, month and year grid pickers.
const FDateFieldCalendarProperties grid = FDateFieldGridCalendarProperties();

// {@category "Calendar" "Split grid"}
/// A calendar with a split header whose month and year grid pickers are independently togglable.
const FDateFieldCalendarProperties splitGrid = FDateFieldGridSplitCalendarProperties();

// {@category "Calendar" "Wheel"}
/// A calendar that toggles between a day grid picker and a month-year wheel picker.
const FDateFieldCalendarProperties wheel = FDateFieldWheelCalendarProperties();

// {@category "Calendar" "External controller"}
/// Uses an external `FGridCalendarController` for programmatic navigation.
final FDateFieldCalendarProperties externalCalendar = FDateFieldGridCalendarProperties(
  // Don't create a controller inline. Store it in a State instead.
  control: FGridCalendarControl(controller: FGridCalendarController()),
);

// {@category "Size" "Small"}
/// The date field's small size.
const FTextFieldSizeVariant sm = .sm;

// {@category "Size" "Medium"}
/// The date field's medium (default) size.
const FTextFieldSizeVariant md = .md;

// {@category "Size" "Large"}
/// The date field's large size.
const FTextFieldSizeVariant lg = .lg;

TickerProvider get vsync => throw UnimplementedError();
