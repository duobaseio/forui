# FVariants: Base + Deltas Design

## Problem Statement

When styling widgets, we need a system that:

1. **Reduces verbosity** - Users shouldn't redefine entire styles when only one property changes
2. **Guarantees resolution** - Styles should always resolve to a value, no runtime errors
3. **Maintains explicitness** - Users explicitly map states, no magic composition
4. **Keeps concerns separate** - Style data vs variant logic should be distinct structures
5. **Preserves type safety** - Style classes remain fully non-nullable; no force-casting with `!`

## Core Insight

Most variants share the majority of their properties. It is more common to redefine *part* of a style rather than completely redefine one.

---

## Solution Overview

The solution has three key components:

1. **`Mergeable<S>` interface** - Deltas implement this to apply themselves to a base style
2. **Generated Delta classes** - Two private subclasses exposed via `replace()` and `merge()` factories
3. **`FVariants<V, S, D>`** - Holds base style + variant deltas, implements `Mergeable<S>` operations

---

## The Mergeable Interface

```dart
abstract interface class Mergeable<S> {
  S merge(S base);
}
```

The delta applies itself to the style, producing a new resolved style.

---

## Generated Delta Classes

For each style class, we generate a delta with two factory constructors:

### Pattern

```dart
// ═══════════════════════════════════════════════════════════════════════════
// Style - plain data class, all non-nullable
// ═══════════════════════════════════════════════════════════════════════════
class FTappableStyle {
  final Color backgroundColor;
  final Color borderColor;
  final double elevation;

  const FTappableStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.elevation,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// Delta - abstract, exposes factories
// ═══════════════════════════════════════════════════════════════════════════
abstract class FTappableStyleDelta implements Mergeable<FTappableStyle> {
  /// Escape hatch - completely replace the style, ignore base
  factory FTappableStyleDelta.replace(FTappableStyle style) = _FTappableStyleReplace;

  /// Partial merge - null = inherit from base
  factory FTappableStyleDelta.merge({
    Color? backgroundColor,
    Color? borderColor,
    double? elevation,
  }) = _FTappableStyleMerge;
}

// ═══════════════════════════════════════════════════════════════════════════
// Private: complete replacement
// ═══════════════════════════════════════════════════════════════════════════
class _FTappableStyleReplace implements FTappableStyleDelta {
  final FTappableStyle _style;

  const _FTappableStyleReplace(this._style);

  @override
  FTappableStyle merge(FTappableStyle base) => _style; // base ignored
}

// ═══════════════════════════════════════════════════════════════════════════
// Private: partial merge
// ═══════════════════════════════════════════════════════════════════════════
class _FTappableStyleMerge implements FTappableStyleDelta {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;

  const _FTappableStyleMerge({
    this.backgroundColor,
    this.borderColor,
    this.elevation,
  });

  @override
  FTappableStyle merge(FTappableStyle base) => FTappableStyle(
    backgroundColor: backgroundColor ?? base.backgroundColor,
    borderColor: borderColor ?? base.borderColor,
    elevation: elevation ?? base.elevation,
  );
}
```

### Nested Styles

For styles containing other styles, the delta field type is `Mergeable<T>`, not the concrete delta:

```dart
abstract class FButtonStyleDelta implements Mergeable<FButtonStyle> {
  factory FButtonStyleDelta.merge({
    Mergeable<FTappableStyle>? tappableStyle,  // Mergeable, not FTappableStyleDelta
    Mergeable<FTextStyle>? textStyle,
  }) = _FButtonStyleMerge;
}
```

This allows callers to pass either:
- `FTappableStyleDelta.merge(backgroundColor: Colors.red)` - partial
- `FTappableStyleDelta.replace(entireNewStyle)` - full replacement

Both work because both implement `Mergeable<FTappableStyle>`.

---

## Handling Nullable Style Fields

For fields that are nullable in the style (e.g., `Color? optionalBorder`), we use **sentinel values** with identity comparison to distinguish three states:

1. **Inherit** - sentinel constant (default)
2. **Set to null** - explicitly pass `null`
3. **Set to value** - pass a value

