import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/tappable/tappable_group.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/foundation/tappable/bounce.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FTappable', {
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
  'selected': (2, 'The semantic variant when this item has been selected.'),
  'primaryFocused': (1, 'The interaction variant when a given widget (and not its descendants) has focus.'),
  'focused': (1, 'The interaction variant when the given widget or any of its descendants have focus.'),
  'hovered': (1, 'The interaction variant when the user drags their mouse cursor over the given widget.'),
  'pressed': (1, 'The interaction variant when the user is actively pressing down on the given widget.'),
})
part 'tappable.design.dart';

/// A callback for when a tappable's variants change.
///
/// See [FTappable.onVariantChange].
typedef FTappableVariantChangeCallback = void Function(Set<FTappableVariant> previous, Set<FTappableVariant> current);

/// An area that responds to touch.
///
/// It is typically used to create other high-level widgets, i.e., [FButton]. Unless you are creating a custom widget,
/// you should use those high-level widgets instead.
class FTappable extends StatefulWidget {
  static Widget _builder(BuildContext _, Set<FTappableVariant> _, Widget? child) => child!;

  /// The style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FTappableStyle(...)
  /// ```
  final FTappableStyleDelta style;

  /// The style used when the tappable is focused. This tappable will not be outlined if null.
  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

  /// Whether to replace all child semantics with this node. Defaults to false.
  final bool excludeSemantics;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@template forui.foundation.FTappable.onHoverChange}
  /// Handler called when the hover changes.
  ///
  /// Called with true if this widget's node gains hover, and false if it loses hover.
  /// {@endtemplate}
  final ValueChanged<bool>? onHoverChange;

  /// {@template forui.foundation.FTappable.onVariantChange}
  /// Handler called when there are any changes to a tappable's [FTappableVariant]s.
  /// {@endtemplate}
  final FTappableVariantChangeCallback? onVariantChange;

  /// True if this tappable is currently selected. Defaults to false.
  final bool selected;

  /// The tappable's hit test behavior. Defaults to [HitTestBehavior.translucent].
  final HitTestBehavior behavior;

  /// {@template forui.foundation.FTappable.onPress}
  /// A callback for when the widget is pressed.
  ///
  /// The widget will be disabled if the following are null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onDoubleTap]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  /// {@endtemplate}
  final VoidCallback? onPress;

  /// {@template forui.foundation.FTappable.onLongPress}
  /// A callback for when the widget is long pressed.
  ///
  /// The widget will be disabled if the following are null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onDoubleTap]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  /// {@endtemplate}
  final VoidCallback? onLongPress;

  /// {@template forui.foundation.FTappable.onDoubleTap}
  /// A callback for when the widget is double tapped.
  ///
  /// The widget will be disabled if the following are null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onDoubleTap]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  /// {@endtemplate}
  final VoidCallback? onDoubleTap;

  /// {@template forui.foundation.FTappable.onSecondaryPress}
  /// A callback for when the widget is pressed with a secondary button (usually right-click on desktop).
  ///
  /// The widget will be disabled if the following are null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onDoubleTap]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  /// {@endtemplate}
  final VoidCallback? onSecondaryPress;

  /// {@template forui.foundation.FTappable.onSecondaryLongPress}
  /// A callback for when the widget is pressed with a secondary button (usually right-click on desktop).
  ///
  /// The widget will be disabled if the following are null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onDoubleTap]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  /// {@endtemplate}
  final VoidCallback? onSecondaryLongPress;

  /// {@template forui.foundation.FTappable.shortcuts}
  /// The shortcuts. Defaults to calling [ActivateIntent] if [onPress] is not null.
  /// {@endtemplate}
  final Map<ShortcutActivator, Intent> shortcuts;

  /// {@template forui.foundation.FTappable.actions}
  /// The actions. Defaults to calling [onPress] when [ActivateIntent] is invoked and [onPress] is not null.
  /// {@endtemplate}
  final Map<Type, Action<Intent>>? actions;

  /// The builder used to create a child with the current variants.
  final ValueWidgetBuilder<Set<FTappableVariant>> builder;

  /// An optional child.
  ///
  /// This can be null if the entire widget subtree the [builder] builds reacts to focus and
  /// hover changes.
  final Widget? child;

  /// Creates an [FTappable].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [builder] and [child] are both null.
  const factory FTappable({
    FTappableStyleDelta style,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    String? semanticsLabel,
    bool excludeSemantics,
    bool autofocus,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    FTappableVariantChangeCallback? onVariantChange,
    bool selected,
    HitTestBehavior behavior,
    VoidCallback? onPress,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    VoidCallback? onSecondaryPress,
    VoidCallback? onSecondaryLongPress,
    Map<ShortcutActivator, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    ValueWidgetBuilder<Set<FTappableVariant>> builder,
    Widget? child,
    Key? key,
  }) = AnimatedTappable;

  /// Creates a [FTappable] without animation.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [builder] and [child] are both null.
  const FTappable.static({
    this.style = const .context(),
    this.focusedOutlineStyle,
    this.semanticsLabel,
    this.excludeSemantics = false,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onVariantChange,
    this.selected = false,
    this.behavior = .translucent,
    this.onPress,
    this.onLongPress,
    this.onDoubleTap,
    this.onSecondaryPress,
    this.onSecondaryLongPress,
    this.actions,
    this.builder = _builder,
    this.child,
    Map<ShortcutActivator, Intent>? shortcuts,
    super.key,
  }) : shortcuts = shortcuts ?? (onPress == null ? const {} : const {SingleActivator(.enter): ActivateIntent()}),
       assert(builder != _builder || child != null, 'Either builder or child must be provided');

  @override
  State<FTappable> createState() => _FTappableState<FTappable>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('excludeSemantics', value: excludeSemantics, ifTrue: 'excludeSemantics'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onVariantChange', onVariantChange))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(EnumProperty('behavior', behavior))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onDoubleTap', onDoubleTap))
      ..add(ObjectFlagProperty.has('onSecondaryPress', onSecondaryPress))
      ..add(ObjectFlagProperty.has('onSecondaryLongPress', onSecondaryLongPress))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(DiagnosticsProperty('actions', actions))
      ..add(ObjectFlagProperty.has('builder', builder));
  }

  bool _animate(int buttons) =>
      (buttons & kPrimaryButton != 0 && (onPress != null || onLongPress != null || onDoubleTap != null)) ||
      (buttons & kSecondaryButton != 0 && (onSecondaryPress != null || onSecondaryLongPress != null));

  bool get _disabled =>
      onPress == null &&
      onLongPress == null &&
      onDoubleTap == null &&
      onSecondaryPress == null &&
      onSecondaryLongPress == null;
}

