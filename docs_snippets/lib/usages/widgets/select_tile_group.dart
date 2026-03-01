// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final selectTileGroup = FSelectTileGroup<String>(
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Select fruits'),
  description: const Text('Choose your favorite fruits'),
  onSaved: (values) {},
  onReset: () {},
  autovalidateMode: .disabled,
  forceErrorText: null,
  validator: (values) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  physics: const ClampingScrollPhysics(),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Fruit selection',
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(dividerWidth: 1),
  enabled: true,
  divider: .indented,
  children: const [
    .tile(title: Text('Apple'), value: 'apple'),
    .tile(title: Text('Banana'), value: 'banana'),
    .tile(title: Text('Cherry'), value: 'cherry'),
  ],
  // {@endcategory}
);

final selectTileGroupBuilder = FSelectTileGroup<String>.builder(
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Select items'),
  description: const Text('Choose your items'),
  onSaved: (values) {},
  onReset: () {},
  autovalidateMode: .disabled,
  forceErrorText: null,
  validator: (values) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  physics: const ClampingScrollPhysics(),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Item selection',
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(dividerWidth: 1),
  enabled: true,
  divider: .indented,
  tileBuilder: (context, index) => FSelectTile(title: Text('Item $index'), value: 'item_$index'),
  count: 10,
  // {@endcategory}
);

final selectTile = FSelectTile<String>(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Apple',
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(margin: FVariants.all(.zero)),
  enabled: true,
  value: 'apple',
  title: const Text('Apple'),
  subtitle: const Text('A red fruit'),
  details: const Text(r'$1.99'),
  checkedIcon: const Icon(FIcons.check),
  uncheckedIcon: null,
  suffix: null,
  // {@endcategory}
);

final selectTileSuffix = FSelectTile<String>.suffix(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  shortcuts: null,
  actions: null,
  semanticsLabel: 'Apple',
  // {@endcategory}
  // {@category "Callbacks"}
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(margin: FVariants.all(.zero)),
  enabled: true,
  value: 'apple',
  title: const Text('Apple'),
  subtitle: const Text('A red fruit'),
  details: const Text(r'$1.99'),
  checkedIcon: const Icon(FIcons.check),
  uncheckedIcon: null,
  prefix: null,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the select tile group's values.
final FMultiValueControl<String> lifted = .lifted(value: {}, onChange: (values) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the select tile group state internally for multiple selections.
final FMultiValueControl<String> managedInternal = .managed(initial: {}, min: 0, max: null, onChange: (values) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller for multiple selections.
final FMultiValueControl<String> managedExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: FMultiValueNotifier<String>(value: {}, min: 0, max: 5),
  onChange: (values) {},
);

// {@category "Control" "`.managedRadio()` with internal controller"}
/// Single selection with internal controller (radio behavior).
final FMultiValueControl<String> managedRadioInternal = .managedRadio(initial: null, onChange: (values) {});

// {@category "Control" "`.managedRadio()` with external controller"}
/// Single selection with external controller (radio behavior).
final FMultiValueControl<String> managedRadioExternal = .managedRadio(
  // Don't create a controller inline. Store it in a State instead.
  controller: .radio(),
  onChange: (values) {},
);
