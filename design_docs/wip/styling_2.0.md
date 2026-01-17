# Styling 2.0

Author: Matt (Pante)
Status: WIP

## Summary

This document outlines the problems that we have observed with the current styling system over the last few year(s). In
addition, it proposes a series of potential solutions to those problems that together form Styling 2.0.

Generally, most of the problems stem from misguided assumptions about usage patterns as well as our relative inexperience
in designing a styling system. This led to an unergonomic API where it is possible but painful to achieve common styling
tasks.


## Styling CLI

We previously introduced a styling CLI in Forui 0.11.0 to try to mitigate the issue. However, it failed to gain widespread
adoption due to poor discoverability and workflow disruption from context switching. Most importantly, it is an extremely
blunt tool that generated entire styling files rather than minor tweaks to existing styles.

The CLI will no longer be actively promoted as the default way to style widgets. Nevertheless, removing the CLI is
**not** a goal. It is still a niche yet useful tool for developers that wish to build radically different design systems,
and will continue to complement Styling 2.0.


## Simplifying Style Modification

In the current styling system, modifying a style requires a callback and an explicit `copyWith(...)` call that repeats
for each level of nesting.

```dart
FAutocomplete(
  style: (style) => style.copyWith(
    contentStyle: (content) => content.copyWith(
      sectionStyle: (section) => section.copyWith(
        itemStyle: (item) => item.copyWith(
          tappableStyle: (tappable) => tappable.copyWith(
            motion: FTappableMotion.none, // All this boilerplate just to change one property.
          ),
        ),
      ),
    ),
  ),
)
```

Due to the excessive amount of boilerplate, these nested callbacks and `copyWith` calls are both painful to write and 
difficult to read and reason about. This is exacerbated by most styles being deeply nested and the frequency of deep
modifications. Callbacks were originally introduced to make an existing style available in the lexical scope and avoid
accessing a chain of fields each time. Although it _did_ make it easier to obtain the current style, there is still much
to be desired.

Beyond the callbacks, the current `copyWith(...)` methods are not able to differentiate between `null` and "no change" 
since both are represented as `null`. Consequently, nullable fields can never be set to `null` using `copyWith(...)`.

```dart
class FExampleStyle {
  final Color? background;
  final EdgeInsets padding;

  FExampleStyle copyWith({Color? background, EdgeInsets? padding}) => FExampleStyle(
    background: background ?? this.background,
    padding: padding ?? this.padding,
  );
}

void usage() {
  FExample(
    // Can't set background to null & keeps the existing background
    style: (style) => style.copyWith(background: null),
  );
}
```

From our observations, most developers only modify a few properties of an existing style rather than replacing it. 
Thus, to fix this, we propose simplifying style modification by eliminating the need for callbacks and `copyWith(...)`
calls.

It is **not** a goal to remove the `copyWith(...)` methods. They will remain available, albeit modified to accept nested
styles directly rather than through callbacks, and use sentinel values to distinguish between `null` and "no change".

To simplify modification, we introduce `Delta`s that correspond to styles, with widgets accepting deltas rather than 
style callbacks.

Given `FAutocompleteStyle`, `FAutocompleteStyleDelta` is defined as:

```dart
mixin Delta<S> {
  S apply(S base);
}

abstract class FAutocompleteStyleDelta with Delta<FAutocompleteStyle> {
  factory FAutocompleteStyleDelta.merge({
    FTextFieldStyleDelta? fieldStyle,
    FAutocompleteContentStyleDelta? contentStyle,
  }) = _FAutocompleteStyleMerge;

  factory FAutocompleteStyleDelta.replace(FAutocompleteStyle style) = _FAutocompleteStyleReplace;
}

class _FAutocompleteStyleMerge implements FAutocompleteStyleDelta {
  final FTextFieldStyleDelta? fieldStyle;
  final FAutocompleteContentStyleDelta? contentStyle;

  const _FAutocompleteStyleMerge({this.fieldStyle, this.contentStyle});

  // Applies the delta inside FAutocomplete.
  @override
  FAutocompleteStyle apply(FAutocompleteStyle base) => FAutocompleteStyle(
    fieldStyle: fieldStyle?.apply(base.fieldStyle) ?? base.fieldStyle,
    contentStyle: contentStyle?.apply(base.contentStyle) ?? base.contentStyle,
  );
}

class _FAutocompleteStyleReplace implements FAutocompleteStyleDelta {
  final FAutocompleteStyle _style;

  const _FAutocompleteStyleReplace(this._style);

  // Applies the delta inside FAutocomplete.
  @override
  FAutocompleteStyle apply(FAutocompleteStyle base) => _style;
}

// FTextFieldStyleDelta and FAutocompleteContentStyleDelta are omitted for brevity.
```

