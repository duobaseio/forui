import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/label/horizontal_label.dart';
import 'package:forui/src/widgets/label/vertical_label.dart';

part 'label.design.dart';

/// The layout of a [FLabel].
///
/// See [FLabel] for usage examples.
enum FLabelLayout {
  /// The label/description/error is on the left, child on the right, assuming LTR text direction.
  ///
  /// ```diagram
  /// |--------------------------|
  /// |  [label]        [child]  |
  /// |  [description]           |
  /// |  [error]                 |
  /// |--------------------------|
  /// ```
  horizontalLeading,

  /// The child is on the left, label/description/error on the right, assuming LTR text direction.
  ///
  /// Used by default in [FCheckbox], [FRadio], [FSwitch].
  /// ```diagram
  /// |--------------------------|
  /// |  [child]  [label]        |
  /// |           [description]  |
  /// |           [error]        |
  /// |--------------------------|
  /// ```
  horizontalTrailing,

  /// The label is above the child, description/error below.
  ///
  /// Used in [FTextField].
  /// ```diagram
  /// |-----------------|
  /// |  [label]        |
  /// |  [child]        |
  /// |  [description]  |
  /// |  [error]        |
  /// |-----------------|
  /// ```
  vertical,
}

/// A component that describes a form field with a label, description, and error message (if any).
///
/// {@template forui.widgets.label.error_transition}
/// ## Error transition caveats
/// Error transitions require either a [label] or [description] to function. In the rare case where only an `error` is
/// needed, set [label] or [description] to an empty widget, e.g. [SizedBox.shrink].
/// {@endtemplate}
///
/// See:
/// * https://forui.dev/docs/widgets/form/label for working examples.
/// * [FLabelStyles] for customizing a label's appearance.
class FLabel extends StatelessWidget {
  /// The label's style. Defaults to the appropriate style in [FThemeData.labelStyles].
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FLabelStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create labels
  /// ```
  // ignore: diagnostic_describe_all_properties
  final FLabelStyleDelta style;

  /// The label that describes the form field.
  final Widget? label;

  /// The description that elaborates on the label.
  final Widget? description;

  /// The error message.
  final Widget? error;

  /// The layout.
  final FLabelLayout layout;

  /// Whether the child should expand to fill the available space. Defaults to false.
  ///
  /// ## Contract
  /// Only applicable when [layout] is [FLabelLayout.vertical].
  final bool expands;

  /// The label's variants.
  final Set<FFormFieldVariant> variants;

  /// The child.
  final Widget child;

  /// Creates a [FLabel].
  const new({
    required this.layout,
    required this.child,
    this.style = const .context(),
    this.label,
    this.description,
    this.error,
    this.expands = false,
    this.variants = const {},
    super.key,
  }) : assert(layout == .vertical || !expands, 'expands can only be true when layout is vertical');

  @override
  Widget build(BuildContext context) {
    final style = this.style(context.theme.labelStyles._style(layout));

    // This messes up error transitions if a label and description weren't previously provided. However, it is an
    // extremely rare edge case to want an error message without a label & description.
    // In those cases, users can just set label/description to an empty SizedBox().
    if (label == null && description == null && error == null) {
      return Padding(padding: style.childPadding, child: child);
    }

    return switch (layout) {
      .horizontalLeading => HorizontalLeadingLabel(
        style: style,
        label: label,
        description: description,
        error: error,
        variants: variants,
        child: child,
      ),
      .horizontalTrailing => HorizontalTrailingLabel(
        style: style,
        label: label,
        description: description,
        error: error,
        variants: variants,
        child: child,
      ),
      .vertical => VerticalLabel(
        style: style,
        label: label,
        description: description,
        error: error,
        expands: expands,
        variants: variants,
        child: child,
      ),
    };
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('layout', layout))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(IterableProperty('variants', variants));
  }
}

@internal
abstract class const Label({
  required final FLabelStyle style,
  required final Widget? label,
  required final Widget? description,
  required final Widget? error,
  required final Set<FFormFieldVariant> variants,
  required final Widget child,
  super.key,
}) extends StatefulWidget {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(IterableProperty('variants', variants));
  }
}

