import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/foundation/inner_path_clipper.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FDialogAxis', {
  'horizontal': (1, 'The horizontal dialog variant.'),
  'vertical': (1, 'The vertical dialog variant.'),
})
@SentinelValues(FDialogStyle, {'backgroundFilter': 'Sentinels.imageFilterFunction'})
part 'dialog.design.dart';

/// Shows a dialog.
///
/// [context] is used to look up the [Navigator] and [FDialogStyle] for the dialog. It is only used when the method is
/// called. Its corresponding widget can be safely removed from the tree before the sheet is closed.
///
/// [useRootNavigator] ensures that the root navigator displays the sheet when `true`. This is useful in the case that a
/// modal sheet needs to be displayed above all other content but the caller is inside another [Navigator].
///
/// [routeStyle] defaults to [FDialogStyle] from the closest [FTheme] ancestor.
///
/// [barrierLabel] defaults to [FLocalizations.barrierLabel].
///
/// Returns a `Future` that resolves to the value (if any) that was passed to [Navigator.pop] when the modal sheet was
/// closed.
///
/// To modify the current [style]:
/// ```dart
/// style: .delta(...)
/// ```
///
/// To replace the [style]:
/// ```dart
/// style: FDialogStyle(...)
/// ```
///
/// ## CLI
/// To generate and customize this widget's style:
///
/// ```shell
/// dart run forui style create dialog
/// ```
///
/// To generate a layout for this widget:
///
/// ```shell
/// dart run forui snippet create adaptive-card
/// ```
///
///
/// See:
/// * https://forui.dev/docs/widgets/overlay/dialog for working examples and generatable layouts for this widget.
/// * [showAdaptiveDialog] for displaying a dialog with adaptive transitions depending on the platform.
/// * [FDialogStyle] for customizing a switch's appearance.
Future<T?> showFDialog<T>({
  required BuildContext context,
  required Widget Function(BuildContext context, FDialogStyle style, Animation<double> animation) builder,
  bool useRootNavigator = false,
  FDialogRouteStyleDelta routeStyle = const .context(),
  FDialogStyleDelta style = const .context(),
  String? barrierLabel,
  bool barrierDismissible = true,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
  Offset? anchorPoint,
  bool useSafeArea = false,
}) {
  assert(debugCheckHasMediaQuery(context));

  final navigator = Navigator.of(context, rootNavigator: useRootNavigator);
  final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
  final dialogRouteStyle = routeStyle(context.theme.dialogRouteStyle);
  final dialogStyle = style(context.theme.dialogStyle);

  return navigator.push(
    FDialogRoute<T>(
      style: dialogRouteStyle,
      builder: (context, animation) => builder(context, dialogStyle, animation),
      capturedThemes: InheritedTheme.capture(from: context, to: navigator.context),
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel ?? localizations.barrierLabel,
      barrierOnTapHint: localizations.barrierOnTapHint(localizations.dialogSemanticsLabel),
      settings: routeSettings,
      anchorPoint: anchorPoint,
      useSafeArea: useSafeArea,
    ),
  );
}

/// A route that shows a dialog popup.
///
/// [showFDialog] should be preferred in most cases.
class FDialogRoute<T> extends RawDialogRoute<T> {
  /// The dialog route's style.
  final FDialogRouteStyle style;

  @override
  final bool barrierDismissible;

  @override
  final String? barrierLabel;

  /// The semantic hint text that informs users what will happen if they tap on the widget. Announced in the format of
  /// 'Double tap to ...'.
  final String? barrierOnTapHint;

  /// Creates a [FDialogRoute].
  FDialogRoute({
    required this.style,
    required Widget Function(BuildContext context, Animation<double> animation) builder,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.barrierOnTapHint,
    CapturedThemes? capturedThemes,
    bool useSafeArea = true,
    super.settings,
    super.requestFocus,
    super.anchorPoint,
    super.traversalEdgeBehavior,
    super.directionalTraversalEdgeBehavior,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) {
           final child = Builder(builder: (context) => builder(context, animation));
           Widget dialog = capturedThemes?.wrap(child) ?? child;
           if (useSafeArea) {
             dialog = SafeArea(child: dialog);
           }
           return dialog;
         },
       );

