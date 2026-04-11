import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';

@SentinelValues(FPopoverStyle, {
  'barrierFilter': 'Sentinels.imageFilterFunction',
  'backgroundFilter': 'Sentinels.imageFilterFunction',
})
part 'popover.design.dart';

/// Motion-related properties for [FPopover].
class FPopoverMotion with Diagnosticable, _$FPopoverMotionFunctions {
  /// A [FPopoverMotion] with no motion effects.
  static const FPopoverMotion none = .new(
    scaleTween: FImmutableTween(begin: 1, end: 1),
    fadeTween: FImmutableTween(begin: 1, end: 1),
  );

  /// The popover's entrance duration. Defaults to 120ms.
  @override
  final Duration entranceDuration;

  /// The popover's exit duration. Defaults to 100ms.
  @override
  final Duration exitDuration;

  /// The curve used for the popover's expansion animation when entering. Defaults to [Curves.easeOutCubic].
  @override
  final Curve expandCurve;

  /// The curve used for the popover's collapse animation when exiting. Defaults to [Curves.easeInCubic].
  @override
  final Curve collapseCurve;

  /// The curve used for the popover's fade-in animation when entering. Defaults to [Curves.linear].
  @override
  final Curve fadeInCurve;

  /// The curve used for the popover's fade-out animation when exiting. Defaults to [Curves.linear].
  @override
  final Curve fadeOutCurve;

  /// The popover's scale tween. Defaults to a tween from 0.93 to 1.
  @override
  final Animatable<double> scaleTween;

  /// The popover's fade tween. Defaults to a tween from 0 to 1.
  @override
  final Animatable<double> fadeTween;

  /// Creates a [FPopoverMotion].
  const FPopoverMotion({
    this.entranceDuration = const Duration(milliseconds: 100),
    this.exitDuration = const Duration(milliseconds: 100),
    this.expandCurve = Curves.easeOutCubic,
    this.collapseCurve = Curves.easeInCubic,
    this.fadeInCurve = Curves.linear,
    this.fadeOutCurve = Curves.linear,
    this.scaleTween = const FImmutableTween(begin: 0.93, end: 1),
    this.fadeTween = const FImmutableTween(begin: 0, end: 1),
  });
}

/// The regions that can be tapped to hide a popover.
enum FPopoverHideRegion {
  /// Tapping anywhere outside the popover (including the child widget) will hide the popover.
  ///
  /// Use this when the child does not toggle the popover itself, such as when the child is a static element or label.
  anywhere,

  /// The entire screen, excluding the child and popover.
  ///
  /// Use this when the child toggles the popover, such as when the child is a button or interactive element.
  excludeChild,

  /// Disables tapping outside of the popover to hide it.
  ///
  /// Use this when you want the popover to only be dismissed programmatically, such as via a close button inside the
  /// popover or a controller.
  none,
}

/// A popover displays rich content in a portal that is aligned to a child.
///
/// ### Nested Popovers
///
/// When placing widgets that use popovers internally, e.g. `FSelect` inside a `FPopover`, the outer popover will close
/// when interacting with the inner widget's dropdown. This happens because the inner dropdown is rendered in a separate
/// overlay layer, so tapping it is considered "outside" the outer popover.
///
/// To prevent this, share the same [groupId] between the outer `FPopover` and the inner widget. Widgets with the same
/// `groupId` are treated as part of the same tap region.
///
/// See:
/// * https://forui.dev/docs/overlay/popover for working examples.
/// * [FPopoverController] for controlling a popover.
/// * [FPopoverStyle] for customizing a popover's appearance.
class FPopover extends StatefulWidget {
  /// The default builder that returns the child as-is.
  static Widget defaultBuilder(BuildContext _, FPopoverController _, Widget? child) => child!;

  /// The default popover builder that returns the content as-is.
  static Widget defaultPopoverBuilder(BuildContext _, Object _, FPopoverController _, Widget child) => child;