@internal
abstract class LabelState<T extends Label> extends State<T> with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late AnimationController _fadeController;
  late CurvedAnimation _curvedSize;
  late CurvedAnimation _curvedFade;
  late Animation<double> _fade;
  Widget? error;

  @override
  void initState() {
    super.initState();
    final motion = widget.style.labelMotion;
    final value = widget.variants.contains(FFormFieldVariant.error) ? 1.0 : 0.0;
    _sizeController = AnimationController(
      vsync: this,
      value: value,
      duration: motion.errorExpandDuration,
      reverseDuration: motion.errorCollapseDuration,
    )..addStatusListener(_clearError);
    _fadeController = AnimationController(
      vsync: this,
      value: value,
      duration: motion.errorFadeInDuration,
      reverseDuration: motion.errorFadeOutDuration,
    )..addStatusListener(_clearError);
    _curvedSize = CurvedAnimation(
      parent: _sizeController,
      curve: motion.errorExpandCurve,
      reverseCurve: motion.errorCollapseCurve,
    );
    _curvedFade = CurvedAnimation(
      parent: _fadeController,
      curve: motion.errorFadeInCurve,
      reverseCurve: motion.errorFadeOutCurve,
    );
    _fade = motion.errorFadeTween.animate(_fadeController);

    if (widget.variants.contains(FFormFieldVariant.error)) {
      error = widget.error;
    }
  }

  void _clearError(AnimationStatus status) {
    if (_sizeController.isDismissed && _fadeController.isDismissed) {
      setState(() => error = null);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateMotion();
  }

  @override
  void didUpdateWidget(covariant T old) {
    super.didUpdateWidget(old);
    if (old.style.labelMotion != widget.style.labelMotion) {
      _updateMotion();
    }

    if (widget.variants.contains(FFormFieldVariant.error)) {
      error = widget.error;
      _sizeController.forward();
      _fadeController.forward();
    } else {
      _fadeController.reverse();
      _sizeController.reverse();
    }
  }

  void _updateMotion() {
    final motion = context.accessibility.motion == .all ? widget.style.labelMotion : FLabelMotion.none;
    _sizeController
      ..duration = motion.errorExpandDuration
      ..reverseDuration = motion.errorCollapseDuration;
    _fadeController
      ..duration = motion.errorFadeInDuration
      ..reverseDuration = motion.errorFadeOutDuration;
    _curvedSize
      ..curve = motion.errorExpandCurve
      ..reverseCurve = motion.errorCollapseCurve;
    _curvedFade
      ..curve = motion.errorFadeInCurve
      ..reverseCurve = motion.errorFadeOutCurve;
    _fade = motion.errorFadeTween.animate(_curvedFade);
  }

  @override
  void dispose() {
    _curvedFade.dispose();
    _curvedSize.dispose();
    _fadeController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  Widget animatedError(BuildContext context, [TextHeightBehavior? behavior]) {
    final motion = this.motion;
    return AnimatedBuilder(
      animation: _curvedSize,
      builder: (context, child) =>
          Align(alignment: .topStart, heightFactor: _curvedSize.value, widthFactor: 1.0, child: child),
      child: FadeTransition(
        opacity: _fade,
        child: Padding(
          padding: widget.style.errorPadding,
          child: AnimatedDefaultTextStyle(
            style: widget.style.errorTextStyle.resolve(widget.variants),
            duration: motion.textStyleTransitionDuration,
            curve: motion.textStyleTransitionCurve,
            textHeightBehavior: behavior,
            child: Semantics(validationResult: .invalid, child: error!),
          ),
        ),
      ),
    );
  }

  FLabelMotion get motion => context.accessibility.motion == .all ? widget.style.labelMotion : .none;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('motion', motion));
  }
}

/// The [FLabel]'s styles.
class const FLabelStyles({
  /// The [FLabelLayout.horizontalLeading] style.
  @override required final FLabelStyle horizontalLeadingStyle,

  /// The [FLabelLayout.horizontalTrailing] style.
  @override required final FLabelStyle horizontalTrailingStyle,

  /// The [FLabelLayout.vertical] style.
  @override required final FLabelStyle verticalStyle,
}) with Diagnosticable, _$FLabelStylesFunctions {
  /// Creates a [FLabelStyles].
  this;

  /// Creates a [FLabelStyles] that inherits its properties.
  new inherit({required FStyle style})
    : this(
        horizontalLeadingStyle: .inherit(
          style: style,
          labelPadding: const .directional(end: 12),
          descriptionPadding: const .directional(top: 2, end: 12),
          errorPadding: const .directional(top: 2, end: 12),
        ),
        horizontalTrailingStyle: .inherit(
          style: style,
          labelPadding: const .directional(start: 8),
          descriptionPadding: const .directional(top: 2, start: 8),
          errorPadding: const .directional(top: 2, start: 8),
        ),
        verticalStyle: .inherit(
          style: style,
          labelPadding: const .only(bottom: 6),
          descriptionPadding: const .only(top: 6),
          errorPadding: const .only(top: 6),
        ),
      );

  FLabelStyle _style(FLabelLayout layout) => switch (layout) {
    .horizontalLeading => horizontalLeadingStyle,
    .horizontalTrailing => horizontalTrailingStyle,
    .vertical => verticalStyle,
  };
}