  @override
  Widget buildModalBarrier() {
    if (style.barrierFilter != null && !offstage) {
      return Builder(
        builder: (context) => FAnimatedModalBarrier(
          animation: animation!.drive(CurveTween(curve: barrierCurve)),
          filter: style.barrierFilter,
          onDismiss: barrierDismissible ? () => Navigator.pop(context) : null,
          semanticsLabel: barrierLabel,
          // changedInternalState is called if barrierLabel updates
          barrierSemanticsDismissible: semanticsDismissible,
          semanticsOnTapHint: barrierOnTapHint,
        ),
      );
    } else {
      return Builder(
        builder: (context) => FModalBarrier(
          filter: null,
          onDismiss: barrierDismissible ? () => Navigator.pop(context) : null,
          semanticsLabel: barrierLabel,
          // changedInternalState is called if barrierLabel updates
          barrierSemanticsDismissible: semanticsDismissible,
          semanticsOnTapHint: barrierOnTapHint,
        ),
      );
    }
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => child;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  Curve get barrierCurve => style.motion.barrierCurve;

  @override
  Duration get transitionDuration => style.motion.entranceDuration;

  @override
  Duration get reverseTransitionDuration => style.motion.exitDuration;
}

/// [FDialogRoute]'s style.
class FDialogRouteStyle with Diagnosticable, _$FDialogRouteStyleFunctions {
  /// {@macro forui.widgets.FPopoverStyle.barrierFilter}
  @override
  final ImageFilter Function(double animation)? barrierFilter;

  /// Motion-related properties.
  @override
  final FDialogRouteMotion motion;

  /// Creates a [FDialogRouteStyle].
  const FDialogRouteStyle({this.barrierFilter, this.motion = const FDialogRouteMotion()});

  /// Creates a [FDialogRouteStyle] that inherits its properties.
  FDialogRouteStyle.inherit({required FColors colors})
    : this(
        barrierFilter: (v) => .compose(
          outer: .blur(sigmaX: v * 5, sigmaY: v * 5),
          inner: ColorFilter.mode(FColors.lerpColor(Colors.transparent, colors.barrier, v)!, .srcOver),
        ),
      );
}

/// Motion-related properties for [FDialogRoute].
class FDialogRouteMotion with Diagnosticable, _$FDialogRouteMotionFunctions {
  /// The amount of time the entrance animation takes. Defaults to 150ms.
  ///
  /// The dialog's animation and curve is managed by [FDialogMotion].
  @override
  final Duration entranceDuration;

  /// The amount of time the exit animation takes. Defaults to 150ms.
  ///
  /// The dialog's animation and curve is managed by [FDialogMotion].
  @override
  final Duration exitDuration;

  /// The curve used for the barrier's entrance and exit. Defaults to [Curves.ease].
  @override
  final Curve barrierCurve;

  /// Creates a [FDialogRouteMotion].
  const FDialogRouteMotion({
    this.entranceDuration = const Duration(milliseconds: 150),
    this.exitDuration = const Duration(milliseconds: 150),
    this.barrierCurve = Curves.ease,
  });
}

/// A modal dialog.
///
/// A dialog interrupts the user with important content and expects a response.
///
/// ## CLI
/// To generate a layout for this widget:
///
/// ```shell
/// dart run forui snippet create adaptive-card
/// ```
///
/// Consider using with
/// * [showFDialog] if you want to show a dialog with consistent Shadcn/ui-like transitions across platforms.
/// * [showAdaptiveDialog] if you want to show a dialog with transitions.
///
/// See:
/// * https://forui.dev/docs/widgets/overlay/dialog for working examples and generatable layouts for this widget.
/// * [FDialogStyle] for customizing a dialog's appearance.
class FDialog extends StatefulWidget {
  /// The dialog's style. Defaults to [FThemeData.dialogStyle].
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FDialogStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create dialog
  /// ```
  final FDialogStyleDelta style;

  /// The clip behavior applied to the dialog's content.
  ///
  /// When set to a value other than [Clip.none], the dialog's content is clipped to the inner path of its decoration,
  /// so children cannot overflow the rounded corners or paint over the border ring.
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// The animation used to animate the dialog's entrance and exit. Settings this to null will disable the animation.
  ///
  /// It is the responsibility of the caller to manage & dispose the given [animation].
  ///
  /// Defaults to null.
  final Animation<double>? animation;

  /// The semantic label of the dialog used by accessibility frameworks to announce screen transitions when the dialog
  /// is opened and closed.
  ///
  /// See also:
  ///  * [SemanticsConfiguration.namesRoute], for a description of how this value is used.
  final String? semanticsLabel;

  /// The dialog's box constraints. Defaults to `BoxConstraints(minWidth: 280, maxWidth: 560)`.
  final BoxConstraints constraints;

  /// Whether the dialog should avoid the system's view insets, typically the keyboard. Defaults to true.
  ///
  /// Set this to false to avoid the dialog from becoming overly compressed on web & embedded platforms where the view
  /// insets comes from the surrounding host/browser environment.
  final bool resizeToAvoidInsets;

  /// The builder for the dialog's content.
  final Widget Function(BuildContext context, FDialogStyle style) builder;

