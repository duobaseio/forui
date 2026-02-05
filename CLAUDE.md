## Style Guide

Prefix publicly exported widgets and styles with `F`.

Prefer [dot-shorthands](https://dart.dev/language/dot-shorthands) where possible except for unnamed constructors.

Prefer `AlignmentGeometry`/`BorderRadiusGeometry`/`EdgeInsetsGeometry` over `Alignment`/`BorderRadius`/`EdgeInsets`.

Minimize dependency on Cupertino/Material.

## Changelog organization

Each release section is a level 2 heading. Make sure you're always adding entries in the latest release.

Entries should be grouped by widgets in alphabetical order. Each widget section should be a level 3 heading with the
widget name in backticks. 

Within each widget section, order entries as follows:
1. Additions (start with "Add")
2. Changes (start with "Change", "Rename", or similar)
3. Removals (start with "Remove")
4. Fixes (start with "Fix")

Separate each category with a blank line. Breaking changes must start with `**Breaking**`.

Example:
```markdown
### `FSelect`
* Add `FSelect.search(...)`.

* **Breaking** Rename `FSelectStyle.selectFieldStyle` to `FSelectStyle.fieldStyle`.

* **Breaking** Remove `FSelectStyle.iconStyle`. Use `FSelectStyle.fieldStyle.iconStyle` instead.

* Fix `FSelect` still allowing tags to be removed when disabled.
```

Use `### Others` for changes that don't belong to a specific widget.

## Data Driven Fixes Organization

Where possible, provide [data driven fixes](https://raw.githubusercontent.com/flutter/flutter/refs/heads/master/docs/contributing/Data-driven-Fixes.md).

Fixes are located in the `<package>/lib/fix_data` folder. Each public widget should have one file containing fixes for
its related classes (e.g., FButton, FButtonStyle, FButtonController). Fixes inside each file should be grouped by class
in alphabetical order.

```yaml
 # Example: button.yaml - All FButton-related fixes in one file                                                                                                                                                                                
   
  version: 1                                                                                                                                                                                                                                    
  transforms:               
    # FButton
    - title: 'Rename FButton(onStateChange: ...) to FButton(onVariantChange: ...)'
      date: 2026-01-26
      element:
        uris: [ 'package:forui/forui.dart' ]
        constructor: ''
        inClass: FButton
      changes:
        - kind: renameParameter
          oldName: 'onStateChange'
          newName: 'onVariantChange'

    - title: 'Rename FButton.icon(onStateChange: ...) to FButton.icon(onVariantChange: ...)'
      date: 2026-01-26
      element:
        uris: [ 'package:forui/forui.dart' ]
        constructor: 'icon'
        inClass: FButton
      changes:
        - kind: renameParameter
          oldName: 'onStateChange'
          newName: 'onVariantChange'

    # FButtonController
    - title: 'Rename FButtonController.state to FButtonController.variant'
      date: 2026-01-26
      element:
        uris: [ 'package:forui/forui.dart' ]
        getter: 'state'
        inClass: FButtonController
      changes:
        - kind: rename
          newName: 'variant'

    # FButtonStyle
    - title: 'Remove FButtonStyle(iconStyle: ...)'
      date: 2026-01-26
      element:
        uris: [ 'package:forui/forui.dart' ]
        constructor: ''
        inClass: FButtonStyle
      changes:
        - kind: removeParameter
          name: 'iconStyle'
```

## Code Generation

We rely extensively on code generation. To generate the following code, run `dart run build_runner build --delete-conflicting-outputs`.

### Widget Controls

Controls define how a widget is controlled. They follow a pattern using sealed classes with two variants:
* **Managed**: The widget manages its own controller internally while exposing parameters for common configurations.
* **Lifted**: The widget uses external state management, with the parent providing expanded/collapsed state and callbacks.

The control pattern is code-generated using `forui_internal_gen`. Files are organized as follows:
```
lib/src/widgets/my_widget/
├── my_widget_controller.dart          (Controller + Control definition)
├── my_widget_controller.control.dart  (GENERATED)
├── my_widget.dart                     (Widget + Style + Motion)
└── my_widget.design.dart              (GENERATED)
```

#### Proxy Controllers

Flutter is a controller-centric framework. Therefore, widgets that support lifted state require a proxy controller
that delegates operations to external callbacks given by the user instead of managing state internally.

For example, when a user expands an accordion item using `FAccordionControl.lifted(...)`, the proxy controller:
1. Receives the expansion request via the controller's public API (e.g., `expand(index)`)
2. Delegates to the parent's `onChange` callback instead of updating internal state
3. Reads current state from the parent's `expanded` predicate

```dart
@internal
class ProxyMyWidgetController extends FMyWidgetController {
  bool Function(int index) _supply;
  void Function(int index, bool value) _onChange;

  ProxyMyWidgetController(this._supply, this._onChange);

  void update(bool Function(int index) supply, void Function(int index, bool value) onChange) {
    _supply = supply;
    _onChange = onChange;
  }

  @override
  Future<bool> toggle(int index) async {
    _onChange(index, !_supply(index));
    return true;
  }
}
```

This allows the widget to use a consistent controller-based internal API regardless of whether state is managed
internally or lifted to a parent widget.

#### Control Sealed Class

The control sealed class should:
1. Mix in `Diagnosticable` and `_$FMyWidgetControlMixin` (generated).
2. Define `managed` and `lifted` factory constructors.
3. Define an `_update` method signature that returns `(FMyWidgetController, bool)`.

```dart
sealed class FMyWidgetControl with Diagnosticable, _$FMyWidgetControlMixin {
  const factory FMyWidgetControl.managed({
    FMyWidgetController? controller,
    // ... other managed parameters
  }) = FMyWidgetManagedControl;

  const factory FMyWidgetControl.lifted({
    // ... lifted state parameters
  }) = _Lifted;

  const FMyWidgetControl._();

  (FMyWidgetController, bool) _update(
    FMyWidgetControl old,
    FMyWidgetController controller,
    VoidCallback callback,
    // ... other parameters passed to createController
  );
}
```

#### Control Subclasses

The managed control should be a **public** class that mixes in the generated `_$FMyWidgetManagedControlMixin`:

```dart
class FMyWidgetManagedControl extends FMyWidgetControl with _$FMyWidgetManagedControlMixin {
  @override
  final FMyWidgetController? controller;
  // ... other @override fields

  const FMyWidgetManagedControl({this.controller, ...}) : super._();

  @override
  FMyWidgetController createController(/* parameters */) =>
    controller ?? FMyWidgetController(/* ... */);
}
```

The lifted control should be a **private** class that mixes in the generated `_$_LiftedMixin`:

```dart
class _Lifted extends FMyWidgetControl with _$_LiftedMixin {
  @override
  final /* lifted state fields */;

  const _Lifted({required /* ... */}) : super._();

  @override
  FMyWidgetController createController(/* parameters */) => /* ... */;

  @override
  void _updateController(FMyWidgetController controller, /* parameters */) { /* ... */ }
}
```

#### Using Control in Widget

Use the generated extension methods in your widget's `State`:

```dart
class _FMyWidgetState extends State<FMyWidget> {
  late FMyWidgetController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleChange, /* ... */);
  }

  @override
  void didUpdateWidget(covariant FMyWidget old) {
    super.didUpdateWidget(old);
    final (controller, _) = widget.control.update(old.control, _controller, _handleChange, /* ... */);
    _controller = controller;
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _handleChange);
    super.dispose();
  }
}
```

See [https://raw.githubusercontent.com/duobaseio/forui/refs/heads/main/forui/lib/src/widgets/accordion/accordion_controller.dart)
for a reference implementation.

### Widget Styles

```dart
@Variants(FWidget, {'hovered': 'The hovered state', 'pressed': 'The pressed state'}) // --- (1)
@Sentinels(FWidgetStyle, {'someDouble': 'double.infinity', 'color': 'colorSentinel'}) // --- (2)
part 'widget.design.dart'; // --- (3)

class FWidget { /* ... */ }

class FWidgetStyle with Diagnosticable, _$FWidgetStyleFunctions { // --- (4) (5)

  final double someDouble;
  final Color color;

  FWidgetStyle({required this.someDouble, required this.color});

  FWidgetStyle.inherit({FTypography typography, FColors colors}):
    someDouble = 16,
    color = colors.primary; // --- (6)
}
```

They should:
1. `@Variants` - Declares widget-specific variants (states). Maps variant names to documentation strings. Generates
   `FWidgetVariant` and `FWidgetVariantConstraint` extension types.
2. `@Sentinels` - Specifies sentinel values for delta merges. Maps field names to their sentinel values (e.g.,
   `'double.infinity'`, `'colorSentinel'`). Used to distinguish "no change" from actual values in generated delta classes.
3. Include a generated part file (`*.design.dart`) containing `_$FWidgetStyleFunctions`, delta classes, and variant types.
4. Mix-in [Diagnosticable](https://api.flutter.dev/flutter/foundation/Diagnosticable-mixin.html).
5. Mix-in `_$FWidgetStyleFunctions` (generated utility functions).
6. Provide constructors including `inherit(...)` for theme-based defaults.

To generate files, run `dart run build_runner build --delete-conflicting-outputs` in the forui/forui directory.

Platform variants (touch, desktop, android, iOS, etc.) are automatically included in generated variant types.

## Testing

Parameterize tests using for-each loop to cover multiple scenarios when sensible.

Prefer literals to matchers where possible, e.g. `expect(value, null)` instead of `expect(value, isNull)`.