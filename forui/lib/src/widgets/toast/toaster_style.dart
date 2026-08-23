import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FToast', {'primary': (1, 'The primary toast style.'), 'destructive': (2, 'The destructive toast style.')})
@SentinelValues(FToastStyle, {'backgroundFilter': 'Sentinels.imageFilter'})
part 'toaster_style.design.dart';

/// A toaster's expansion behavior.
enum FToasterExpandBehavior {
  /// The toasts are always expanded.
  always,

  /// The toasts are expanded when the toaster is hovered or pressed.
  hoverOrPress,

  /// The toasts are never expanded.
  disabled,
}

/// [FToaster]'s style.
class const FToasterStyle({
  /// The toast variant styles.
  @override required final FToastStyles toastStyles,

  /// The maximum number of entries shown per [FToastAlignment]. Defaults to to 3.
  @override final double max = 3,

  /// The toaster's padding. Defaults to `EdgeInsets.symmetric(horizontal: 20, vertical: 15)`.
  @override final EdgeInsetsGeometry padding = const .symmetric(horizontal: 20, vertical: 15),

  /// The toaster's expansion behavior. Defaults to [FToasterExpandBehavior.hoverOrPress].
  @override final FToasterExpandBehavior expandBehavior = .hoverOrPress,

  /// The duration to wait after entering the toaster before expanding the toasts. Defaults to 200ms.
  @override final Duration expandHoverEnterDuration = const Duration(milliseconds: 200),

  /// The duration to wait after exiting the toaster before collapsing the toasts.
  ///
  /// Defaults to 200ms. It is not recommended to set this below 100ms as it does not conform with WCAG 1.4.13, since
  /// the toasts may collapse before the pointer can move onto them.
  @override final Duration expandHoverExitDuration = const Duration(milliseconds: 200),

  /// The spacing below or above the toasts when they are expanded. Defaults to 0.
  @override final double expandStartSpacing = 0,

  /// The spacing between the toasts when they are expanded. Defaults to 10.0.
  @override final double expandSpacing = 10,

  /// The protrusion of the collapsed toasts behind the front toast. This is scaled by the number of toasts in
  /// front of the toast.
  ///
  /// Defaults to 12.0.
  @override final double collapsedProtrusion = 12,

  /// The scaling factor pf the collapsed toasts behind the front toast. This is scaled by the number of toasts in
  /// front of the toast.
  ///
  /// Defaults to 0.9.
  @override final double collapsedScale = 0.9,

  /// The motion-related properties. Defaults to [FToasterMotion].
  @override final FToasterMotion motion = const FToasterMotion(),

  /// The toast's alignment relative to a [FToaster]. Defaults to [FToastAlignment.topCenter] on touch devices, and
  /// [FToastAlignment.bottomEnd] otherwise.
  @override final FToastAlignment toastAlignment = .bottomEnd,
}) with Diagnosticable, _$FToasterStyleFunctions {
  /// Creates a [FToasterStyle].
  this;

  /// Creates a [FToasterStyle] that inherits its properties.
  new inherit({required FColors colors, required FTypography typography, required FStyle style, required bool touch})
    : this(
        toastStyles: .inherit(colors: colors, typography: typography, style: style, touch: touch),
        toastAlignment: touch ? .topCenter : .bottomEnd,
      );
}

/// The toast styles.
extension type FToastStyles(FVariants<FToastVariantConstraint, FToastVariant, FToastStyle, FToastStyleDelta> _)
    implements FVariants<FToastVariantConstraint, FToastVariant, FToastStyle, FToastStyleDelta> {
  /// Creates a [FToastStyles] that inherits its properties.
  factory inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) {
    final primary = FToastStyle.inherit(colors: colors, typography: typography, style: style, touch: touch);

    return FToastStyles(
      FVariants.from(
        primary,
        variants: {
          [.primary]: const .delta(),
          [.destructive]: .delta(
            iconStyle: .delta(color: colors.destructive),
            titleTextStyle: .delta(color: colors.destructive),
            descriptionTextStyle: .delta(color: colors.destructive),
          ),
        },
      ),
    );
  }

  /// The primary toast style.
  FToastStyle get primary => resolve({FToastVariant.primary});

  /// The destructive toast style.
  FToastStyle get destructive => resolve({FToastVariant.destructive});
}

/// The motion-related properties for [FToaster] that affect all toasts.
///
/// See [FToastMotion] for motion properties that affect individual toasts.
///
/// When [FAccessibility.motion] is:
/// * [FAccessibilityMotion.reduced], only fade transitions are applied.
/// * [FAccessibilityMotion.disabled], no motion is applied.
class const FToasterMotion({
  /// The duration of the toasts' expansion. Defaults to 400ms.
  @override final Duration expandDuration = const Duration(milliseconds: 400),

  /// The duration of the toasts' collapsing. Defaults to 300ms.
  @override final Duration collapseDuration = const Duration(milliseconds: 300),

  /// The animation curve for the toasts' expansion and collapsing. Defaults to [Curves.easeOutCubic].
  @override final Curve expandCurve = Curves.easeOutCubic,

  /// The animation curve for the toasts' collapsing. Defaults to [Curves.easeOut].
  @override final Curve collapseCurve = Curves.easeOut,
}) with Diagnosticable, _$FToasterMotionFunctions {
  /// Creates a [FToasterMotion].
  this;
}