  /// Creates a [FDialog] with a custom [builder].
  ///
  /// ## CLI
  /// To generate a layout for this widget:
  ///
  /// ```shell
  /// dart run forui snippet create horizontal-card
  /// ```
  ///
  /// See https://forui.dev/docs/widgets/data/card for other generatable layouts.
  const FDialog({
    required this.builder,
    this.style = const .context(),
    this.clipBehavior = .none,
    this.animation,
    this.semanticsLabel,
    this.constraints = const BoxConstraints(minWidth: 280, maxWidth: 560),
    this.resizeToAvoidInsets = true,
    super.key,
  });

  /// Creates an adaptive [FDialog] that uses [verticalBuilder] on [FBreakpoints.sm] devices and [horizontalBuilder] on
  /// larger devices.
  ///
  /// ## CLI
  /// To generate a layout for this widget:
  ///
  /// ```shell
  /// dart run forui snippet create adaptive-card
  /// ```
  ///
  /// See https://forui.dev/docs/widgets/data/card for other generatable layouts.
  FDialog.adaptive({
    required Widget Function(BuildContext context, FDialogStyle style) horizontalBuilder,
    required Widget Function(BuildContext context, FDialogStyle style) verticalBuilder,
    this.style = const .context(),
    this.clipBehavior = .none,
    this.animation,
    this.semanticsLabel,
    this.constraints = const BoxConstraints(minWidth: 280, maxWidth: 560),
    this.resizeToAvoidInsets = true,
    super.key,
  }) : builder = ((context, style) => switch (MediaQuery.sizeOf(context).width) {
         final width when width < context.theme.breakpoints.sm => verticalBuilder(context, style),
         _ => horizontalBuilder(context, style),
       });

  @override
  State<FDialog> createState() => _FDialogState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('animation', animation))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(FlagProperty('resizeToAvoidInsets', value: resizeToAvoidInsets, ifFalse: 'do not resize for view insets'))
      ..add(EnumProperty('clipBehavior', clipBehavior))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _FDialogState extends State<FDialog> {
  CurvedAnimation? _curvedScale;
  CurvedAnimation? _curvedFade;
  Animation<double>? _scale;
  Animation<double>? _fade;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final style = widget.style(context.theme.dialogStyle);

    if (_curvedScale?.parent != widget.animation || _curvedFade?.parent != widget.animation) {
      _curvedScale?.dispose();
      _curvedFade?.dispose();

      if (widget.animation case final animation?) {
        _curvedScale = CurvedAnimation(
          parent: animation,
          curve: style.motion.expandCurve,
          reverseCurve: style.motion.collapseCurve,
        );
        _curvedFade = CurvedAnimation(
          parent: animation,
          curve: style.motion.fadeInCurve,
          reverseCurve: style.motion.fadeOutCurve,
        );
        _scale = style.motion.scaleTween.animate(_curvedScale!);
        _fade = style.motion.fadeTween.animate(_curvedFade!);
      } else {
        _curvedScale = null;
        _curvedFade = null;
        _scale = null;
        _fade = null;
      }
    }
  }

  @override
  void dispose() {
    _curvedFade?.dispose();
    _curvedScale?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = widget.style(context.theme.dialogStyle);
    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
    final motion = context.accessibility.motion;

    Widget dialog = DecoratedBox(
      decoration: style.decoration,
      child: widget.clipBehavior == .none
          ? widget.builder(context, style)
          : ClipPath(
              clipBehavior: widget.clipBehavior,
              clipper: InnerPathClipper(decoration: style.decoration, direction: direction),
              child: widget.builder(context, style),
            ),
    );

    // We cannot handle the transition in [FDialogRoute] because of https://github.com/flutter/flutter/issues/31706.
    if (_fade case final fade? when motion != .disabled) {
      dialog = FadeTransition(opacity: fade, child: dialog);
    }

    if (style.backgroundFilter case final filter?) {
      // Confine the filter to the decoration: `.passthrough` matches its size, `ClipPath` its rounded shape.
      dialog = Stack(
        fit: .passthrough,
        children: [
          Positioned.fill(
            child: ClipPath(
              clipper: InnerPathClipper(decoration: style.decoration, direction: direction),
              child: _fade == null
                  ? BackdropFilter(filter: filter(1), child: Container())
                  : AnimatedBuilder(
                      animation: _fade!,
                      builder: (_, _) => BackdropFilter(filter: filter(_fade!.value), child: Container()),
                    ),
            ),
          ),
          dialog,
        ],
      );
    }

    // We want to scale the dialog, including the background filter.
    if (_scale case final scale? when motion == .all) {
      dialog = ScaleTransition(scale: scale, child: dialog);
    }

    return AnimatedPadding(
      padding:
          (widget.resizeToAvoidInsets ? MediaQuery.viewInsetsOf(context) : EdgeInsets.zero) +
          style.insetPadding.resolve(direction),
      duration: style.motion.insetDuration,
      curve: style.motion.insetCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Align(
          child: DefaultTextStyle(
            style: context.theme.typography.body.md.copyWith(color: theme.colors.foreground),
            child: Semantics(
              scopesRoute: true,
              explicitChildNodes: true,
              namesRoute: true,
              label: widget.semanticsLabel,
              child: ConstrainedBox(constraints: widget.constraints, child: dialog),
            ),
          ),
        ),
      ),
    );
  }
}