class _FTappableState<T extends FTappable> extends State<T> {
  late FTappableStyle _style;
  late FocusNode _focus;
  late Set<FTappableVariant> _current;
  int _monotonic = 0;
  int _buttons = 0;
  List<GroupEntry>? _entries;
  GroupEntry? _entry;

  @override
  void initState() {
    super.initState();
    _focus = widget.focusNode ?? .new(debugLabel: 'FTappable');
    _current = {
      if (widget.selected) .selected,
      if (widget.autofocus) ...[.focused, .primaryFocused],
      if (widget._disabled) .disabled,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _style = widget.style(context.theme.tappableStyle);
    // This cast is always fine since extension types are erased at runtime.
    _current.add(context.platformVariant as FTappableVariant);

    final entries = TappableGroupScope.maybeOf(context);
    if (entries != _entries) {
      _unregister();
      _entries = entries;
      _register();
    }
  }

  @override
  void didUpdateWidget(covariant T old) {

    super.didUpdateWidget(old);
    _style = widget.style(context.theme.tappableStyle);
    _update(.selected, widget.selected);
    _update(.disabled, widget._disabled);

    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _focus.dispose();
      }
      _focus = widget.focusNode ?? .new(debugLabel: 'FTappable');
    }

    // Update the existing registration if callbacks changed.
    if (_entry case final entry?) {
      entry
        ..onPress = widget.onPress
        ..onLongPress = widget.onLongPress;
    }
  }

  void _update(FTappableVariant variant, bool add) {
    final current = {..._current};
    if (add ? current.add(variant) : current.remove(variant)) {
      if (widget.onVariantChange case final onVariantChange?) {
        onVariantChange(_current, current);
      }
      _current = current;
    }
  }

  @override
  void dispose() {
    _unregister();
    if (widget.focusNode == null) {
      _focus.dispose();
    }
    super.dispose();
  }

  void _register() {
    if (_entries case final entries?) {
      entries.add(
        _entry = GroupEntry(
          context: context,
          onPressStart: _start,
          onPressCancel: _cancel,
          onPressEnd: _end,
          onPress: widget.onPress,
          onLongPress: widget.onLongPress,
        ),
      );
    }
  }

  void _unregister() {
    if (_entries case final entries?) {
      entries.remove(_entry);
      _entries = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var tappable = _decorate(context, widget.builder(context, _current, widget.child));
    tappable = Shortcuts(
      shortcuts: widget.shortcuts,
      child: Actions(
        actions:
            widget.actions ??
            {
              if (widget.onPress != null)
                ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) => widget.onPress!.call()),
            },
        child: Semantics(
          enabled: !widget._disabled,
          label: widget.semanticsLabel,
          container: true,
          button: true,
          selected: widget.selected,
          excludeSemantics: widget.excludeSemantics,
          child: Focus(
            autofocus: widget.autofocus,
            focusNode: _focus,
            canRequestFocus: !widget._disabled,
            onFocusChange: (focused) {
              setState(() {
                _update(.focused, focused);
                _update(.primaryFocused, _focus.hasPrimaryFocus);
              });
              widget.onFocusChange?.call(focused);
            },
            child: MouseRegion(
              cursor: _style.cursor.resolve(_current),
              onEnter: (_) {
                setState(() => _update(.hovered, true));
                widget.onHoverChange?.call(true);
              },
              onExit: (_) => setState(() {
                _update(.hovered, false);
                widget.onHoverChange?.call(false);
              }),
              // When in a group, the group's gesture recognizer handles primary press/long-press.
              // The Listener and primary GestureDetector callbacks are nullified.
              //
              // We use a separate Listener instead of the GestureDetector in _child as GestureDetectors fight in
              // GestureArena and only 1 GestureDetector will win. This is problematic if this tappable is wrapped in
              // another GestureDetector as onTapDown and onTapUp might absorb EVERY gesture, including drags and pans.
              child: Listener(
                onPointerDown: _entries == null ? (event) => _start(event.buttons) : null,
                onPointerMove: _entries == null
                    ? (event) async {
                        // Avoid unnecessary state updates.
                        if (!_current.contains(FTappableVariant.pressed)) {
                          return;
                        }

                        // The RenderObject should almost always be a [RenderBox] since it is wrapped in a Semantics
                        // which required the child to be a [RenderBox] as well. We use a pattern match anyways just to
                        // be safe.
                        if (context.findRenderObject() case RenderBox(
                          :final size,
                        ) when size.contains(event.localPosition)) {
                          return;
                        }

                        await _cancel();
                      }
                    : null,
                onPointerUp: _entries == null ? (_) => _end() : null,
                child: GestureDetector(
                  behavior: widget.behavior,
                  onTap: _entries == null ? widget.onPress : null,
                  onLongPress: _entries == null ? widget.onLongPress : null,
                  onDoubleTap: widget.onDoubleTap,
                  onSecondaryTap: widget.onSecondaryPress,
                  onSecondaryLongPress: widget.onSecondaryLongPress,
                  child: tappable,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.focusedOutlineStyle case final style?) {
      tappable = FFocusedOutline(focused: _current.contains(FTappableVariant.focused), style: style, child: tappable);
    }

    return tappable;
  }

  Widget _decorate(BuildContext _, Widget child) => child;

  Future<void> _start(int buttons) async {
    final count = ++_monotonic;
    if (widget._animate(_buttons = buttons)) {
      onPressStart();
    }

    await Future.delayed(_style.pressedEnterDuration);
    if (mounted && count == _monotonic && !_current.contains(FTappableVariant.pressed)) {
      setState(() => _update(.pressed, true));
    }
  }

  Future<void> _cancel() async {
    ++_monotonic;
    if (widget._animate(_buttons)) {
      onPressEnd();
    }

    // It does not make sense from a UX perspective to wait for [pressedExitDuration] before
    // updating state if the user drags their pointer outside of the tappable.
    setState(() => _update(.pressed, false));
  }

  Future<void> _end() async {
    final count = ++_monotonic;
    if (widget._animate(_buttons)) {
      onPressEnd();
    }

    await Future.delayed(_style.pressedExitDuration);
    if (mounted && count == _monotonic && _current.contains(FTappableVariant.pressed)) {
      setState(() => _update(.pressed, false));
    }
  }

  void onPressStart() {}

  void onPressEnd() {}
}

@internal
class AnimatedTappable extends FTappable {
  const AnimatedTappable({
    super.style,
    super.focusedOutlineStyle,
    super.semanticsLabel,
    super.excludeSemantics,
    super.autofocus,
    super.focusNode,
    super.onFocusChange,
    super.onHoverChange,
    super.onVariantChange,
    super.selected,
    super.behavior,
    super.onPress,
    super.onLongPress,
    super.onDoubleTap,
    super.onSecondaryPress,
    super.onSecondaryLongPress,
    super.shortcuts,
    super.actions,
    super.builder,
    super.child,
    super.key,
  }) : super.static();

  @override
  State<FTappable> createState() => AnimatedTappableState();
}

@internal
class AnimatedTappableState extends _FTappableState<AnimatedTappable> with SingleTickerProviderStateMixin {
  @visibleForTesting
  late Animation<double> bounce;

  FTappableMotion? _motion;
  late final AnimationController _bounceController = AnimationController(vsync: this);
  late final CurvedAnimation _curvedBounce = CurvedAnimation(parent: _bounceController, curve: Curves.linear);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setupBounceAnimation();
  }

  @override
  void didUpdateWidget(covariant AnimatedTappable old) {
    super.didUpdateWidget(old);
    _setupBounceAnimation();
  }

  void _setupBounceAnimation() {
    final motion = _style.motion;
    if (_motion != motion) {
      _motion = motion;
      _bounceController
        ..duration = motion.bounceDownDuration
        ..reverseDuration = motion.bounceUpDuration;
      _curvedBounce
        ..curve = motion.bounceDownCurve
        ..reverseCurve = motion.bounceUpCurve;
      bounce = motion.bounceTween.animate(_curvedBounce);
    }
  }

  @override
  void dispose() {
    _curvedBounce.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget _decorate(BuildContext _, Widget child) =>
      Bounce(bounce: bounce, bounceFloor: _style.motion.bounceFloor, child: child);

  @override
  void onPressStart() {
    // Check if it's mounted due to a non-deterministic race condition, https://github.com/duobaseio/forui/issues/482.
    if (mounted) {
      _bounceController.forward();
    }
  }

  @override
  void onPressEnd() {
    // Check if it's mounted due to a non-deterministic race condition, https://github.com/duobaseio/forui/issues/482.
    if (mounted) {
      _bounceController.reverse();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('bounce', bounce));
  }
}

/// A [FTappable]'s style.
class FTappableStyle with Diagnosticable, _$FTappableStyleFunctions {
  /// The mouse cursor for mouse pointers that are hovering over the region. Defaults to [MouseCursor.defer].
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, MouseCursor, Delta> cursor;

  /// The duration to wait before applying the pressed effect after the user presses the tile. Defaults to 200ms.
  @override
  final Duration pressedEnterDuration;

  /// The duration to wait before removing the pressed effect after the user stops pressing the tile. Defaults to 0s.
  @override
  final Duration pressedExitDuration;

  /// Motion-related properties for the tappable.
  ///
  /// Set this to [FTappableMotion.none] to disable the bounce effect.
  @override
  final FTappableMotion motion;

  /// Creates a [FTappableStyle].
  FTappableStyle({
    this.cursor = const .all(.defer),
    this.pressedEnterDuration = const Duration(milliseconds: 200),
    this.pressedExitDuration = .zero,
    this.motion = const FTappableMotion(),
  });
}

/// Motion-related properties for [FTappable].
class FTappableMotion with Diagnosticable, _$FTappableMotionFunctions {
  /// A [FTappableMotion] with no motion effects.
  static const FTappableMotion none = .new(bounceTween: noBounceTween);

  /// The default bounce tween used by [FTappableStyle]. It scales the widget down to 0.97 on tap down and back to 1.0
  /// on tap up.
  static const FImmutableTween<double> defaultBounceTween = .new(begin: 1.0, end: 0.97);

  /// A tween that does not animate the scale of the tappable. It is used to disable the bounce effect.
  static const FImmutableTween<double> noBounceTween = .new(begin: 1.0, end: 1.0);

  /// The bounce animation's duration when the tappable is pressed down. Defaults to 100ms.
  @override
  final Duration bounceDownDuration;

  /// The bounce animation's duration when the tappable is released (up). Defaults to 120ms.
  @override
  final Duration bounceUpDuration;

  /// The curve used to animate the scale of the tappable when pressed (down). Defaults to [Curves.easeOutQuart].
  @override
  final Curve bounceDownCurve;

  /// The curve used to animate the scale of the tappable when released (up). Defaults to [Curves.easeOutCubic].
  @override
  final Curve bounceUpCurve;

  /// The bounce's tween. Defaults to [defaultBounceTween].
  ///
  /// Set to [noBounceTween] to disable the bounce effect.
  @override
  final Animatable<double> bounceTween;

  /// The maximum number of pixels that the tappable can shrink during the bounce animation regardless of widget size.
  /// Defaults to 5.
  ///
  /// This prevents large widgets from shrinking too much. For example, with the default [bounceFloor]:
  /// * A 100px widget would shrink to 97px (3% shrink)
  /// * A 500px widget would shrink to 495px (1% shrink)
  @override
  final double? bounceFloor;

  /// Creates a [FTappableMotion].
  const FTappableMotion({
    this.bounceDownDuration = const Duration(milliseconds: 100),
    this.bounceUpDuration = const Duration(milliseconds: 120),
    this.bounceDownCurve = Curves.easeOutQuart,
    this.bounceUpCurve = Curves.easeOutCubic,
    this.bounceTween = defaultBounceTween,
    this.bounceFloor = 5,
  });
}