With deltas, styles can be modified succinctly, though deep nesting remains.

```dart
FAutocomplete(
  style: .merge(
    contentStyle: .merge(
      sectionStyle: .merge(
        itemStyle: .merge(
          tappableStyle: .merge(
            motion: FTappableMotion.none,
          ),
        ),
      ),
    ),
  ),
)
```

Replacing a style entirely is also supported via `.replace(...)`.

```dart
FAutocomplete(
  style: .merge(
    contentStyle: .replace(FAutocompleteContentStyle(...)),
  ),
)
```

Deltas use sentinel values rather than `null` to represent "no change", allowing nullable fields to be set to `null`.

```dart
class _SentinelColor extends Color {
  const _SentinelColor();
}

abstract class FExampleStyleDelta with Delta<FExampleStyle> {
  factory FExampleStyleDelta.merge({Color? background, EdgeInsets? padding}) = _FExampleStyleMerge;
}

class _FExampleStyleMerge implements FExampleStyleDelta {
  final Color? background;
  final EdgeInsets? padding;

  const _FExampleStyleMerge({this.background = const _SentinelColor(), this.padding});
}

void usage() {
  FExample(
    style: .merge(background: null), // sets background to null
  );

  FExample(
    style: .merge(),            // keeps existing background
  );
}
```

Style deltas will be generated for each style while deltas for Flutter types like `BoxDecoration` and `TextStyle` will 
be implemented manually. Furthermore, since there are few nullable types, we manually implement the sentinel values which
are then referenced by the generated code.

### Alternatives

