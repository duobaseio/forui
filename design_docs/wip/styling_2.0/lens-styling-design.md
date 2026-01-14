# Lens-Based Styling API Design

## Problem Statement

The current `FWidgetStateMap` API has two core issues:

### 1. Opacity / Discoverability

Shipped default styles are opaque. Users cannot tell at a glance what states are mapped without digging into source code.

```dart
// What states does this contain? Have to inspect source.
final style = FButtonStyle.outline(colors, style, typography);
```

Contrast with explicit fields where autocomplete reveals structure:

```dart
FButtonStyle(
  disabled: ...,
  hovered: ...,
  pressed: ...,
)
```

But explicit fields don't scale—combination explosion with multiple states.

### 2. Modification Ergonomics

Existing styles are hard to modify. Common operations are clunky:

- Replace a specific state's value
- Add a new state
- Remove an existing state
- Change a property across all states

Deep modifications are especially painful:

```dart
// Current: verbose nested copyWith
style.copyWith(
  content: style.content.replaceFirstWhere({hovered}, (c) => c.copyWith(
    iconStyle: c.iconStyle.copyWith(
      badgeStyle: c.iconStyle.badgeStyle.copyWith(
        color: red,
      ),
    ),
  )),
)
```

## Design Decisions

### Separate Read and Write APIs

**Decision:** Keep property access for reading, introduce lenses for writing.

**Rationale:** Reading is the common case and should remain simple. Writing needs path information for rebuilding, which lenses provide naturally.

```dart
// Read: direct property access (unchanged)
style.decoration
style.content.iconStyle.badgeStyle.color

// Write: lens path
style.modify(FButtonStyle.lens.decoration[hovered], (dec) => dec.copyWith(...))
```

### Lens Structure

**Decision:** Use a nested record namespace accessed via `ClassName.lens`.

**Rationale:** Clean single entry point, autocomplete guides discovery.

```dart
augment class FButtonStyle {
  static final lens = (
    decoration: Lens<FButtonStyle, FVariantMap<BoxDecoration>>(...),
    content: Lens<FButtonStyle, FVariantMap<FButtonContentStyle>>(...),
  );
}

// Usage
FButtonStyle.lens.decoration
FButtonStyle.lens.content
```

### Lens Implementation

```dart
class Lens<S, T> {
  final T Function(S) get;
  final S Function(S, T) set;
  
  const Lens({required this.get, required this.set});
  
  // Compose with another lens
  Lens<S, U> then<U>(Lens<T, U> other) => Lens(
    get: (s) => other.get(get(s)),
    set: (s, u) => set(s, other.set(get(s), u)),
  );
}
```

### Variant Map Indexing

**Decision:** Lenses on `FVariantMap<T>` support indexing by variant constraint.

```dart
extension VariantMapLens<S, T> on Lens<S, FVariantMap<T>> {
  Lens<S, T> operator [](Variant v) => Lens(
    get: (s) => get(s)[v],
    set: (s, t) => set(s, get(s).with(v, t)),
  );
}
```

Enables:

```dart
FButtonStyle.lens.decoration[hovered]  // Lens<FButtonStyle, BoxDecoration>
```

### Chaining Through Nested Styles

**Decision:** Generate extensions that forward to child lenses.

```dart
extension on Lens<FButtonStyle, FButtonContentStyle> {
  Lens<FButtonStyle, FButtonIconStyle> get iconStyle =>
    then(FButtonContentStyle.lens.iconStyle);
}
```

Enables deep paths:

```dart
FButtonStyle.lens.content[hovered].iconStyle.badgeStyle.color
```

### Modify API

**Decision:** `modify` method on style classes accepts a lens and transform function.

```dart
augment class FButtonStyle {
  FButtonStyle modify<T>(Lens<FButtonStyle, T> lens, T Function(T) transform) {
    return lens.set(this, transform(lens.get(this)));
  }
}
```

Usage:

```dart
style.modify(FButtonStyle.lens.decoration[hovered], (dec) => dec.copyWith(color: blue))
```

### Batch Modifications

**Decision:** `modify` accepts a list of modifications for single-rebuild batching.

```dart
style.modify([
  FButtonStyle.lens.decoration[hovered]((dec) => dec.copyWith(color: blue)),
  FButtonStyle.lens.content[hovered]((c) => c.copyWith(padding: EdgeInsets.zero)),
])
```

Each lens call with a transform returns a `Modification<FButtonStyle>`, keeping type safety while allowing homogeneous lists.

## Code Generation

### Trigger

Classes annotated with `@styleable` get augmentations generated.

### Generated Output

For each `@styleable` class:

1. Static `lens` record with a `Lens` per field
2. `modify` method
3. Extensions for chaining to child lenses (for fields whose types are also `@styleable`)

### Example

Source:

```dart
@styleable
class FButtonStyle {
  final FVariantMap<BoxDecoration> decoration;
  final FVariantMap<FButtonContentStyle> content;
  
  FButtonStyle({required this.decoration, required this.content});
  
  FButtonStyle copyWith({
    FVariantMap<BoxDecoration>? decoration,
    FVariantMap<FButtonContentStyle>? content,
  }) => ...;
}
```

Generated:

```dart
augment class FButtonStyle {
  static final lens = (
    decoration: Lens<FButtonStyle, FVariantMap<BoxDecoration>>(
      get: (s) => s.decoration,
      set: (s, v) => s.copyWith(decoration: v),
    ),
    content: Lens<FButtonStyle, FVariantMap<FButtonContentStyle>>(
      get: (s) => s.content,
      set: (s, v) => s.copyWith(content: v),
    ),
  );
  
  FButtonStyle modify<T>(Lens<FButtonStyle, T> lens, T Function(T) transform) {
    return lens.set(this, transform(lens.get(this)));
  }
}

extension FButtonStyleContentLensExt on Lens<FButtonStyle, FButtonContentStyle> {
  Lens<FButtonStyle, FButtonIconStyle> get iconStyle =>
    then(FButtonContentStyle.lens.iconStyle);
  // ... other FButtonContentStyle fields
}
```

## Usage Examples

### Simple modification

```dart
style.modify(FButtonStyle.lens.decoration[hovered], (dec) => dec.copyWith(color: blue))
```

### Deep modification

```dart
style.modify(
  FButtonStyle.lens.content[hovered].iconStyle.badgeStyle,
  (badge) => badge.copyWith(color: red),
)
```

### Batch modification

```dart
style.modify([
  FButtonStyle.lens.decoration[hovered]((dec) => dec.copyWith(color: blue)),
  FButtonStyle.lens.decoration[disabled]((dec) => dec.copyWith(border: none)),
  FButtonStyle.lens.content[hovered]((c) => c.copyWith(padding: p)),
])
```

### Discovering available states

Autocomplete on `FButtonStyle.lens.` shows all styleable properties.
Autocomplete after `[` shows available variants.

## Tradeoffs

### Pros

- Solves both discoverability and modification ergonomics
- Type-safe paths
- Single rebuild for deep changes
- Batch modifications possible
- Familiar pattern (lenses/optics exist in other ecosystems)

### Cons

- Requires code generation
- Depends on Dart augmentations (experimental)
- New concept for users to learn
- Additional API surface

## Dependencies

- Dart augmentations (experimental feature)
- Build runner / code generation setup

## Open Questions

- Exact batch modification API shape
- Error handling for invalid variant keys
- Integration with unified variant system (separate design doc)