  /// Defines how the popover's shown state is controlled.
  ///
  /// Defaults to [FPopoverControl.managed] which creates an internal [FPopoverController].
  final FPopoverControl control;

  /// The popover's style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FPopoverStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create popover
  /// ```
  final FPopoverStyleDelta style;

  /// The popover's size constraints.
  final FPortalConstraints constraints;

  /// {@template forui.widgets.FPopover.popoverAnchor}
  /// The anchor point on the popover used for positioning relative to the [childAnchor].
  ///
  /// For example, with `popoverAnchor: Alignment.topCenter` and `childAnchor: Alignment.bottomCenter`,
  /// the popover's top edge will align with the child's bottom edge.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.bottomCenter] on Android, iOS and Fuchsia, and [Alignment.topCenter] on all other platforms.
  /// To change the platform variant, update the enclosing [FTheme.platform]/[FAdaptiveScope.platform].
  final AlignmentGeometry? popoverAnchor;

  /// {@template forui.widgets.FPopover.childAnchor}
  /// The anchor point on the [child] used for positioning relative to the popover's anchor.
  ///
  /// For example, with `childAnchor: .bottomCenter` and `popoverAnchor: .topCenter`,
  /// the child's bottom edge will align with the popover's top edge.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.topCenter] on Android and iOS, and [Alignment.bottomCenter] on all other platforms.
  ///  To change the platform variant, update the enclosing [FTheme.platform]/[FAdaptiveScope.platform].
  final AlignmentGeometry? childAnchor;

  /// {@template forui.widgets.FPopover.spacing}
  /// The spacing between the popover and child anchors.
  ///
  /// Applied before `overflow`.
  /// {@endtemplate}
  ///
  /// Defaults to `FPortalSpacing(4)`.
  final FPortalSpacing spacing;

  /// {@template forui.widgets.FPopover.overflow}
  /// The callback used to shift a popover when it overflows out of the viewport.
  ///
  /// Applied after `spacing` and before `offset`.
  ///
  /// See [FPortalOverflow] for the different overflow strategies.
  /// {@endtemplate}
  ///
  /// Defaults to [FPortalOverflow.flip].
  final FPortalOverflow overflow;

  /// {@macro forui.foundation.FPortal.useViewPadding}
  ///
  /// Defaults to true.
  final bool useViewPadding;

  /// {@macro forui.foundation.FPortal.useViewInsets}
  ///
  /// Defaults to true.
  final bool useViewInsets;

  /// {@template forui.widgets.FPopover.offset}
  /// Additional translation to apply to the popover's position.
  ///
  /// Applied after `overflow`.
  /// {@endtemplate}
  ///
  /// Defaults to [Offset.zero].
  final Offset offset;

  /// {@template forui.widgets.FPopover.groupId}
  /// An optional group ID that groups [TapRegion]s together so that they operate as one region. If a tap occurs outside
  /// of all group members, then group members that are shown will be hidden.
  ///
  /// If the group id is null, then only this region is hit tested.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the group id is not null and `hideRegion` is not set to
  /// [FPopoverHideRegion.excludeChild].
  /// {@endtemplate}
  final Object? groupId;

  /// {@template forui.widgets.FPopover.hideRegion}
  /// The region that can be tapped to hide the popover.
  /// {@endtemplate}
  ///
  /// Defaults to [FPopoverHideRegion.excludeChild].
  final FPopoverHideRegion hideRegion;

  /// {@template forui.widgets.FPopover.onTapHide}
  /// A callback that is called when the popover is hidden by tapping outside of it.
  /// {@endtemplate}
  ///
  /// This is only called if [hideRegion] is set to [FPopoverHideRegion.anywhere] or [FPopoverHideRegion.excludeChild].
  final VoidCallback? onTapHide;