/// The [FLabel]'s style.
class const FLabelStyle({
  required super.labelTextStyle,
  required super.descriptionTextStyle,
  required super.errorTextStyle,

  /// The label's padding. Defaults to `EdgeInsets.zero`.
  @override final EdgeInsetsGeometry labelPadding = .zero,

  /// The description's padding. Defaults to `EdgeInsets.zero`.
  @override final EdgeInsetsGeometry descriptionPadding = .zero,

  /// The error's padding. Defaults to `EdgeInsets.zero`.
  @override final EdgeInsetsGeometry errorPadding = .zero,

  /// The child's padding. Defaults to `EdgeInsets.zero`.
  @override final EdgeInsetsGeometry childPadding = .zero,

  /// The motion properties for error animations. Defaults to [FLabelMotion].
  @override final FLabelMotion labelMotion = const FLabelMotion(),
}) extends FFormFieldStyle with _$FLabelStyleFunctions {
  /// Creates a [FLabelStyle].
  this;

  /// Creates a [FLabelStyle].
  new inherit({
    required FStyle style,
    EdgeInsetsGeometry labelPadding = .zero,
    EdgeInsetsGeometry descriptionPadding = .zero,
    EdgeInsetsGeometry errorPadding = .zero,
    EdgeInsetsGeometry childPadding = .zero,
    FLabelMotion labelMotion = const FLabelMotion(),
  }) : this(
         labelTextStyle: style.formFieldStyle.labelTextStyle,
         descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
         errorTextStyle: style.formFieldStyle.errorTextStyle,
         labelPadding: labelPadding,
         descriptionPadding: descriptionPadding,
         errorPadding: errorPadding,
         childPadding: childPadding,
         labelMotion: labelMotion,
       );
}

/// Motion-related properties for [FLabel] animations.
///
/// All motion is automatically disabled when [FAccessibility.motion] is not [FAccessibilityMotion.all].
class const FLabelMotion({
  /// The text style transition duration. Defaults to 100ms.
  @override final Duration textStyleTransitionDuration = const Duration(milliseconds: 100),

  /// The text style transition curve. Defaults to [Curves.linear].
  @override final Curve textStyleTransitionCurve = Curves.linear,

  /// The error expansion duration. Defaults to 100ms.
  @override final Duration errorExpandDuration = const Duration(milliseconds: 100),

  /// The error collapse duration. Defaults to 100ms.
  @override final Duration errorCollapseDuration = const Duration(milliseconds: 100),

  /// The error expansion curve. Defaults to [Curves.easeOut].
  @override final Curve errorExpandCurve = Curves.easeOut,

  /// The error collapse curve. Defaults to [Curves.easeOut].
  @override final Curve errorCollapseCurve = Curves.easeOut,

  /// The error fade in duration. Defaults to 100ms.
  @override final Duration errorFadeInDuration = const Duration(milliseconds: 100),

  /// The error fade out duration. Defaults to 100ms.
  @override final Duration errorFadeOutDuration = const Duration(milliseconds: 100),

  /// The error fade in curve. Defaults to [Curves.linear].
  @override final Curve errorFadeInCurve = Curves.linear,

  /// The error fade out curve. Defaults to [Curves.linear].
  @override final Curve errorFadeOutCurve = Curves.linear,

  /// The error fade tween. Defaults to [defaultErrorFadeTween].
  ///
  /// Set to [noErrorFadeTween] to disable the fade effect.
  @override final Animatable<double> errorFadeTween = defaultErrorFadeTween,
}) with Diagnosticable, _$FLabelMotionFunctions {
  /// Creates a [FLabelMotion].
  this;

  /// A [FLabelMotion] with no motion effects.
  static const FLabelMotion none = FLabelMotion(
    textStyleTransitionDuration: .zero,
    errorExpandDuration: .zero,
    errorCollapseDuration: .zero,
    errorFadeInDuration: .zero,
    errorFadeOutDuration: .zero,
    errorFadeTween: noErrorFadeTween,
  );

  /// The default error fade tween.
  static const FImmutableTween<double> defaultErrorFadeTween = FImmutableTween(begin: 0.4, end: 1.0);

  /// A tween that does not fade the error.
  static const FImmutableTween<double> noErrorFadeTween = FImmutableTween(begin: 1.0, end: 1.0);
}