```dart
// Private sentinel
const _inheritColor = Color(0x00000000);

class _FTappableStyleMerge implements FTappableStyleDelta {
  final Color? backgroundColor;           // non-nullable in style
  final Color? optionalBorder;            // nullable in style

  const _FTappableStyleMerge({
    this.backgroundColor,
    this.optionalBorder = _inheritColor,  // sentinel default
  });

  @override
  FTappableStyle merge(FTappableStyle base) => FTappableStyle(
    backgroundColor: backgroundColor ?? base.backgroundColor,
    optionalBorder: identical(optionalBorder, _inheritColor)
        ? base.optionalBorder
        : optionalBorder,  // could be null or a value
  );
}

// Usage:
FTappableStyleDelta.merge()                              // inherit (sentinel default)
FTappableStyleDelta.merge(optionalBorder: null)          // clear to null
FTappableStyleDelta.merge(optionalBorder: Colors.red)    // set value
```

The sentinel's actual value doesn't matter. `identical()` checks object identity, not value equality.

---

## FVariants: Variant-Based Styling

`FVariants` holds a base style and a map of variant deltas.

### Structure

```dart
class FVariants<V extends FVariant, S, D extends Mergeable<S>> {
  final S base;
  final Map<V, D> deltas;

  const FVariants(this.base, this.deltas);

  S resolve(Set<V> active) {
    for (final MapEntry(key: variant, value: delta) in deltas.entries) {
      if (variant.satisfiedBy(active)) {
        return delta.merge(base);
      }
    }
    return base;
  }
}
```

### Modifying FVariants

`FVariants` supports three types of modifications via composable operations:

1. **Transform all/specific variants** - Apply a delta to all or specific variants
2. **Add variants** - Insert new variant entries
3. **Remove variants** - Delete variant entries

```dart
sealed class FVariantsOp<V, S, D extends Mergeable<S>> {
  /// Apply delta to all variants (base + all deltas)
  factory FVariantsOp.transformAll(D delta) = _TransformAll;

  /// Apply delta to specific variants only
  factory FVariantsOp.transform(Set<V> variants, D delta) = _Transform;

  /// Add new variant entries
  factory FVariantsOp.add(Map<V, D> entries) = _Add;

  /// Remove variant entries
  factory FVariantsOp.remove(Set<V> variants) = _Remove;
}
```

Operations compose via a list:

```dart
// Returns Mergeable<FVariants<V, S, D>>
FVariants.modify([
  FVariantsOp.transformAll(FTappableStyleDelta.merge(opacity: 0.9)),
  FVariantsOp.transform({.hovered}, FTappableStyleDelta.merge(backgroundColor: Colors.red)),
  FVariantsOp.add({.focused: FTappableStyleDelta.merge(borderColor: Colors.blue)}),
  FVariantsOp.remove({.disabled}),
])
```

### FVariants in Parent Styles

When a style contains `FVariants`, the delta field type is `Mergeable<FVariants<...>>`:

```dart
abstract class FButtonStyleDelta implements Mergeable<FButtonStyle> {
  factory FButtonStyleDelta.merge({
    Mergeable<FVariants<FTappableVariant, FTappableStyle, FTappableStyleDelta>>? tappable,
  }) = _FButtonStyleMerge;
}

// Usage
FButtonStyleDelta.merge(
  tappable: FVariants.modify([
    FVariantsOp.transformAll(FTappableStyleDelta.merge(opacity: 0.9)),
    FVariantsOp.remove({.disabled}),
  ]),
)

// Or full replace
FButtonStyleDelta.merge(
  tappable: FVariants.replace(entireNewFVariants),
)
```

---

## Before & After: FCalendarStyle

### Before (Current Implementation)

