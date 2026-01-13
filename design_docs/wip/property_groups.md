# Property Groups

Author: Matt (Pante)
Status: Inactive

## Problem with Properties
The consistent field naming isn't actually a good idea in practice. I think the popover made that clear, the composing
widget might want a different/more specific name that is better suited to describe its particular usecase, i.e.
popoverAnchor in FPopover becomes menuAnchor in FPopoverMenu & FSelectMenuTile. And because we implement the properties
interface, we will be forced to make the name more generic which isn't great.

The only properties class that have avoided all of these so far is FFormFieldProperties, which I think is an exception
rather than the norm. Even then, we had to remove a few fields such as restorationId (as not all form fields can support
that), and initialValue (form fields with controllers generally do no support that)

So in general, we wanted to group properties tgt and expose a set of them through an interface. But grouping more than
required makes API bloated and surprisingly since not all fields might be supported. Grouping too little makes the
grouping not useful.