/// [FDialog]'s style.
class FDialogStyle with Diagnosticable, _$FDialogStyleFunctions {
  /// {@macro forui.widgets.FPopoverStyle.backgroundFilter}
  ///
  /// This requires [FDialog.animation] to be non-null.
  @override
  final ImageFilter Function(double animation)? backgroundFilter;

  /// The decoration.
  @override
  final Decoration decoration;

  /// The title's [TextStyle].
  @override
  final TextStyle titleTextStyle;

  /// The body's [TextStyle].
  @override
  final TextStyle bodyTextStyle;

  /// The inset padding. Defaults to `EdgeInsets.symmetric(horizontal: 40, vertical: 24)`.
  @override
  final EdgeInsetsGeometry insetPadding;

  /// The haptic feedback for when the user slides from one action to another.
  @override
  final Future<void> Function() slidePressHapticFeedback;

  /// Motion-related properties.
  @override
  final FDialogMotion motion;

  /// Creates a [FDialogStyle].
  FDialogStyle({
    required this.decoration,
    required this.titleTextStyle,
    required this.bodyTextStyle,
    required this.slidePressHapticFeedback,
    this.backgroundFilter,
    this.insetPadding = const .symmetric(horizontal: 40, vertical: 24),
    this.motion = const FDialogMotion(),
  });

  /// Creates a [FDialogStyle] that inherits its properties.
  factory FDialogStyle.inherit({
    required FStyle style,
    required FColors colors,
    required FTypography typography,
    required FHapticFeedback hapticFeedback,
    required bool touch,
  }) => .new(
    decoration: ShapeDecoration(
      shape: RoundedSuperellipseBorder(
        side: BorderSide(color: colors.border, width: style.borderWidth),
        borderRadius: style.borderRadius.md,
      ),
      color: colors.card,
    ),
    titleTextStyle: typography.display.md.copyWith(fontWeight: .w600, color: colors.foreground, height: 1.25),
    bodyTextStyle: touch
        ? typography.body.xs.copyWith(color: colors.mutedForeground)
        : typography.body.sm.copyWith(color: colors.mutedForeground),
    slidePressHapticFeedback: hapticFeedback.selectionClick,
  );
}

/// Motion-related properties for [FDialog].
///
/// These fields are only used when [FDialog.animation] is non-null.
///
/// The actual animation duration is controlled by the route used to display the dialog, such as [FDialogRoute]. When
/// using [showFDialog], the duration can be customized via [FDialogRouteStyle.motion].
///
/// When [FAccessibility.motion] is:
/// * [FAccessibilityMotion.reduced], only fade transitions are applied.
/// * [FAccessibilityMotion.disabled], no motion is applied.
class FDialogMotion with Diagnosticable, _$FDialogMotionFunctions {
  /// The curve used for the dialog's expansion animation when entering. Defaults to [Curves.easeOutCubic].
  @override
  final Curve expandCurve;

  /// The curve used for the dialog's collapse animation when exiting. Defaults to [Curves.easeInCubic].
  @override
  final Curve collapseCurve;

  /// The curve used for the dialog's fade-in animation when entering. Defaults to [Curves.linear].
  @override
  final Curve fadeInCurve;

  /// The curve used for the dialog's fade-out animation when exiting. Defaults to [Curves.linear].
  @override
  final Curve fadeOutCurve;

  /// The tween used to animate the dialog's scale in and out. Defaults to `[0.95, 1]`.
  @override
  final Animatable<double> scaleTween;

  /// The tween used to animate the dialog's fade in and out. Defaults to `[0, 1]`.
  @override
  final Animatable<double> fadeTween;

  /// The duration of the animation to show when the system keyboard intrudes into the space that the dialog is placed in.
  /// Defaults to 100ms.
  @override
  final Duration insetDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes into the space that the dialog is
  /// placed in. Defaults to [Curves.decelerate].
  @override
  final Curve insetCurve;

  /// Creates a [FDialogMotion].
  const FDialogMotion({
    this.expandCurve = Curves.easeOutCubic,
    this.collapseCurve = Curves.easeInCubic,
    this.fadeInCurve = Curves.linear,
    this.fadeOutCurve = Curves.linear,
    this.scaleTween = const FImmutableTween(begin: 0.95, end: 1.0),
    this.fadeTween = const FImmutableTween(begin: 0.0, end: 1.0),
    this.insetDuration = const Duration(milliseconds: 100),
    this.insetCurve = Curves.decelerate,
  });
}