```dart
// ═══════════════════════════════════════════════════════════════════════════
// FCalendarEntryStyle - uses FWidgetStateMap for state-based resolution
// ═══════════════════════════════════════════════════════════════════════════
class FCalendarEntryStyle {
  final FWidgetStateMap<Color> backgroundColor;
  final FWidgetStateMap<Color?> borderColor;
  final FWidgetStateMap<TextStyle> textStyle;
  final Radius radius;

  FCalendarEntryStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.textStyle,
    required this.radius,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// FCalendarDayPickerStyle
// ═══════════════════════════════════════════════════════════════════════════
class FCalendarDayPickerStyle {
  final TextStyle headerTextStyle;
  final FCalendarEntryStyle current;
  final FCalendarEntryStyle enclosing;
  final int? startDayOfWeek;
  final double tileSize;
}

// ═══════════════════════════════════════════════════════════════════════════
// FCalendarStyle
// ═══════════════════════════════════════════════════════════════════════════
class FCalendarStyle {
  final FCalendarHeaderStyle headerStyle;
  final FCalendarDayPickerStyle dayPickerStyle;
  final FCalendarEntryStyle yearMonthPickerStyle;
  final BoxDecoration decoration;
  final EdgeInsetsGeometry padding;
  final Duration pageAnimationDuration;
}

// ═══════════════════════════════════════════════════════════════════════════
// Usage - creating a theme
// ═══════════════════════════════════════════════════════════════════════════
FCalendarDayPickerStyle.inherit(colors: colors, typography: typography)
// Inside inherit():
current: FCalendarEntryStyle(
  backgroundColor: FWidgetStateMap({
    WidgetState.disabled & WidgetState.selected: colors.primaryForeground,
    WidgetState.disabled: colors.background,
    WidgetState.selected: colors.foreground,
    ~WidgetState.selected & (WidgetState.hovered | WidgetState.pressed): colors.secondary,
    WidgetState.any: colors.background,
  }),
  borderColor: FWidgetStateMap({
    WidgetState.disabled & WidgetState.selected & WidgetState.focused: colors.primaryForeground,
    WidgetState.disabled & WidgetState.focused: colors.background,
    WidgetState.focused: colors.foreground,
  }),
  textStyle: FWidgetStateMap({
    WidgetState.disabled: typography.base.copyWith(color: colors.disable(colors.mutedForeground)),
    WidgetState.selected: typography.base.copyWith(color: colors.background),
    WidgetState.any: typography.base.copyWith(color: colors.foreground),
  }),
  radius: Radius.circular(4),
),

// ═══════════════════════════════════════════════════════════════════════════
// Customization - verbose, requires understanding FWidgetStateMap internals
// ═══════════════════════════════════════════════════════════════════════════
FCalendar(
  style: (style) => style.copyWith(
    dayPickerStyle: (dayPicker) => dayPicker.copyWith(
      current: (current) => FCalendarEntryStyle(
        backgroundColor: FWidgetStateMap({
          // Must redefine entire map even to change one state
          WidgetState.disabled & WidgetState.selected: colors.primaryForeground,
          WidgetState.disabled: colors.background,
          WidgetState.selected: Colors.blue,  // <-- the one change we wanted
          ~WidgetState.selected & (WidgetState.hovered | WidgetState.pressed): colors.secondary,
          WidgetState.any: colors.background,
        }),
        borderColor: current.borderColor,
        textStyle: current.textStyle,
        radius: current.radius,
      ),
    ),
  ),
)
```

### After (New Design)