  /// {@macro forui.foundation.doc_templates.autofocus}
  ///
  /// Auto-focuses if [autofocus] is null and a barrier is provided.
  final bool? autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusScopeNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@template forui.widgets.FPopover.traversalEdgeBehavior}
  /// Controls the transfer of focus beyond the first and the last items in a popover. Defaults to
  /// [TraversalEdgeBehavior.closedLoop].
  ///
  /// ## Contract
  /// Throws [AssertionError] if both `focusNode` and `traversalEdgeBehavior` are not null.
  /// {@endtemplate}
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// {@template forui.widgets.FPopover.barrierSemanticsLabel}
  /// The popover's barrier label used by accessibility frameworks.
  ///
  /// Ignored if no barrier is provided.
  /// {@endtemplate}
  final String? barrierSemanticsLabel;

  /// {@template forui.widgets.FPopover.barrierSemanticsDismissible}
  /// Whether the barrier semantics are included in the semantics tree. Defaults to true.
  ///
  /// Ignored if no barrier is provided.
  /// {@endtemplate}
  final bool barrierSemanticsDismissible;

  /// {@template forui.widgets.FPopover.cutout}
  /// Whether the barrier should exclude the `builder`/`child`'s area using a non-interactive cutout.
  ///
  /// Does nothing if [FPopoverStyle.barrierFilter] is null.
  ///
  /// Defaults to true.
  /// {@endtemplate}
  final bool cutout;

  /// {@template forui.widgets.FPopover.cutoutBuilder}
  /// An optional callback that customizes the cutout shape.
  ///
  /// Does nothing if `cutout` is false or [FPopoverStyle.barrierFilter] is null.
  /// Defaults to [FModalBarrier.defaultCutoutBuilder] which adds a plain rectangle matching the `cutout`'s bounds.
  ///
  /// To add a circular cutout:
  /// ```dart
  /// cutoutBuilder: (path, bounds) => path.addOval(bounds.deflate(3)),
  /// ```
  /// {@endtemplate}
  final void Function(Path path, Rect bounds) cutoutBuilder;

  /// The popover's semantic label used by accessibility frameworks.
  final String? semanticsLabel;

  /// The shortcuts and the associated actions.
  ///
  /// Defaults to closing the popover when the escape key is pressed.
  final Map<ShortcutActivator, VoidCallback>? shortcuts;

  /// The popover builder.
  final Widget Function(BuildContext context, FPopoverController controller) popoverBuilder;

  /// {@template forui.widgets.FPopover.builder}
  /// An optional builder which returns the child widget that the popover is aligned to.
  ///
  /// Can incorporate a value-independent widget subtree from the [child] into the returned widget tree.
  ///
  /// This can be null if the entire widget subtree the [builder] builds does not require the controller.
  /// {@endtemplate}
  final ValueWidgetBuilder<FPopoverController> builder;

  /// The child which the popover is aligned to.
  final Widget? child;

  /// Creates a popover that only shows the popover when the controller is manually toggled.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if:
  /// * [groupId] is not null and [hideRegion] is not set to [FPopoverHideRegion.excludeChild].
  /// * neither [builder] nor [child] is provided.
  const FPopover({
    required this.popoverBuilder,
    this.control = const .managed(),
    this.style = const .context(),
    this.constraints = const FPortalConstraints(),
    this.spacing = const .spacing(4),
    this.overflow = .flip,
    this.useViewPadding = true,
    this.useViewInsets = true,
    this.offset = .zero,
    this.groupId,
    this.hideRegion = .excludeChild,
    this.onTapHide,
    this.autofocus,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior,
    this.barrierSemanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.cutout = true,
    this.cutoutBuilder = FModalBarrier.defaultCutoutBuilder,
    this.semanticsLabel,
    this.shortcuts,
    this.builder = defaultBuilder,
    this.child,
    this.popoverAnchor,
    this.childAnchor,
    super.key,
  }) : assert(
         groupId == null || hideRegion == FPopoverHideRegion.excludeChild,
         'groupId can only be used with FPopoverHideRegion.excludeChild',
       ),
       assert(
         focusNode == null || traversalEdgeBehavior == null,
         'Cannot provide both focusNode and traversalEdgeBehavior',
       ),
       assert(builder != defaultBuilder || child != null, 'Either builder or child must be provided');

  @override
  State<FPopover> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('popoverAnchor', popoverAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(StringProperty('barrierSemanticsLabel', barrierSemanticsLabel))
      ..add(
        FlagProperty(
          'barrierSemanticsDismissible',
          value: barrierSemanticsDismissible,
          ifTrue: 'barrier semantics dismissible',
        ),
      )
      ..add(FlagProperty('cutout', value: cutout, ifTrue: 'cutout'))
      ..add(ObjectFlagProperty.has('cutoutBuilder', cutoutBuilder))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(EnumProperty('traversalEdgeBehavior', traversalEdgeBehavior))
      ..add(FlagProperty('useViewPadding', value: useViewPadding, ifTrue: 'using view padding'))
      ..add(FlagProperty('useViewInsets', value: useViewInsets, ifTrue: 'using view insets'))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(ObjectFlagProperty.has('popoverBuilder', popoverBuilder))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _State extends State<FPopover> with TickerProviderStateMixin {
  late Object? _groupId = widget.groupId ?? UniqueKey();
  late FPopoverController _controller;
  FocusScopeNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleOnChange, this);
    _focusNode =
        widget.focusNode ??
        .new(debugLabel: 'FPopover', traversalEdgeBehavior: widget.traversalEdgeBehavior ?? .closedLoop);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.updateMotion(widget.style(context.theme.popoverStyle).motion);
  }

  @override
  void didUpdateWidget(covariant FPopover old) {
    super.didUpdateWidget(old);
    if (widget.groupId != old.groupId) {
      _groupId = widget.groupId ?? UniqueKey();
    }

    if (widget.focusNode != old.focusNode || widget.traversalEdgeBehavior != old.traversalEdgeBehavior) {
      if (old.focusNode == null) {
        _focusNode?.dispose();
      }

      _focusNode =
          widget.focusNode ??
          .new(debugLabel: 'FPopover', traversalEdgeBehavior: widget.traversalEdgeBehavior ?? .closedLoop);
    }

    _controller = widget.control.update(old.control, _controller, _handleOnChange, this).$1;
    _controller.updateMotion(widget.style(context.theme.popoverStyle).motion);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }

    widget.control.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.control case FPopoverManagedControl(:final onChange?)) {
      onChange(_controller.status.isForwardOrCompleted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style(context.theme.popoverStyle);
    final direction = Directionality.maybeOf(context) ?? .ltr;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final touch = context.platformVariant.touch;
    final popoverAnchor = widget.popoverAnchor ?? (touch ? .bottomCenter : .topCenter);
    final childAnchor = widget.childAnchor ?? (touch ? .topCenter : .bottomCenter);

    var child = widget.builder(context, _controller, widget.child);

    if (widget.hideRegion == .excludeChild) {
      child = TapRegion(
        groupId: _groupId,
        onTapOutside: style.barrierFilter != null ? null : (_) => _hide(),
        child: child,
      );
    }

    return BackdropGroup(
      child: FPortal(
        control: .managed(controller: _controller.overlay),
        constraints: widget.constraints,
        portalAnchor: popoverAnchor,
        childAnchor: childAnchor,
        useViewPadding: widget.useViewPadding,
        useViewInsets: widget.useViewInsets,
        padding: style.popoverPadding,
        spacing: widget.spacing,
        overflow: widget.overflow,
        offset: widget.offset,
        barrier: style.barrierFilter == null
            ? null
            : (cutout) => TapRegion(
              groupId: widget.groupId,
              child: FAnimatedModalBarrier(
                  cutout: widget.cutout ? cutout : null,
                  cutoutBuilder: widget.cutoutBuilder,
                  animation: _controller.fade,
                  filter: style.barrierFilter!,
                  semanticsLabel: widget.barrierSemanticsLabel ?? localizations.barrierLabel,
                  barrierSemanticsDismissible: widget.barrierSemanticsDismissible,
                  semanticsOnTapHint: localizations.barrierOnTapHint(localizations.popoverSemanticsLabel),
                  onDismiss: widget.hideRegion == .none ? null : _hide,
                ),
            ),
        portalBuilder: (context, _) {
          Widget popover = ScaleTransition(
            alignment: popoverAnchor.resolve(direction),
            scale: _controller.scale,
            child: FadeTransition(
              opacity: _controller.fade,
              child: Semantics(
                label: widget.semanticsLabel,
                container: true,
                child: FocusScope(
                  autofocus: widget.autofocus ?? (style.barrierFilter != null),
                  node: _focusNode,
                  onFocusChange: widget.onFocusChange,
                  child: TapRegion(
                    groupId: _groupId,
                    onTapOutside: widget.hideRegion == .none || style.barrierFilter != null ? null : (_) => _hide(),
                    child: DecoratedBox(
                      decoration: style.decoration,
                      child: widget.popoverBuilder(context, _controller),
                    ),
                  ),
                ),
              ),
            ),
          );

          // The background filter cannot be nested in a FadeTransition because of https://github.com/flutter/flutter/issues/31706.
          if (style.backgroundFilter case final filter?) {
            popover = Stack(
              children: [
                Positioned.fill(
                  child: ClipRect(
                    child: AnimatedBuilder(
                      animation: _controller.fade,
                      builder: (_, _) => BackdropFilter(filter: filter(_controller.fade.value), child: Container()),
                    ),
                  ),
                ),
                popover,
              ],
            );
          }

          return CallbackShortcuts(
            bindings: widget.shortcuts ?? {const SingleActivator(.escape): _hide},
            child: popover,
          );
        },
        child: child,
      ),
    );
  }

  void _hide() {
    // We need to check if it is shown first, otherwise it will fire even when hidden. This messes with the focus
    // when there are multiple FSelects/other widgets.
    if (_controller.status.isForwardOrCompleted) {
      _controller.hide();
      widget.onTapHide?.call();
    }
  }
}

