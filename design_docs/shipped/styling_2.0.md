# Styling 2.0

Author: Matt (Pante)
Status: Shipped (Forui 0.18.0)

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
  final Axis axis;

  FooStyle copyWith({Color? background, EdgeInsets? padding, Axis? axis}) => FooStyle(
    background: background ?? this.background,
    padding: padding ?? this.padding,
    axis: axis ?? this.axis,
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
mixin Delta {
  Object call(covariant Object? base);
}

sealed class FAutocompleteStyleDelta with Delta {
  factory FAutocompleteStyleDelta.delta({
    FAutocompleteContentStyleDelta? contentStyle,
  }) = _Delta;

  const factory FAutocompleteStyleDelta.inherit() = _Inherit;
}

class _Delta implements FAutocompleteStyleDelta {
  final FAutocompleteContentStyleDelta? contentStyle;

  _Delta({this.contentStyle});

  // Applies the delta inside FAutocomplete.
  @override
  FAutocompleteStyle call(FAutocompleteStyle base) =>
      FAutocompleteStyle(
        contentStyle: contentStyle?.call(base.contentStyle) ?? base.contentStyle,
      );
}

class _Inherit implements FAutocompleteStyleDelta {
  const _Inherit();

  @override
  FAutocompleteStyle call(FAutocompleteStyle base) => base;
}

// Styles implement their own delta, allowing direct usage for replacement.
class FAutocompleteStyle with _$FAutocompleteStyleFunctions implements FAutocompleteStyleDelta {
  // ...

  @override
  FAutocompleteStyle call(FAutocompleteStyle base) => this;
}
```

With deltas, styles can be modified succinctly, though deep nesting remains.

```dart
FAutocomplete(
  style: .delta(
    contentStyle: .delta(
      sectionStyle: .delta(
        itemStyle: .delta(
          tappableStyle: .delta(
            motion: FTappableMotion.none,
          ),
        ),
      ),
    ),
  ),
)
```

Replacing a style is supported by passing the style directly, since styles implement their own delta.

```dart
FAutocomplete(
  style: .delta(
    contentStyle: FAutocompleteContentStyle(...),
  ),
)
```

If the type, e.g. `BoxDecoration`, is unable to implement its own delta, the delta will instead contain a `value(T value)`
constructor that replaces the value.

```dart
class BoxDecorationDelta with Delta<BoxDecoration> {
  factory BoxDecorationDelta.delta({Color? color, BorderRadius? borderRadius}) = _Delta;

  factory BoxDecorationDelta.value(BoxDecoration value) = _Value;
}
```

Deltas use sentinel values for "no change", so `null` means `null`. Types, such as enums, that cannot implement sentinel 
values, use a function wrapper instead.

```dart
class _Sentinel extends Color {
  const _Sentinel();
}

abstract class FooStyleDelta with Delta<FooStyle> {
  factory FooStyleDelta.delta({Color? background, EdgeInsets? padding, Axis? Function()? axis}) = _Delta;
}

class _Delta implements FooStyleDelta {
  final Color? background;
  final EdgeInsets? padding;
  final Axis? Function()? axis;

  const _Delta({this.background = const _Sentinel(), this.padding, this.axis});
}
```

Usage:

```dart
Foo(
  style: .delta(background: null), // sets background to null
);

Foo(
  style: .delta(), // keeps existing background
);
```

Style deltas will be generated while Flutter type deltas, e.g. `BoxDecoration`, and sentinel values will be manually
implemented.

### Alternatives

We considered a fluent API similar to [Mix](https://www.fluttermix.com/documentation/guides/styling). However, it felt
unidiomatic and not to our tastes. [Small user studies](https://github.com/flutter/flutter/issues/161345#issuecomment-2666390902) 
conducted by Flutter found decorators to have mixed impact on understandability.

The initial design made `Delta` a generic mixin that accepted and returned a type parameter. This prevented styles from
implementing `Delta` while inheriting other styles due to [the diamond problem](https://en.wikipedia.org/wiki/Multiple_inheritance#The_diamond_problem).
Consequently, replacing a style required wrapping it in a `.value(...)` call which unnecessarily verbose. We accept the 
slightly unsafer covariant `Delta` mixin to improve DX.

```dart
mixin Delta<S> {
  S apply(S base);
}

class FooDelta with Delta<Foo> {
  Foo apply(Foo base);
}

class Foo implements FooDelta {
  @override
  Foo apply(Foo base) => this;
}

class BarDelta with Delta<Bar> {
  Bar apply(Bar base);
}

// Compilation error since Bar indirectly implements both Delta<Foo> and Delta<Bar>.
class Bar extends Foo implements BarDelta {
  @override
  Bar apply(Bar base) => this; 
```


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

We propose a **tiered most-specific-wins strategy** to resolve widget states.

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

Instead, only AND (&) and NOT (~) operators are allowed, and specificity is determined by a **multi-tier model**. Each
variant belongs to one of three tiers:

| Tier | Category    | Examples                        |
|------|-------------|---------------------------------|
| 0    | Platform    | `android`, `iOS`, `web`         |
| 1    | Interaction | `hovered`, `focused`, `pressed` |
| 2    | Semantic    | `disabled`, `selected`, `error` |

Higher tiers always take precedence. Specificity is resolved as follows:

1. **Tier-by-tier comparison** (highest to lowest): The constraint with more operands at the highest differing tier wins.
2. **Total operand count** (tiebreaker): If all tiers are equal, more operands wins.
3. **Lexicographic comparison** (final tiebreaker): Operands are sorted alphabetically and compared lexicographically.

This guarantees a deterministic and order-independent resolution.

```
// Tier-based resolution:
disabled                        → tier 2 (1 operand)
hovered & focused & pressed     → tier 1 (3 operands)

→ resolves to disabled (tier 2 > tier 1, regardless of operand count)
```

```
// Tier-2 operand count:
disabled & selected             → tier 2 (2 operands)
disabled & hovered              → tier 2 (1 operand) + tier 1 (1 operand)

→ resolves to disabled & selected (2 tier-2 operands > 1 tier-2 operand)
```

```
// Same-tier tiebreaker (operand count, then lexicographic):
hovered & focused: A(),         → tier 1, count 2
focused & pressed: B(),         → tier 1, count 2

// Sort:
hovered & focused → ["focused", "hovered"]
focused & pressed → ["focused", "pressed"]

// Lexicographic comparison:
[0]: "focused" == "focused" → continue
[1]: "hovered" < "pressed"  → winner

→ resolves to A()
```

OR (|) operators are not allowed as intermixing leads to a worse heuristic with sharp edge cases. Instead, OR expressions
are split into separate constraints with a set of constraints mapping to one value.

```
// Logical OR (not supported):
hovered | pressed: value

// List of constraints (supported):
[hovered, pressed]: value
```

Invalid constraints like `A & ~A` can still be written. As future work, we can introduce an analyzer plugin that flags
invalid and ambiguous constraints.

### Alternatives

We initially considered a **single-tier** model where specificity = total operand. It failed because it could not express
that semantic states (e.g. `disabled`) should always outrank interaction states (e.g. `hovered & focused`). A disabled 
button should always render as disabled even when hovered and focused.

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
    tappableStyle: FVariants(
      FTappableStyle(...), // base
      variants: {
        [.today]: FTappableStyle(...),
        [.today.and(.enclosing)]: FTappableStyle(...),
        [.enclosing]: FTappableStyle(
          decoration: FVariants(
            BoxDecoration(...), // base
            variants: {
              [.hovered.and(.not(.pressed))]: BoxDecoration(...),
            },
          ),
        ),
      },
    ),
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
FTappableStyle(
  padding: FVariants(
    variants: {
      [.ios]: .all(16),
      [.ios.and(.focused)]: .all(20),
      [.android]: .all(12),
    },
  ),
)
```

`touch` and `desktop` shorthands group related platforms. As OR operators are disallowed, we cannot define 
`touch = android | ios | fuchsia`. Instead, we invert the relationship where variants are **compounds** that include their
parent.

```
touch    = touch                    (1 operand)
android  = touch & android          (2 operands)
ios      = touch & ios              (2 operands)
fuchsia  = touch & fuchsia          (2 operands)

desktop  = desktop                  (1 operand)
windows  = desktop & windows        (2 operands)
macOS    = desktop & macOS          (2 operands)
linux    = desktop & linux          (2 operands)
```

When the active platform is `android`, both `{.android}` and `{.touch}` constraints are satisfied. Specificity resolves
correctly since `{.android}` (2 operands) is more specific than `{.touch}` (1 operand).

Lastly, we introduce `FAdaptiveScope` to provide platform variants down the widget tree using `InheritedWidget`, and 
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
    [.hovered, .pressed]: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
    [.any]: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
  }),
);