```dart
// ═══════════════════════════════════════════════════════════════════════════
// FCalendarEntryStyle - plain data class, all resolved values
// ═══════════════════════════════════════════════════════════════════════════
class FCalendarEntryStyle {
  final Color backgroundColor;
  final Color? borderColor;
  final TextStyle textStyle;
  final Radius radius;

  const FCalendarEntryStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.textStyle,
    required this.radius,
  });
}

// Generated delta (simplified - actual would have replace/merge factories)
abstract class FCalendarEntryStyleDelta implements Mergeable<FCalendarEntryStyle> {
  factory FCalendarEntryStyleDelta.replace(FCalendarEntryStyle style) = _Replace;
  factory FCalendarEntryStyleDelta.merge({
    Color? backgroundColor,
    Color? borderColor = _inheritColor,  // sentinel for nullable field
    TextStyle? textStyle,
    Radius? radius,
  }) = _Merge;
}

// ═══════════════════════════════════════════════════════════════════════════
// FCalendarDayPickerStyle - contains FVariants for state-based entry styles
// ═══════════════════════════════════════════════════════════════════════════
class FCalendarDayPickerStyle {
  final TextStyle headerTextStyle;
  final FVariants<WidgetState, FCalendarEntryStyle, FCalendarEntryStyleDelta> current;
  final FVariants<WidgetState, FCalendarEntryStyle, FCalendarEntryStyleDelta> enclosing;
  final int? startDayOfWeek;
  final double tileSize;
}

// ═══════════════════════════════════════════════════════════════════════════
// FCalendarStyle - same structure, nested styles use Mergeable
// ═══════════════════════════════════════════════════════════════════════════
class FCalendarStyle {
  final FCalendarHeaderStyle headerStyle;
  final FCalendarDayPickerStyle dayPickerStyle;
  final FCalendarEntryStyle yearMonthPickerStyle;
  final BoxDecoration decoration;
  final EdgeInsetsGeometry padding;
  final Duration pageAnimationDuration;
}

// ═══════════════════════════════════════════════════════════════════════════
// Usage - creating a theme
// ═══════════════════════════════════════════════════════════════════════════
FCalendarDayPickerStyle.inherit(colors: colors, typography: typography)
// Inside inherit():
current: FVariants(
  // Base style - used when no variants match
  FCalendarEntryStyle(
    backgroundColor: colors.background,
    borderColor: null,
    textStyle: typography.base.copyWith(color: colors.foreground),
    radius: Radius.circular(4),
  ),
  // Variant deltas - only specify what changes
  {
    .disabled & .selected: FCalendarEntryStyleDelta.merge(
      backgroundColor: colors.primaryForeground,
    ),
    .disabled: FCalendarEntryStyleDelta.merge(
      textStyle: typography.base.copyWith(color: colors.disable(colors.mutedForeground)),
    ),
    .selected: FCalendarEntryStyleDelta.merge(
      backgroundColor: colors.foreground,
      textStyle: typography.base.copyWith(color: colors.background),
    ),
    .hovered | .pressed: FCalendarEntryStyleDelta.merge(
      backgroundColor: colors.secondary,
    ),
    .focused: FCalendarEntryStyleDelta.merge(
      borderColor: colors.foreground,
    ),
  },
),

// ═══════════════════════════════════════════════════════════════════════════
// Customization - concise, only specify what changes
// ═══════════════════════════════════════════════════════════════════════════
FCalendar(
  style: .merge(
    dayPickerStyle: .merge(
      current: .merge([
        .transform( {.selected}, .merge(backgroundColor: FColors.background)),
      ]),
    ),
  ),
)

// Or transform all variants at once
FCalendar(
  style: FCalendarStyleDelta.merge(
    dayPickerStyle: FCalendarDayPickerStyleDelta.merge(
      current: FVariants.modify([
        FVariantsOp.transformAll(
          FCalendarEntryStyleDelta.merge(radius: Radius.circular(8)),
        ),
      ]),
    ),
  ),
)

// Or add a new variant
FCalendar(
  style: FCalendarStyleDelta.merge(
    dayPickerStyle: FCalendarDayPickerStyleDelta.merge(
      current: FVariants.modify([
        FVariantsOp.add({
          .focused & .selected: FCalendarEntryStyleDelta.merge(
            borderColor: Colors.blue,
            backgroundColor: Colors.blue.shade100,
          ),
        }),
      ]),
    ),
  ),
)
```

---

## Summary of Benefits

| Aspect | Before (FWidgetStateMap) | After (FVariants + Mergeable) |
|--------|--------------------------|-------------------------------|
| Changing one property | Redefine entire state map | Just specify the delta |
| Type safety | Runtime errors possible | Compile-time guarantees |
| Mental model | "Map of states to values" | "Base + deltas" |
| Nested customization | Verbose copyWith chains | Fluent delta composition |
| Adding variants | Recreate entire map | `FVariantsOp.add({...})` |
| Removing variants | Recreate entire map | `FVariantsOp.remove({...})` |
| Transform all states | Manual iteration | `FVariantsOp.transformAll(...)` |

---

## Open Questions / Future Work

1. **Naming** - `Mergeable`, `FVariantsOp`, `modify`, `transformAll` - all need workshopping
2. **Code generation triggers** - What annotation? `@fstyle`?
3. **Lerp support** - How do deltas participate in animations?
4. **Diagnostics** - How do deltas appear in Flutter DevTools?
