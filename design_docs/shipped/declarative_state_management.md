# Towards Declarative State Management

Author: Matt (Pante)
Status: Shipped (Forui 0.17.0)

## Outline

This document outlines the introduction of a declarative state management API to Forui widgets. Most popular
state management solutions in Flutter (Riverpod, hooks, bloc) favor a declarative approach where state is driven by
properties and updated via callbacks. This contrasts with Forui's existing controller-based approach.

The conversion introduces significant (and unnecessary) complexity as a controller's lifecycle must be explicitly
maintained and a bidirectional sync among the state management solution, controller, and widget.

```
State Management (Declarative) <--> Forui Controllers (Imperative) <--> Forui Widgets (Declarative)
```

To solve this, we propose a new declarative API as an alternative to controllers. It is **not** a goal to remove
controllers entirely.

It was first discussed in https://github.com/forus-labs/forui/issues/711.

## API

We propose a sealed class pattern that supports both modes while mostly preserving compile-time safety.

In general, a widget has one sealed class per controller that encapsulates both modes:
```dart
sealed class FTextFieldControl {
  // Declarative mode (similar to React's controlled props)
  const factory FTextFieldControl.lifted({
    required TextEditingValue value,
    required ValueChanged<TextEditingValue> onChange,
  }) = Lifted;
  
  // Managed mode (existing controller-based approach)
  const factory FTextFieldControl.managed({
    TextEditingController? controller,
    TextEditingValue? initial,
    ValueChanged<TextEditingValue>? onChange,
  }) = Managed;
}
```


Declarative mode:
```dart
class _State extends State<MyWidget> {
  TextEditingValue _v = TextEditingValue(text: 'Banana');

  @override
  Widget build(BuildContext context) => FTextField(
    control: .lifted(
      value: _v,
      onChange: (v) => setState(() {
        if (v.text.contains('x')) {
          return; // reject changes with 'x'
        }
        _v = v;
      }),
    ),
  );
}
```

Controllers can still be used:
```dart
class _State extends State<MyWidget> {
  final controller = TextEditingController();
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FTextField(
    control: .managed(
      controller: controller, // Optional, will default to an internal controller if omitted.
      initial: TextEditingValue(text: 'Hello'),
    ),
  );
}
```

In most, if not all, cases, the `control` parameter is optional and defaults to `.managed()`. Although switching between
the two modes across rebuilds is not recommended, it is supported.

## Before and After Comparison

Before:
```dart
class _MyWidgetState extends State<MyWidget> {
    // External state (e.g., from Riverpod, signals, etc.)
    final ValueNotifier<TextEditingValue> _textState = ValueNotifier(
      const TextEditingValue(text: 'initial value'),
    );

    // Still need a controller to interface with FTextField
    late final TextEditingController _controller;

    // Track if we're updating programmatically to avoid loops
    bool _isUpdatingFromState = false;

    @override
    void initState() {
      super.initState();
      _controller = TextEditingController.fromValue(_textState.value);

      // Sync: state → controller
      _textState.addListener(_syncStateToController);

      // Sync: controller → state
      _controller.addListener(_syncControllerToState);
    }

    void _syncStateToController() {
      if (_controller.value != _textState.value) {
        _isUpdatingFromState = true;
        _controller.value = _textState.value;
        _isUpdatingFromState = false;
      }
    }

    void _syncControllerToState() {
      if (!_isUpdatingFromState && _controller.value != _textState.value) {
        _textState.value = _controller.value;
      }
    }

    @override
    Widget build(BuildContext context) {
      return FTextField(
        controller: _controller,
      );
    }

    @override
    void dispose() {
      _textState.removeListener(_syncStateToController);
      _controller.removeListener(_syncControllerToState);
      _controller.dispose();
      super.dispose();
    }
  }
```

After:
```dart
class MyWidget extends StatelessWidget {
  // External state (e.g., from Riverpod, signals, etc.)
  final ValueNotifier<TextEditingValue> textState;

  const MyWidget({required this.textState, super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: textState,
      builder: (context, value, _) => FTextField(
        control: FTextFieldControl.lifted(
          value: value,
          onChange: (v) => textState.value = v,
        ),
      ),
    );
  }
}
```

### Why `.managed()`?

We considered `.controlled()` but rejected it for two reasons:
* **React terminology conflict** - In React, "controlled" means the opposite: the *parent* controls state via props.
  Our `.managed()` means the *widget/controller* manages state.
* **Redundancy** - `.controlled(controller: c)` says "controller" twice. `.managed(controller: c)` reads more naturally.


## Controllers with Multiple Shapes

For widgets that support different selection shapes (e.g., FCalendar with single/multiple/range), the shape is encoded
as separate factories:

```dart
sealed class FCalendarControl {
  // Single date - declarative mode
  const factory FCalendarControl.liftedSingle({...});

  // Single date - controller mode
  factory FCalendarControl.managedSingle({...});

  // Multiple dates - declarative mode
  const factory FCalendarControl.liftedMultiple({...});

  // Multiple dates - controller mode
  factory FCalendarControl.managedMultiple({...});

  // Range - declarative mode
  const factory FCalendarControl.liftedRange({...});

  // Range - controller mode
  factory FCalendarControl.managedRange({...});
}
```

## State Independence Principle

### No Implicit Sync Between Lifted States

Each value + callback pair is isolated. Changing one state never automatically changes another when both are lifted.

### Sensible Defaults for Omitted States

When a state pair is omitted, the widget manages it internally with sensible behavior:

- **Omitted pair** = widget manages with sensible defaults (may include auto-sync to related states)
- **Provided pair** = user controls, no implicit sync

### Example: `FCalendar`

```dart
// displayedMonth omitted -> widget auto-scrolls to selected date
FCalendar(control: .liftedSingle(value: date, onChange: setDate))

// displayedMonth provided -> user controls, no auto-scroll
FCalendar(control: .liftedSingle(
  value: date,
  onChange: setDate,
  displayedMonth: month,
  onDisplayedMonthChange: setMonth,
))
```

If user wants sync when lifting `displayedMonth`, they wire it themselves:

```dart
FCalendar(control: .liftedSingle(
  value: date,
  onChange: (d) {
    setDate(d);
    setMonth(d);  // manual sync
  },
  displayedMonth: month,
  onDisplayedMonthChange: setMonth,
))
```

### Draft Implementation
* Usage: https://github.com/forus-labs/forui/blob/feature/declarative-state/forui/example/lib/sandbox.dart#L26
* `FTextField`: https://github.com/forus-labs/forui/blob/feature/declarative-state/forui/lib/src/widgets/text_field/text_field.dart#L1086
* `FTextFieldControl`: https://github.com/forus-labs/forui/blob/feature/declarative-state/forui/lib/src/widgets/text_field/text_field_control.dart#L1