// Modification
FTappable(
  style: (style) {
    final base = style.decoration.resolve({WidgetState.any})!;
    return style.copyWith(
      decoration: FVariants({
        [.hovered]: base.copyWith(color: Colors.blue),
        [.pressed]: base.copyWith(color: Colors.darkBlue),
        [.any]: base,
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
        [.hovered]: base.copyWith(color: Colors.blue),
        [.pressed]: base.copyWith(color: Colors.darkBlue),
        // Oops!
      }),
    );
  },
)
```

### Proposed Solution

We observe that a base value **is** the default value, and modifications are deltas. Building on `Delta`s in 
[simplifying style modification](#2-simplifying-style-modification), `FVariants` will have `base` field and can be 
created using either mapping to deltas or concrete values.

```dart
class FVariants<K extends FVariantConstraint, V, D extends Delta<V>> {
  final V base;
  final Map<K, V> variants;

  FVariants(this.base, {required Map<List<K>, V> variants});

  FVariants.delta(this.base, {required Map<List<K>, D> variants});

  const FVariants.all(this.base) : variants = const {};
}

// Creation using concrete values
FooStyle(
  spacing: FVariants(
    16,
    variants: {
      [.compact]: 8,
      [.expanded]: 24,
    },
  ),
);

// Creation using deltas
FTappableStyle(
  decoration: FVariants.delta(
    BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    variants: {
      [.hovered, .pressed]: .delta(color: Colors.grey),
      [.disabled]: .value(BoxDecoration(color: Colors.red)),
    },
  ),
);
```

Unlike style deltas, `FVariantsDelta` and `FVariantsValueDelta` use `.apply(...)` instead of `.delta(...)` since typical 
usage is a sequence of operations and order matters (add-then-modify ≠ modify-then-add). 

In general, there are 3 types of operations:
* Adding a new variant.
* Mapping values.
* Removing an existing variant.

```dart
class FVariantsDelta<K extends FVariantConstraint, E extends FVariant, V, D extends Delta<V>>
    with Delta<FVariants<K, V, D>> {
  // Creates a sequence of modifications to [FVariants].
  FVariantsDelta.apply(List<FVariantDeltaOperation<V, T, D>> operations);

  // Creates a complete replacement of a [FVariants].
  FVariantsDelta.value(FVariants<V, T, D> variants);
}

