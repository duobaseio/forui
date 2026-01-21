# Styling 2.0

Author: Matt (Pante)
Status: WIP

## Summary

This document outlines problems we have observed with the current styling system and proposes solutions that together
form Styling 2.0.

## Table of Contents

1. [Styling CLI](#1-styling-cli)
2. [Simplifying Style Modification](#2-simplifying-style-modification)
3. [Order-independent Widget State Resolution](#3-order-independent-widget-state-resolution)
4. [Widget-specific States](#4-widget-specific-states)
5. [Generalizing Widget States to Variants](#5-generalizing-widget-states-to-variants)
6. [Simplifying FVariants](#6-simplifying-fvariants)
7. [Migration](#7-migration)
8. [Future Work](#8-future-work)


## 1. Styling CLI

A styling CLI was previously introduced in 0.11.0 to alleviate the problems. Adoption was low due to poor discoverability
and workflow disruption from constant context switching. More importantly, it generates entire style files when minor
tweaks are needed, akin to using a sledgehammer for surgery.

The CLI will no longer be the recommended way to style widgets. However, removing the CLI is **not** a goal as it is 
still useful for developers that build radically different design systems.


## 2. Simplifying Style Modification

Modifying a style requires a callback and an explicit `copyWith` call that repeats for each level of nesting.

```dart
FAutocomplete(
  style: (style) => style.copyWith(
    contentStyle: (content) => content.copyWith(
      sectionStyle: (section) => section.copyWith(
        itemStyle: (item) => item.copyWith(
          tappableStyle: (tappable) => tappable.copyWith(
            motion: FTappableMotion.none, // All this just to change one property.
          ),
        ),
      ),
    ),
  ),
)
```

These nested callbacks and `copyWith` calls are painful to read, write, and reason about. It is exacerbated by styles
typically being ~3 levels deep and the frequency of deep modifications. Callbacks were introduced to provide the current
style without field chaining. Although helpful, there is still much to be desired.

Beyond the callbacks, `copyWith` is unable to distinguish between `null` and "no change". Consequently, nullable fields
can never be set to `null`.

```dart
class FooStyle {
  final Color? background;
  final EdgeInsets padding;

  FooStyle copyWith({Color? background, EdgeInsets? padding}) => FooStyle(
    background: background ?? this.background,
    padding: padding ?? this.padding,
  );
}
```

Usage:

```dart
Foo(
  // Can't set background to null.
  style: (style) => style.copyWith(background: null),
);
```


### Proposed Solution

Most developers only modify a few properties rather than replace an entire style. Thus, we propose eliminating the need
for callbacks and `copyWith` when modifying styles.

Removing `copyWith` is **not** a goal. They will be modified to accept styles (not callbacks) and use sentinel values 
to distinguish between `null` and "no change".

Each style will have a corresponding `Delta`, and widgets will accept deltas instead of callbacks.

Given `FAutocompleteStyle`:

```dart
mixin Delta<S> {
  S apply(S base);
}

sealed class FAutocompleteStyleDelta with Delta<FAutocompleteStyle> {
  factory FAutocompleteStyleDelta.merge({
    FAutocompleteContentStyleDelta? contentStyle,
  }) = _Merge;

  factory FAutocompleteStyleDelta.replace(FAutocompleteStyle style) = _Replace;
}

class _Merge implements FAutocompleteStyleDelta {
  final FAutocompleteContentStyleDelta? contentStyle;

  _Merge({this.contentStyle});

  // Applies the delta inside FAutocomplete.
  @override
  FAutocompleteStyle apply(FAutocompleteStyle base) =>
      FAutocompleteStyle(
        contentStyle: contentStyle?.apply(base.contentStyle) ?? base.contentStyle,
      );
}

class _Replace implements FAutocompleteStyleDelta {
  final FAutocompleteStyle _style;

  _Replace(this._style);

  // Applies the delta inside FAutocomplete.
  @override
  FAutocompleteStyle apply(FAutocompleteStyle base) => _style;
}
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

Replacing a style is also supported via `.replace(...)`.

```dart
FAutocomplete(
  style: .merge(
    contentStyle: .replace(FAutocompleteContentStyle(...)),
  ),
)
```

Deltas use sentinel values for "no change", so `null` means `null`.

```dart
class _Sentinel extends Color {
  const _Sentinel();
}

abstract class FooStyleDelta with Delta<FooStyle> {
  factory FooStyleDelta.merge({Color? background, EdgeInsets? padding}) = _Merge;
}

class _Merge implements FooStyleDelta {
  final Color? background;
  final EdgeInsets? padding;

  const _Merge({this.background = const _Sentinel(), this.padding});
}
```

Usage:

```dart
Foo(
  style: .merge(background: null), // sets background to null
);

Foo(
  style: .merge(), // keeps existing background
);
```

Style deltas will be generated while Flutter type deltas, e.g. `BoxDecoration`, and sentinel values will be manually
implemented.

### Alternatives

We considered a fluent API similar to [Mix](https://www.fluttermix.com/documentation/guides/styling). However, it felt
unidiomatic and not to our tastes. [Small user studies](https://github.com/flutter/flutter/issues/161345#issuecomment-2666390902) 
conducted by Flutter found decorators to have mixed impact on understandability.


## 3. Order-independent Widget State Resolution

`FWidgetStateMap` uses a **first-match-wins strategy** to resolve widget states.

Given the following constraints:

```
hovered: A()
hovered & focused: B()
```

A set of states, `{ hovered, focused }`, will always resolve to `A()` since it is defined first although `B()` is more 
specific. In other words, `FWidgetStateMap` is order-dependent which is unintuitive and error-prone.

Order-dependency breaks encapsulation. Adding constraints requires knowing internal order since arbitrary insertions may 
override existing ones. Adding default constraints can also subtly break developer customizations. Hence, no insertion 
methods are provided. This forces developers to recreate a `FWidgetStateMap` which is poor DX.

```
// Where should "hovered & selected: C()" go?

hovered: A()
hovered & selected & focused: B()
```

### Proposed Solution

We propose a **most-specific-wins strategy** to resolve widget states.

```
hovered: A(),
hovered & focused: B(),
```

A set of states, `{ hovered, focused }`, will always resolve to `B()` since it is the most specific. This is true even
when the constraints are reordered or a less specific constraint is added. In other words, resolution is order-independent.

Encapsulation is preserved. Adding new constraints does not require knowing internal ordering. Likewise, adding default
constraints will no longer break developer customizations since the latter are applied last.

The "most-specific" constraint matches the fewest state sets.

```
Given 2 states: hovered, focused
Possible sets: {}, {h}, {f}, {h,f}

hovered           → 2 matches: {h}, {h,f}
hovered & focused → 1 match:  {h,f}

Fewer matches = more specific
For {h,f}, resolve to the constraint matching fewest sets: hovered & focused
```

This reduces to the [SAT problem](https://en.wikipedia.org/wiki/Boolean_satisfiability_problem) which is NP-complete.
Constraints are resolved in the build method and a SAT solver is too slow for the 8ms frame budget for 120 FPS. No
well-established Dart SAT solvers except [PubGrub](https://github.com/dart-lang/pub/blob/master/doc/solver.md) exist either.

Instead, specificity = operand count while only AND (&) and NOT (~) operators are allowed. Highest count wins.

```
// Count = number of operands
hovered                      = 1
~hovered                     = 1
hovered & focused            = 2
hovered & ~focused           = 2
hovered & focused & pressed  = 3
```

OR (|) operators are not allowed as intermixing leads to a worse heuristic with sharp edge cases. Instead, OR expressions 
are split into separate constraints with a set of constraints mapping to one value.

```
// Logical OR (not supported):
hovered | pressed: value

// Set of constraints (supported):
{hovered, pressed}: value
```

To break ties, operands in a constraint are first sorted alphabetically then constraints are compared lexicographically. 
This guarantees a deterministic and order-independent resolution.

```
// states = {hovered, focused, pressed}
hovered & focused: A(),   // count 2
focused & pressed: B(),   // count 2

// Tiebreaker:

// Sort:
hovered & focused → sort → ["focused", "hovered"]
focused & pressed → sort → ["focused", "pressed"]

// Lexicographical comparison:
[0]: "focused" == "focused" → continue
[1]: "hovered" < "pressed"  → winner

→ resolves to A()
```

Invalid constraints like `A & ~A` can still be written. As future work, we can introduce an analyzer plugin that flags
invalid and ambiguous constraints.

### Alternatives

We considered allowing OR (|) operators by automatically splitting them into distinct constraints in a preprocessing step. 
Doing so reduces the boilerplate for single states, e.g. `hovered` instead of `{hovered}`. However, this requires constraints 
to be in [disjunctive normal form](https://en.wikipedia.org/wiki/Disjunctive_normal_form), which is unintuitive.


## 4. Widget-specific States

Flutter's in-built [WidgetState](https://api.flutter.dev/flutter/widgets/WidgetState.html) is used to represent widget states.

Since `WidgetState` is an enum, it is impossible to define new states. A calendar may have a `today` and `enclosing` state
but is forced to define them as separate fields that do not compose.

```dart
class FCalendarStyle {
  final FWidgetStateMap<FTappableStyle> todayStyle;
  final FWidgetStateMap<FTappableStyle> enclosingStyle;
  final FWidgetStateMap<FTappableStyle> tappableStyle;
}
```

Values cannot be specified for a constraint without a field, e.g. `todayEnclosingStyle`. Moreover, it is infeasible to 
make every constraint a field since that grows exponentially with the number of states. Lastly, this introduces a dichotomy:
`WidgetState`s are modeled using `FWidgetStateMap` while other states are modeled as fields.

Conversely, `WidgetState` has too many generic states inapplicable to most widgets. This is exacerbated by `WidgetState` 
containing niche states like [`scrolledUnder`](https://api.flutter.dev/flutter/widgets/WidgetState.html#scrolledUnder)
which is only used by `AppBar`.

```dart
// Compiles fine, but scrolledUnder is meaningless for a tappable
FTappableStyle(
  decoration: FWidgetStateMap({
    WidgetState.scrolledUnder: BoxDecoration(...),  // Does FTappableStyle support scrolledUnder? Who knows.
  }),
)
```

It is possible to pass in unsupported states since there is no compile-time check. This hurts discoverability as finding
a field's supported states requires consulting its documentation. The likelihood of bugs also increases as the actual
supported states and documentation need to be manually synced across many fields.

In short, `WidgetState` is too closed to extend yet too open to misuse.

### Proposed Solution

We propose replacing `WidgetState` with **widget-specific states**.

We define `FVariant` as a base which all widget-specific states, e.g. `FCalendarVariant` and `FTappableVariant`, extend. 

> `WidgetState` is renamed to `FVariant`, and `FWidgetStateMap` to `FVariants`. The rationale is in the [next section](#5-generalizing-widget-states-to-variants).
> Just assume it is a simple rename for now.

```dart
sealed class FVariant {
  const factory FVariant() = _Value;

  bool satisfiedBy(Set<FVariant> variants);
}

class _Value implements FVariant {
  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(this);
}

class _And implements FVariant {
  final FVariant left;
  final FVariant right;

  @override
  bool satisfiedBy(Set<FVariant> variants) => left.satisfiedBy(variants) && right.satisfiedBy(variants);
}

class _Not implements FVariant {
  final FVariant value;

  @override
  bool satisfiedBy(Set<FWidgetState> variants) => !value.satisfiedBy(variants);
}

extension type const FCalendarVariant(FVariant _) implements FVariant {
  static const enclosing = FCalendarVariant(.new());

  static const today = FCalendarVariant(.new());

  factory FCalendarVariant.not(FCalendarVariant other) => .new(_Not(other));

  FCalendarVariant and(FCalendarVariant other) => .new(_And(this, other));
}

extension type const FTappableVariant(FVariant _) implements FVariant {
  static const hovered = FTappableVariant(.new());

  static const pressed = FTappableVariant(.new());

  factory FTappableVariant.not(FTappableVariant other) => .new(_Not(other));

  FTappableVariant and(FTappableVariant other) => .new(_And(this, other));
}
```

With widget-specific states, all states can be defined uniformly using `FVariants`.

```dart
class FCalendarStyle {
  final FVariants<FCalendarVariant, FTappableStyle> tappableStyle;
}

void usage() {
  FCalendarStyle(
    tappableStyle: FVariants({
      {.today}: FTappableStyle(...),
      {.today.and(.enclosing)}: FTappableStyle(...),
      {.enclosing}: FTappableStyle(
        decoration: FVariants({
          {.hovered.and(.not(.pressed))}: BoxDecoration(...),
        }),
      ),
    }),
  )
}
```

As [dot shorthands do not work with operator overloading](https://github.com/dart-lang/language/issues/4609), dot shorthands
are prioritized over operators since type names add noise and hurt readability. Consequently, `and(...)` and `not(...)`
replace operator overloads. To prevent accidental mixing, these methods are defined in specific states and accept and
return covariant types.

```dart
// ✗ Compile error: incompatible types
FCalendarVariant.today.and(FTappableVariant.hovered);
```

Widget-specific states ensure that all states are valid without guesswork. In addition, these states can be discovered
through autocomplete instead of documentation.

A downside to this is the redeclaration of fields across states leading to a significantly larger API surface. Code 
generation helps; [static field augmentation](https://github.com/dart-lang/language/blob/main/working/augmentations/feature-specification.md)
will further reduce boilerplate once available. We accept a larger API surface to improve discoverability and type-safety.

### Guidelines for Defining Widget-specific States

We codify the following guidelines for widget-specific states:
* Non-exclusive by default. Avoid having mutually exclusive states like **both** `enabled` and `disabled`; prefer just
  `disabled`.
* Model the exception. Since most widgets are enabled by default, define `disabled`, not `enabled`.

### Alternatives

We considered context-dependent state composition. A standalone `FTappableStyle` will only accept `FTappableVariant`
and `FCalendarTappableVariant` when nested inside a `FCalendarStyle`. However, this meant an even larger API surface
since N parents and M children requires N * M state types.


## 5. Generalizing Widget States to Variants

Platform-specific styling is not supported. Modifying a platform-specific style requires either rewriting the conditional 
logic, breaking encapsulation, or creating a new theme, which is extremely heavy-handed.

```dart
// Inside library:
FDialogStyle(
  padding: Platform.isIOS ? .all(16) : .all(12),
)

// User wants to change just iOS padding to 20:
FDialogStyle(
  padding: Platform.isIOS ? .all(20) : .all(12),  // must also know/copy other platforms' value or create a new theme.
)
```

Moreover, this introduces a dichotomy: platform states rely on conditional logic while widget-specific states rely on
`FWidgetStateMap`.

### Proposed Solution

Inspired by [Mix's dynamic styling](https://www.fluttermix.com/documentation/guides/dynamic-styling), we propose unifying 
platform and widget-specific state under a single concept: **Variants**. To do so, we rename the concept of `WidgetState`s 
to `FVariant` and `FWidgetStateMap` to `FVariants`.

Platform variants are defined in `FVariant` and wrapped by each widget-specific variant. Since extension types are
compiled away, these wrapped constants will be equal across variants. We deem the larger API surface an acceptable tradeoff.

```dart
sealed class FVariant {
  // Platform variants
  static const android = FVariant();
  
  static const ios = FVariant();
  
  static const web = FVariant();
}

extension type const FTappableVariant(FVariant _) implements FVariant {
  // Platform variants
  static const android = FTappableVariant(.android);
  
  static const ios = FTappableVariant(.ios);
  
  static const web = FTappableVariant(.web);
  
  // Tappable-specific variants
  static const hovered = FTappableVariant(.new());
}
```

`FVariants` can map both platform and widget-specific variants.

```dart
FTappableVariant(
  padding: FVariants({
    {.ios}: .all(16),
    {.ios.and(.focused)}: .all(20),
    {.android}: .all(12),
  }),
)
```

We introduce `FAdaptiveScope` to provide platform variants down the widget tree using `InheritedWidget`, and 
`BuildContext.platformVariant` for easier access. `FTheme` includes `FAdaptiveScope` by default. `FAdaptiveScope` accepts
an overriding platform variant as an escape hatch.

### Alternatives

Responsive variants were included originally but removed. Window-based breakpoints are not useful since widgets size
themselves according to the parent's constraints. Proper responsive layouts require even more coordination between widgets.


## 6. Simplifying `FVariants`

Most variants are minor modifications of a base variant instead of complete replacements. Modifying a variant is painful
as the base variant needs to be identified, extracted, and assigned to a local variable before use. It also precludes
the use of arrow syntax, leading to more verbose code. Furthermore, adding constraints requires recreating all mappings 
as mentioned in [order-independent widget state resolution](#3-order-independent-widget-state-resolution).

```dart
// Creation
FTappableStyle(
  decoration: FVariants({
    {.hovered, .pressed}: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
    {.any}: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
  }),
);

// Modification
FTappable(
  style: (style) {
    final base = style.decoration.resolve({WidgetState.any})!;
    return style.copyWith(
      decoration: FVariants({
        {.hovered}: base.copyWith(color: Colors.blue),
        {.pressed}: base.copyWith(color: Colors.darkBlue),
        {.any}: base,
      }),
    );
  },
)
```

`FVariants` does not assume a default value, necessitating an explicit `.any` mapping. Without compile-time checks,
this is easy to forget. [Modifying `.any` is also unintuitive](https://github.com/duobaseio/forui/issues/805). Additionally,
`FVariants.resolve(...)` must verify a match exists, precluding nullable types as it cannot distinguish between `null`
and "no match found".

```dart
// Modification
FTappable(
  style: (style) {
    final base = style.decoration.resolve({WidgetState.any})!;
    return style.copyWith(
      decoration: FVariants({
        {.hovered}: base.copyWith(color: Colors.blue),
        {.pressed}: base.copyWith(color: Colors.darkBlue),
        // Oops!
      }),
    );
  },
)
```

### Proposed Solution

We observe that a base value **is** the default value, and modifications are deltas. Building on `Delta`s in 
[simplifying style modification](#2-simplifying-style-modification), we split `FVariants` into `FVariants`, which maps
constraints to deltas, and `FLiteralVariants`, which maps constraints to concrete values. Both have a `base` field.

```dart
class FVariants<V extends FVariant, T, D extends Delta<T>> {
  final T base;
  final Map<Set<V>, D> deltas;

  FVariants(this.base, this.deltas);
}

// Creation
FTappableStyle(
  decoration: FVariants(
    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    {
      {.hovered, .pressed}: .merge(color: Colors.grey),
      {.disabled}: .replace(BoxDecoration(color: Colors.red)),
    },
  ),
);
```

```dart
class FLiteralVariants<V extends FVariant, T> {
  final T base;
  final Map<Set<V>, T> values;

  FLiteralVariants(this.base, this.values);
}

// Creation
FooStyle(
  spacing: FLiteralVariants(
    16,
    {
      {.compact}: 8,
      {.expanded}: 24,
    },
  ),
);
```

Unlike style deltas, `FVariantsDelta` and `FLiteralVariantsDelta` use `.apply(...)` instead of `.merge(...)` since typical 
usage is a sequence of operations and order matters (add-then-modify ≠ modify-then-add). 

In general, there are 3 types of operations:
* Adding a new variant.
* Mapping values.
* Removing an existing variant.

```dart
class FVariantsDelta<V extends FVariant, T, D extends Delta<T>> implements Delta<FVariants<V, T, D>> {
  FVariantsDelta.apply(List<FVariantDeltaOperation<V, T, D>> operations);

  // Escape hatch to replace entire variants.
  FVariantsDelta.replace(FVariants<V, T, D> variants);
}

class FVariantDeltaOperation<V extends FVariant, T, D> {
  // Base operations
  FVariantDeltaOperation.replaceBase(T base);

  FVariantDeltaOperation.mergeBase(D delta);

  // Variant operations
  FVariantDeltaOperation.add(Set<V> constraint, D delta);

  FVariantDeltaOperation.map(Set<V> constraint, D delta);

  FVariantDeltaOperation.remove(Set<V> constraint);
}
```

```dart
class FLiteralVariantsDelta<V extends FVariant, T> implements Delta<FLiteralVariants<V, T>> {
  FLiteralVariantsDelta.apply(List<FLiteralVariantDeltaOperation<V, T>> operations);

  // Escape hatch to replace entire variants.
  FLiteralVariantsDelta.replace(FLiteralVariants<V, T> variants);
}

class FLiteralVariantDeltaOperation<V extends FVariant, T> {
  // Base value operation
  FLiteralVariantDeltaOperation.replaceBase(T base);

  // Variant operations
  FLiteralVariantDeltaOperation.add(Set<V> constraint, T value);

  FLiteralVariantDeltaOperation.map(Set<V> constraint, T value);

  FLiteralVariantDeltaOperation.remove(Set<V> constraint);
}
```

The operations use inclusive matching. For example: `.map({.hovered, .focused}, delta)` affects:

```dart
final decoration = FVariants(
  BoxDecoration(color: Colors.white),
  {
    {.hovered}: .merge(color: Colors.blue),                   // ✓ contains hovered
    {.hovered, .pressed}: .merge(color: Colors.darkBlue),     // ✓ contains hovered
    {.focused}: .merge(color: Colors.green),                  // ✓ contains focused
    {.disabled}: .replace(BoxDecoration(color: Colors.grey)), // ✗ contains neither
  },
);
```


With [style deltas](#2-simplifying-style-modification), modifying `FTappable` becomes:

```dart
FTappable(
  // Merge using style delta
  style: .merge(
    // Apply all modifications without needing to extract base variant.
    decoration: .apply([
      .map({.hovered}, .merge(color: Colors.blue)),
      .map({.pressed}, .merge(color: Colors.darkBlue)),
    ]),
  ),
)
```

The `base` field is also the default, eliminating the need for `.any`. This also enables nullable types since 
`FVariants.resolve(...)` returns `base` when nothing matches.


### Alternatives

`FVariantsDelta` and `FLiteralVariantsDelta` may be overcomplicated. Style deltas could accept a callback, with operations
as methods on `FVariants` and `FLiteralVariants`.

```dart
FTappable(
  // Merge using style delta
  style: .merge(
    // Callback-based delta
    decoration: (variants) => variants
      .map({.hovered}, .merge(color: Colors.blue))
      .map({.pressed}, .merge(color: Colors.darkBlue)),
  ),
)
```


## 7. Migration

We expect most of these proposed changes to be breaking changes. Unfortunately, 
[data driven fixes](https://github.com/flutter/flutter/blob/master/docs/contributing/Data-driven-Fixes.md) may not be 
feasible due to the tool's limitations.


## 8. Future Work

### Animated Transitions Between Variants

It is worth adding support for animated transitions between variants, similar to [Mix](https://www.fluttermix.com/documentation/guides/animations), using `AnimatedDelta`s
with configurable duration and curve. Different transitions between specific variants should also be supported.

### Color Paths

It may be worth adding static shorthands to access the current theme's colors in `FColor`, e.g. `FColor.primary` for
`context.theme.colors.primary`. This is possible by abusing a [language quirk](https://github.com/dart-lang/language/issues/1711#issuecomment-2715814832). However, this requires a `DeferredColor`
wrapper that throws when accessed directly which is confusing and error-prone.
