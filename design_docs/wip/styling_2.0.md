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

## Order-independent Widget State Resolution

`FWidgetStateMap` currently uses a **first-match-wins strategy** to resolve widget states. 

Given the following constraints:
```dart
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

```dart
// Where should "hovered & selected: C()" go?
{
  hovered: A(),
  hovered & selected & focused: B(),
}
```

For these reasons, `FWidgetStateMap` opts not to provide any insertion methods, forcing developers to redefine the entire 
map when adding new constraints. This is cumbersome and leads to poor DX.

To solve this, we propose a **most-specific-wins strategy** to resolve widget states. 

Re-using the previous example:
```dart
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
hovered & focused & pressed  = 3                                                                                                                                                                                                                                                                                    +                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
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
counts, operands within a constraint are first sorted alphabetically, then constraint are compared lexicographically.
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