/// A [FPopover]'s style.
class FPopoverStyle with Diagnosticable, _$FPopoverStyleFunctions {
  /// The popover's decoration.
  @override
  final Decoration decoration;

  /// {@template forui.widgets.FPopoverStyle.barrierFilter}
  /// An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter]
  /// that is used as the barrier. Defaults to null.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5);
  ///
  /// // Solid color
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation), BlendMode.srcOver);
  ///
  /// // Tinted
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// (animation) => ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver),
  /// );
  /// ```
  /// {@endtemplate}
  @override
  final ImageFilter Function(double animation)? barrierFilter;

  /// {@template forui.widgets.FPopoverStyle.backgroundFilter}
  /// An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter]
  /// that is used as the background. Defaults to null.
  ///
  /// This is typically combined with a transparent/translucent background to create a glassmorphic effect.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5);
  ///
  /// // Solid color
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation), BlendMode.srcOver);
  ///
  /// // Tinted
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// (animation) => ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver),
  /// );
  /// ```
  /// {@endtemplate}
  @override
  final ImageFilter Function(double animation)? backgroundFilter;

  /// The additional padding between the edges of the view and the edges of the popover.
  ///
  /// This is applied on top of the view's safe area and keyboard insets.
  ///
  /// Defaults to `EdgeInsets.all(5)`.
  @override
  final EdgeInsetsGeometry popoverPadding;

  /// The popover's motion configuration.
  @override
  final FPopoverMotion motion;

  /// Creates a [FPopoverStyle].
  const FPopoverStyle({
    required this.decoration,
    this.barrierFilter,
    this.backgroundFilter,
    this.popoverPadding = const .all(5),
    this.motion = const FPopoverMotion(),
  });

  /// Creates a [FPopoverStyle] that inherits its properties.
  FPopoverStyle.inherit({required FColors colors, required FStyle style})
    : this(
        decoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(
            side: BorderSide(color: colors.border, width: style.borderWidth),
            borderRadius: style.borderRadius.md,
          ),
          shadows: style.shadow,
          color: colors.card,
        ),
      );
}
