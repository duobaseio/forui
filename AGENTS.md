## Style Guide

* Prefix publicly exported widgets and styles with `F`.
* Prefer [dot-shorthands](https://dart.dev/language/dot-shorthands) where possible except for unnamed constructors.
  ```dart
  // Good - dot-shorthand for named constructors, static methods, and enum values
  FAccordionControl control = .managed(min: 1);
  EdgeInsetsGeometry padding = .all(8);

  // Bad - don't use dot-shorthand for unnamed constructors (hurts readability)
  FWidgetStyle style = .new(...);  // Don't do this
  FWidgetStyle style = FWidgetStyle(...);  // Do this instead
  ```
* Prefer `AlignmentGeometry`/`BorderRadiusGeometry`/`EdgeInsetsGeometry` over `Alignment`/`BorderRadius`/`EdgeInsets`. 
* Minimize dependency on Cupertino/Material.

## Changelog organization

Each release section is a level 2 heading. Make sure you're always adding entries in the unreleased section at the top.

* Group entries by widget in alphabetical order.
* Each widget section should be a level 3 heading with the widget names in backticks.
* Related widgets should be grouped under the same heading (e.g., `FItem` & `FItemGroup`, `FSelect` & `FMultiSelect`).
* Separate each widget section with 2 newlines.
* Wrap each line at 120 characters.

Within each widget section, order entries as follows:
1. Additions (start with "Add")
2. Changes (start with "Change", "Rename", or similar)
3. Removals (start with "Remove")
4. Fixes (start with "Fix")

Separate each category with a blank line. Breaking changes must start with `**Breaking**`.

Example:
```markdown
### `FButton`
* Add `FButtonStyles.primary` getter.

* **Breaking** Remove `FButtonSizes` typedef. Use `FButtonSizeStyles` instead.


### `FSelect` & `FMultiSelect`
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