We evaluated using a Fluent API similar to [Mix](https://www.fluttermix.com/documentation/guides/styling) but found it
to be unidiomatic to Flutter and not to our tastes. [A small-scale user study conducted by Flutter when experimenting
with using decorators](https://github.com/flutter/flutter/issues/161345#issuecomment-2666390902) to styling widgets also 
found them to have a mixed impact on understandability.


## Order-independent Widget State Resolution

`FWidgetStateMap` currently uses a **first-match-wins strategy** to resolve widget states.

Given the following constraints:
```
{
  hovered: A(),
  hovered & focused: B(),
}
```

`{ hovered, focused }` will **always resolve to `A()`**  since it is defined first, even though `B()` is the more
specific match which most developers expect. In other words, the `FWidgetStateMap` is order-dependent, which is
unintuitive and error-prone.

Order-dependency breaks encapsulation. Introducing a new constraint to a `FWidgetStateMap` requires knowledge of how
definitions are ordered internally since arbitrary insertion of new constraints may accidentally override existing ones.
It also means that every change made to the default constraints can subtly break developer customizations.

```
// Where should "hovered & selected: C()" go?
{
  hovered: A(),
  hovered & selected & focused: B(),
}
```

For these reasons, `FWidgetStateMap` opts not to provide any insertion methods, forcing developers to redefine the entire
map when adding new constraints. This is cumbersome and leads to poor DX.

To solve this, we propose a **most-specific-wins strategy** to resolve widget states.

Reusing the previous example:
```
{
  hovered: A(),
  hovered & focused: B(),
}
```

`{ hovered, focused }` will **always resolve to `B()`** since it is the most specific match. This holds true even when
the order of definitions is changed or less specific constraints are added. In other words, resolution is now
order-independent, which has wide-reaching implications.

Encapsulation is preserved. A new constraint can be arbitrarily inserted without knowledge of the internals. Adding default
constraints will not break existing customizations either since the developer constraints are applied after and will
override the defaults.

Determining the "most specific" constraint for a given set of states is equivalent to finding the constraint that matches
the fewest possible states.

```
Assuming 2 states: hovered, focused
Possible state sets: {}, {h}, {f}, {h,f}

hovered          → 2 matches: {h}, {h,f}
hovered & focused → 1 match:  {h,f}

Fewer matches = more specific
For {h,f}, resolve to the constraint matching fewest sets: hovered & focused
```

This reduces to the [SAT problem](https://en.wikipedia.org/wiki/Boolean_satisfiability_problem) which is NP-complete.
A SAT solver is too computationally expensive given that constraints are resolved in the build method, part of the
rendering pipeline, and everything must be completed under 16ms and 8ms per frame to maintain 60fps and 120fps respectively.
Not to mention, there are not any well-established SAT solver libraries for Dart/Flutter to our knowledge except for
[PubGrub](https://github.com/dart-lang/pub/blob/master/doc/solver.md) but using that brings its own share of problems.

Instead, we use a simple counting system that only supports AND (&) and NOT(~) operators to determine specificity. The
system simply counts the number of operands in a constraint, with the highest count winning.

```
// Count = number of operands
hovered                      = 1
~hovered                     = 1
focused                      = 1
hovered & focused            = 2
hovered & ~focused           = 2
hovered & focused & pressed  = 3
```

OR (|) operators are not supported as intermixing with AND operators lead to a significantly worse heuristic with
unintuitive edge cases. To express `A | B`, define two separate constraints. This is simplified by modifying the API to
accept a set of constraints that map to the same value.

```
// Logical OR (not supported):
{ hovered | pressed: style }

// Set of constraints (supported):
{ {hovered, pressed}: style }
```

Constraints such as `A & ~A` can be defined but are effectively impossible to match. To tiebreak constraints with equal
counts, operands within a constraint are first sorted alphabetically, then constraints are compared lexicographically.
This guarantees a deterministic resolution that is order-independent.

```
// states = {hovered, focused, pressed}
{
  hovered & focused: A(),   // count 2
  focused & pressed: B(),   // count 2
}

// Tiebreaker:

// Sort:
hovered & focused → sort → ["focused", "hovered"]
focused & pressed → sort → ["focused", "pressed"]

// Lexicographical comparison:
[0]: "focused" == "focused" → continue
[1]: "hovered" < "pressed"  → winner

→ resolves to A()
```

As a future enhancement, we can consider introducing an analyzer plugin that detects and warns against defining impossible
constraints and constraints with equal specificity.


## Widget-specific States

The current styling system uses Flutter's in-built [WidgetState](https://api.flutter.dev/flutter/widgets/WidgetState.html)
to represent widget states.

Since `WidgetState` is an enum, it is impossible to define new states. For example, a calendar may have a `today` and
`enclosing` state. The current restrictions force us to define these states as separate fields.

```dart
class FCalendarStyle {
  final FWidgetStateMap<FTappableStyle> todayStyle;
  final FWidgetStateMap<FTappableStyle> enclosingStyle;
  final FWidgetStateMap<FTappableStyle> tappableStyle;
}
```

As each state is represented as a field, they do not compose. Developers cannot specify a style for `today & enclosing`
without a dedicated field for that combination. Adding every combination is infeasible since the number of possible fields
grows exponentially with the number of states, exploding the API surface area. Lastly, this introduces a dichotomy:
states defined in `WidgetState` are modeled using `FWidgetStateMap` while those outside it are modeled as fields.

Conversely, `WidgetState` defines too many generic states that are not applicable to all widgets. This is further
exacerbated by `WidgetState` formerly being `MaterialState` and including Material-specific states such as
[`scrolledUnder`](https://api.flutter.dev/flutter/widgets/WidgetState.html#scrolledUnder) which is only used by `AppBar`.

It is currently perfectly valid to pass in unsupported states since there is no compile-time validation.

```dart
// Compiles fine, but scrolledUnder is meaningless for a tappable
FTappableStyle(
  decoration: FWidgetStateMap({
    WidgetState.scrolledUnder: BoxDecoration(...),  // silently ignored
  }),
)
```

This hurts discoverability as developers must consult each field's documentation to determine what fields they support.
It also increases the likelihood of bugs since it falls to us to manually sync the documentation with the actual
supported states across many fields.

```dart
FTappableStyle(
  decoration: FWidgetStateMap({
    WidgetState.selected: BoxDecoration(...),  // Does FTappableStyle support selected? Who knows.
  }),
)
```

In summary, `WidgetState` is too closed to extend yet too open to misuse.

To fix this, we propose replacing `WidgetState` with **widget-specific states**.

Reusing the previous example, we define `FWidgetState` as a base which all widget-specific states extend. `FCalendarState`
and `FTappableState` represent calendar-specific and tappable-specific states respectively.

```dart
sealed class FWidgetState {
  const factory FWidgetState() = _Value;

  const FWidgetState._();

  bool satisfiedBy(Set<FWidgetState> variants);
}

class _Value extends FWidgetState {
  const _Value(): super._();

  @override
  bool satisfiedBy(Set<FWidgetState> variants) => variants.contains(this);
}

class _And extends FWidgetState {
  final FWidgetState first;
  final FWidgetState second;

  const _And(this.first, this.second): super._();

  @override
  bool satisfiedBy(Set<FWidgetState> variants) => first.satisfiedBy(variants) && second.satisfiedBy(variants);
}

final class _Not extends FWidgetState {
  final FWidgetState value;

  const _Not(this.value): super._();

  @override
  bool satisfiedBy(Set<FWidgetState> variants) => !value.satisfiedBy(variants);
}

extension type const FCalendarState(FWidgetState _) implements FWidgetState {
  static const enclosing = FCalendarState(.new());

  static const today = FCalendarState(.new());

  factory FCalendarState.not(FCalendarState other) => .new(_Not(other));

  FCalendarState and(FCalendarState other) => .new(_And(this, other));
}

extension type const FTappableState(FWidgetState _) implements FWidgetState {
  static const focused = FTappableState(.new());

  static const hovered = FTappableState(.new());

  static const pressed = FTappableState(.new());

  factory FTappableState.not(FTappableState other) => .new(_Not(other));

  FTappableState and(FTappableState other) => .new(_And(this, other));
}
```

With widget-specific states, we can define all states in a single, unified way using `FWidgetStateMap`:

```dart
class FCalendarStyle {
  final FWidgetStateMap<FCalendarState, FTappableStyle> tappableStyle;
}

FCalendarStyle(
  tappableStyle: {
    .today: FTappableStyle(...),
    .today.and(.enclosing): FTappableStyle(...),
    .enclosing: FTappableStyle(
      decoration: FWidgetStateMap({
        .hovered.and(.not(.pressed)): BoxDecoration(...),
      }),
    ),
  },
)
```

[Dot shorthands do not work with operator overloading](https://github.com/dart-lang/language/issues/4609). We prioritize
dot shorthands over operators since type names are verbose and hurt readability. To enable this, methods such as `and(...)`
and `not(...)` are used instead of operator overloads.

To prevent accidental mixing of incompatible states, `and(...)` and `not(...)` are defined in the specific states and
accept and return covariant state types.

```dart
// ✗ Compile error: incompatible state types
FCalendarState.today.and(FTappableState.hovered);
```

Since states are widget-specific, all states are valid and developers do not have to perform any guesswork. Likewise,
developers discover valid states through autocomplete rather than documentation.

One potential downside to this "share nothing" approach is the duplication/redeclaration of fields across widget-specific
states and consequently a significantly larger API surface. Code generation will alleviate duplication;
[static field augmentation](https://github.com/dart-lang/language/blob/main/working/augmentations/feature-specification.md)
may further reduce boilerplate once available. We accept a larger API surface to gain the benefits of discoverability and type-safety.

### Guidelines for Defining Widget-specific States

We codify the following guidelines for defining widget-specific states:
* Non-exclusive by default. Avoid having mutually exclusive states like **both** `enabled` and `disabled`; prefer just
  `disabled`.
* Model the exception. Since most widgets are enabled by default, define only `disabled`, not `enabled`.

### Alternatives

We considered making states composable depending on the context. For example, a `FTappableStyle` alone will accept only
`FTappableState`, but when nested inside a `FCalendarStyle`, it accepts `FCalendarTappableState` which implements both
`FCalendarState` and `FTappableState`. This approach however, meant an even larger API surface since N parent widgets
embedding M child widgets will require N * M state types. More worryingly, it encourages a "property-first" API which
is more verbose and difficult to reason about at scale compared to a "state-first" API.

```dart
// Property-first:
ButtonStyle(
  backgroundColor: {
    .hovered: blue,
    .pressed: darkBlue,
    .disabled: grey,
  },
  textColor: {
    .hovered: white,
    .pressed: white,
    .disabled: lightGrey,
  },
  borderColor: {
    .hovered: blue,
    .pressed: darkBlue,
    .disabled: grey,
  },
)

// State-first:
ButtonStyle(
  styles: {
    .hovered: (backgroundColor: blue, textColor: white, borderColor: blue),
    .pressed: (backgroundColor: darkBlue, textColor: white, borderColor: darkBlue),
    .disabled: (backgroundColor: grey, textColor: lightGrey, borderColor: grey),
  },
)
```


## Generalizing Widget States to Variants

The current styling system does not support platform-specific or responsive styling. Instead, developers must manually
check the platform or screen size and apply conditional logic when building styles.

```dart
FDialogStyle(
  padding: Platform.isIOS ? .all(16) : .all(12),
  axis: MediaQuery.ofSize(context).width > 600 ? .horizontal : .vertical,
)
```

This makes styles difficult to modify as overriding a single platform or adding a new one requires rewriting the entire
conditional logic. It is worse when the conditional is defined inside Forui as developers must understand the 
implementation details to make minor tweaks, thereby breaking encapsulation.

```dart
// Inside library:
FDialogStyle(
  padding: Platform.isIOS ? .all(16) : .all(12),
)

// User wants to change just iOS padding to 20:
FDialogStyle(
  padding: Platform.isIOS ? .all(20) : .all(12),  // must also know/copy other platforms' value  
)
```

More importantly, this introduces a dichotomy: platform and responsive styling rely on conditional logic while widget
state styles use `FWidgetStateMap`.

To fix this, we propose unifying platform/responsive styling and widget states under a single concept: **Variants**. 
This approach is inspired by [Mix's dynamic styling](https://www.fluttermix.com/documentation/guides/dynamic-styling).

Building on the [widget-specific states design](#widget-specific-states), we rename `FWidgetState` to `FVariant` (and 
correspondingly, `FTappableState` to `FTappableVariant`, etc.).

```dart
sealed class FVariant {
  // Platform variants
  static const android = FVariant();
  
  static const ios = FVariant();
  
  static const web = FVariant();
  
  // Responsive variants
  static const xs = FVariant();
  
  static const sm = FVariant();
  
  const factory FVariant() = _Value;

  const FVariant._();

  bool satisfiedBy(Set<FVariant> variants);
}

extension type const FDialogVariant(FVariant _) implements FVariant {
  // Platform variants
  static const android = FDialogVariant(.android);
  
  static const ios = FDialogVariant(.ios);
  
  static const web = FDialogVariant(.web);
  
  // Responsive variants
  static const xs = FDialogVariant(.xs);
  
  static const sm = FDialogVariant(.sm);
  
  // Dialog-specific variants
  static const focused = FDialogVariant(.new());
  
  factory FDialogVariant.not(FDialogVariant other) => .new(_Not(other));

  FDialogVariant and(FDialogVariant other) => .new(_And(this, other));
}
```

Each widget variant defines the platform and responsive variants it supports. [As mentioned previously](#widget-specific-states), 
this leads to a larger API surface area, but we accept this tradeoff for improved discoverability and type-safety.

With variants, we can map platform, responsive and widget-specific variants to styles using `FVariants` (renamed from 
`FWidgetStateMap`).

```dart
FDialogStyle(
  padding: {
    .ios: .all(16),
    .ios.and(.focused).and(.not(.sm)): .all(20),
    .android: .all(12),
  },
  axis: {.sm: .vertical, .md: .horizontal},
)
```

Platform and responsive variants are defined once in `FVariant`. Widget-specific variants like `FDialogVariant` wrap 
these base constants. Since extension types are compiled away, these wrapped constants will be equal across variants.

To provide these platform and responsive variants across the entire application, we introduce a `FAdaptiveScope` that
combines a `LayoutBuilder` and `InheritedWidget` to provide the current platform and responsive variants down the widget 
tree. An extension getter on `BuildContext`, `context.adaptiveVariants`, is also provided to retrieve said variants from 
the nearest `FAdaptiveScope`. An `FTheme` widget will include a `FAdaptiveScope` by default.

### Summary of Renames

| Before            | After              |
|-------------------|--------------------|
| `FWidgetState`    | `FVariant`         |
| `FWidgetStateMap` | `FVariants`        |
| `FTappableState`  | `FTappableVariant` |
| `FCalendarState`  | `FCalendarVariant` |
