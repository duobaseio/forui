# Variant API Design Discussion

## Problem Statement

When styling widgets, we need a constraint system that allows expressing conditions like "hovered button inside today's calendar cell". This requires:

1. **Discoverability** - Users should know what constraints are valid for a given widget context
2. **Type compatibility** - States from different widget scopes should compose naturally
3. **Cross-boundary styling** - Combining constraints from parent and child widget scopes

### The Core Tension

| Approach                  | Discoverability | Type Compatibility | Cross-Boundary |
|---------------------------|-----------------|--------------------|----------------|
| Shared single type        | ❌               | ✅                  | ✅              |
| Separate types per widget | ✅               | ❌                  | ❌              |

## Proposed Solution: Extension Types over FVariant

```dart
sealed class FVariant {
  const factory FVariant(String label) = _Value;

  FVariant operator &(FVariant other) => _And(this, other);
  FVariant operator |(FVariant other) => _Or(this, other);
  FVariant operator ~() => _Not(this);
}

extension type const FTappableVariant(FVariant variant) implements FVariant {
  static const hovered = FTappableVariant(FVariant('hovered'));
  static const pressed = FTappableVariant(FVariant('pressed'));
  // ...
}

extension type const FCalendarVariant(FVariant variant) implements FVariant {
  static const today = FCalendarVariant(FVariant('today'));
  static const enclosing = FCalendarVariant(FVariant('enclosing'));
  // ...
}

// Composite type for cross-boundary styling
extension type const FCalendarTappableVariant(FVariant variant)
    implements FCalendarVariant, FTappableVariant {
  // Re-exported from parents
  static const hovered = FCalendarTappableVariant(FTappableVariant.hovered);
  static const today = FCalendarTappableVariant(FCalendarVariant.today);
  // ...
}
```

This provides:
- **Discoverability**: Autocomplete on `FCalendarTappableVariant.` shows all valid variants
- **Type compatibility**: All extension types wrap `FVariant`, operators compose freely
- **Cross-boundary**: Composite types implement multiple parent types

## Open Question: Operators vs Methods

Two approaches for combining variants:

### Option A: Bitwise Operators

```dart
extension type const FTappableVariant(FVariant variant) implements FVariant {
  FTappableVariant operator &(FVariant other) => .new(_And(this, other));
  FTappableVariant operator |(FVariant other) => .new(_Or(this, other));
  FTappableVariant operator ~() => .new(_Not(this));
}
```

**Usage:**
```dart
FVariantMap<FCalendarTappableVariant, Color>({
  ~FCalendarTappableVariant.pressed & ~FTappableVariant.hovered: Colors.transparent,
  FCalendarTappableVariant.hovered & FCalendarVariant.today: Colors.blue,
  FTappableVariant.pressed: Colors.grey,
})
```

### Option B: Named Methods

```dart
extension type const FTappableVariant(FVariant variant) implements FVariant {
  FTappableVariant and(FTappableVariant other) => .new(_And(this, other));
  FTappableVariant or(FTappableVariant other) => .new(_Or(this, other));
  static FTappableVariant not(FTappableVariant v) => .new(_Not(v));
}
```

**Usage (with dot shorthand):**
```dart
FVariantMap<FCalendarTappableVariant, Color>({
  .not(.pressed).and(.not(.hovered)): Colors.transparent,
  .hovered.and(.today): Colors.blue,
  .pressed: Colors.grey,
})
```

## Tradeoff Analysis

### Syntax Comparison

| Expression | Operators | Methods |
|------------|-----------|---------|
| Negation | `~FType.pressed` | `.not(.pressed)` |
| AND | `FType.a & FType.b` | `.a.and(.b)` |
| OR | `FType.a \| FType.b` | `.a.or(.b)` |
| Complex | `~FType.a & ~FType.b` | `.not(.a).and(.not(.b))` |

### Redeclaration Requirements

**Operators:**
- Composite types must redeclare operators (to resolve conflict from multiple `implements`)
- Static consts can optionally be reused from parent types
- Can mix parent type consts in expressions: `FCalendarTappableVariant.today & FTappableVariant.hovered`

**Methods:**
- Composite types must redeclare methods (to resolve conflict)
- Static consts MUST be re-exported for dot shorthand to work
- Cannot mix: `.today.and(.hovered)` requires both consts on the same type

### Flexibility

**Operators allow mixing types:**
```dart
// This works - FTappableVariant.hovered is FVariant, accepted by & operator
~FCalendarTappableVariant.today & ~FTappableVariant.hovered
```

**Methods require same-type context:**
```dart
// Dot shorthand requires all consts on FCalendarTappableVariant
.not(.today).and(.not(.hovered))
```

### Redeclaration Count (for composite type with 5 parent variants)

| | Static Consts | Operations | Total |
|---|---|---|---|
| **Operators** | 0-5 (optional) | 3 | 3-8 |
| **Methods** | 5 (required) | 3 | 8 |

## Additional Considerations

### No Compile-Time Validation

Neither approach prevents using invalid variants in the wrong context:

```dart
// Compiles but never matches - FAccordionVariant.open in calendar context
FVariantMap<FCalendarTappableVariant, Color>({
  FAccordionVariant.open: Colors.red,  // No error, just never matches
})
```

This could be addressed with:
- Analyzer plugin warnings
- Runtime debug assertions

### Verbosity vs Readability

Operators are more verbose but have familiar structure:
- Prefix `~` for negation
- Infix `&`/`|` with precedence
- Reads left-to-right

Methods have dot shorthand but nest awkwardly:
- `.not(.x)` wraps instead of prefixes
- Complex expressions become deeply nested
- Reads inside-out for negations

### Who Creates Composite Types?

- **Library authors**: Create composite types for their widgets
- **Library consumers**: Use pre-defined types, rarely create new ones
- **Extension library authors**: May create composites for their custom widgets

If only library authors create composites, the boilerplate is contained and codegen can handle it.