// Delta-based operations.
class FVariantOperation<K extends FVariantConstraint, E extends FVariant, V, D extends Delta<V>> {
  // Adds a new variant
  FVariantOperation.add(Set<K> constraints, D delta);

  // Applies [delta] to the base without modifying existing variants.
  FVariantOperation.onBase(D delta);

  // Applies [delta] to variants whose constraints are satisfied by [variants].
  FVariantOperation.on(Set<E> variants, D delta);

  // Applies [delta] to all variants.
  FVariantOperation.onVariants(D delta);

  // Applies [delta] to all variants and base.
  FVariantOperation.onAll(D delta);

  // Removes variants matching [variants].
  FVariantOperation.remove(Set<E> variants);

  // Removes all variants.
  FVariantOperation.removeAll();
}
```

```dart
class FVariantsValueDelta<K extends FVariantConstraint, E extends FVariant, V> with Delta<FVariants<K, V, Delta<V>>>  {
  // Creates a sequence of modifications to [FVariants].
  FVariantsValueDelta.apply(List<FVariantValueDeltaOperation<K, E, V>> operations);

  // Creates a complete replacement of a [FVariants].
  FVariantsValueDelta.value(FVariants<K, V, Delta<V>> variants);
}

// Concrete value-based operations
class FVariantValueDeltaOperation<K extends FVariantConstraint, E extends FVariant, V>  {
  // Adds a new variant
  FVariantValueDeltaOperation.add(Set<K> constraints, V value);

  // Replaces the base with [base].
  FVariantValueDeltaOperation.onBase(V base);

  // Replaces variants matching [variants] with [value].
  FVariantValueDeltaOperation.on(Set<E> variants, V value);

  // Replaces all variants with [value].
  FVariantValueDeltaOperation.onVariants(V value);

  // Replaces all variants and base with [value].
  FVariantValueDeltaOperation.onAll(V value);

  // Removes variants matching [variants].
  FVariantValueDeltaOperation.remove(Set<E> variants);

  // Removes all variants.
  FVariantValueDeltaOperation.removeAll();
}
```

The `on` and remove` operations use inclusive matching. For example: `.on({.hovered, .focused}, delta)` affects:

```dart
final decoration = FVariants.delta(
  BoxDecoration(color: Colors.white),
  variants: {
    [.hovered]: .delta(color: Colors.blue),                   // ✓ contains hovered
    [.hovered, .pressed]: .delta(color: Colors.darkBlue),     // ✓ contains hovered
    [.focused]: .delta(color: Colors.green),                  // ✓ contains focused
    [.disabled]: .value(BoxDecoration(color: Colors.grey)),   // ✗ contains neither
  },
);
```


With [style deltas](#2-simplifying-style-modification), modifying `FTappable` becomes:

```dart
FTappable(
  // Delta using style delta
  style: .delta(
    // Apply all modifications without needing to extract base variant.
    decoration: .apply([
      .on({.hovered}, .delta(color: Colors.blue)),
      .on({.pressed}, .delta(color: Colors.darkBlue)),
    ]),
  ),
)
```

The `base` field is also the default, eliminating the need for `.any`. This also enables nullable types since
`FVariants.resolve(...)` returns `base` when nothing matches.

Lastly, `FVariants` also provides `apply(...)` and `applyValues(...)` which directly apply operations.

```dart
final updated = variants.apply([
  .onAll(.delta(color: Colors.blue)),
  .add({.disabled}, .delta(color: Colors.grey)),
]);
```


### Alternatives

`FVariantsDelta` and `FVariantsValueDelta` may be overcomplicated. Style deltas could accept a callback, with operations
as methods on `FVariants`.

```dart
FTappable(
  // Delta using style delta
  style: .delta(
    // Callback-based delta
    decoration: (variants) => variants
      .map({.hovered}, .delta(color: Colors.blue))
      .map({.pressed}, .delta(color: Colors.darkBlue)),
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