/// The toast's style.
class FToastStyle({
  /// The toast's decoration.
  @override required final Decoration decoration,

  /// The style of the toast's prefix icon.
  @override required final IconThemeData iconStyle,

  /// The title's text style.
  @override required final TextStyle titleTextStyle,

  /// The description's text style.
  @override required final TextStyle descriptionTextStyle,

  /// The toast content's padding.
  @override required final EdgeInsetsGeometry padding,

  /// The toast's constraints. Defaults to `BoxConstraints(maxHeight: 250, maxWidth: 400)`.
  @override final BoxConstraints constraints = const BoxConstraints(maxHeight: 250, maxWidth: 400),

  /// An optional background filter. This only takes effect if the [decoration] has a transparent or translucent
  /// background color.
  ///
  /// This is typically combined with a transparent/translucent background to create a glassmorphic effect.
  ///
  /// There will be a flicker after the toast's fade-in entrance when a blur background filter is applied. This is due
  /// to
  /// https://github.com/flutter/flutter/issues/31706.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// ImageFilter.blur(sigmaX: 5, sigmaY: 5);
  ///
  /// // Solid color
  /// ColorFilter.mode(Colors.white, BlendMode.srcOver);
  ///
  /// // Tinted
  /// ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver),
  /// );
  /// ```
  @override final ImageFilter? backgroundFilter,

  /// The spacing between the icon and the title. Defaults to 10.
  @override final double iconSpacing = 10,

  /// The spacing between the title and description. Defaults to 4 on primarily touch devices and 2 on
  /// non-primarily touch devices.
  @override final double titleSpacing = 1,

  /// The spacing between the content and the suffix. Defaults to 12.
  @override final double suffixSpacing = 12,

  /// The motion-related properties. Defaults to [FToastMotion].
  @override final FToastMotion motion = const FToastMotion(),
}) with Diagnosticable, _$FToastStyleFunctions {
  /// Creates a [FToastStyle].
  this;

  /// Creates a [FToastStyle] that inherits its properties.
  factory inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) {
    double titleSpacing;
    TextStyle descriptionTextStyle;
    EdgeInsetsGeometry padding;
    if (touch) {
      titleSpacing = 4;
      descriptionTextStyle = typography.body.xs.copyWith(
        color: colors.mutedForeground,
        overflow: TextOverflow.ellipsis,
      );
      padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14);
    } else {
      titleSpacing = 2;
      descriptionTextStyle = typography.body.sm.copyWith(
        color: colors.mutedForeground,
        overflow: TextOverflow.ellipsis,
      );
      padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }

    return FToastStyle(
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(
          side: BorderSide(color: colors.border, width: style.borderWidth),
          borderRadius: style.borderRadius.md,
        ),
        color: colors.card,
      ),
      iconStyle: IconThemeData(color: colors.foreground, size: typography.body.md.fontSize),
      titleTextStyle: typography.display.sm.copyWith(color: colors.foreground, fontWeight: .w500, height: 1),
      titleSpacing: titleSpacing,
      descriptionTextStyle: descriptionTextStyle,
      padding: padding,
    );
  }
}

/// The motion-related properties for [FToaster] that affect individual toasts.
///
///
/// See [FToasterMotion] for motion properties that affect the entire toaster.
///
/// When [FAccessibility.motion] is:
/// * [FAccessibilityMotion.reduced], only fade transitions are applied.
/// * [FAccessibilityMotion.disabled], no motion is applied.
class const FToastMotion({
  /// The duration of the toast's entrance when it is initially added to to toaster. Defaults to 400ms.
  @override final Duration entranceDuration = const Duration(milliseconds: 400),

  /// The duration of the toast's exit animation when it is dismissed. Defaults to 300ms.
  @override final Duration dismissDuration = const Duration(milliseconds: 300),

  /// The duration of the toast's transition between places in the toaster. Defaults to 400ms.
  @override final Duration transitionDuration = const Duration(milliseconds: 400),

  /// The duration of the toast's fade-in animation when another toast has been dismissed and this toast re-enters the
  /// toaster. Defaults to 400ms.
  @override final Duration reentranceDuration = const Duration(milliseconds: 400),

  /// The duration of the toast's fade-out animation when the number of toasts in a toaster exceeds the maximum allowed
  /// and this toast is hidden. Defaults to 400ms.
  @override final Duration exitDuration = const Duration(milliseconds: 400),

  /// The toast's swipe completion animation duration. Defaults to 150ms.
  @override final Duration swipeCompletionDuration = const Duration(milliseconds: 150),

  /// The toast's initial entrance animation curve. Defaults to [Curves.easeOutCubic].
  @override final Curve entranceCurve = Curves.easeOutCubic,

  /// The toast's exit animation curve. Defaults to [Curves.easeOutCubic].
  @override final Curve dismissCurve = Curves.easeOutCubic,

  /// The toast's transition animation curve. Defaults to [Curves.easeOutCubic].
  @override final Curve transitionCurve = Curves.easeOutCubic,

  /// The curve of the toast's fade-in animation when another toast has been dismissed and this toast re-enters the
  /// toaster. Defaults to [Curves.easeOutCubic].
  @override final Curve reentranceCurve = Curves.easeOutCubic,

  /// The curve of the toast's fade-out animation when the number of toasts in a toaster exceeds the maximum allowed
  /// and this toast is hidden. Defaults to [Curves.easeOutCubic].
  @override final Curve exitCurve = Curves.easeOutCubic,

  /// The toast's swipe completion animation curve. Defaults to [Curves.easeInCubic].
  @override final Curve swipeCompletionCurve = Curves.easeInCubic,

  /// The toast's initial entrance's opacity and dismiss's fade tween. Defaults to `[0, 1]`.
  ///
  /// Set to `[1, 1]` to disable the fade-in/out effect.
  @override final Animatable<double> entranceDismissFadeTween = const FImmutableTween(begin: 0.0, end: 1.0),
}) with Diagnosticable, _$FToastMotionFunctions {
  /// Creates a [FToastMotion].
  this;
}
