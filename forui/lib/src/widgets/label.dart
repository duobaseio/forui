import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'label.design.dart';

/// A component that describes a form field with a label, description, and error message (if any).
///
/// There are two different [Axis] variants for labels:
/// * [Axis.horizontal] - Used in [FCheckbox].
/// ```diagram
/// |--------------------------|
/// |  [child]  [label]        |
/// |           [description]  |
/// |           [error]        |
/// |--------------------------|
/// ```
///
/// * [Axis.vertical] - Used in [FTextField].
/// ```diagram
/// |-----------------|
/// |  [label]        |
/// |  [child]        |
/// |  [description]  |
/// |  [error]        |
/// |-----------------|
/// ```
///
/// {@template forui.widgets.label.error_transition}
/// ## Error transition caveats
/// Error transitions require either a [label] or [description] to function. In the rare case where only an [error] is
/// needed, set [label] or [description] to an empty widget, e.g. [SizedBox.shrink].
/// {@endtemplate}
///
/// See:
/// * https://forui.dev/docs/form/label for working examples.
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

  /// The axis that determines the layout direction.
  final Axis axis;

  /// Whether the child should expand to fill the available space. Defaults to false.
  ///
  /// ## Contract
  /// Only applicable when [axis] is [Axis.vertical].
  final bool expands;

  /// The label's variants.
  final Set<FFormFieldVariant> variants;

  /// The child.
  final Widget child;

  /// Creates a [FLabel].
  const FLabel({
    required this.axis,
    required this.child,
    this.style = const .inherit(),
    this.label,
    this.description,
    this.error,
    this.expands = false,
    this.variants = const {},
    super.key,
  }) : assert(axis == .vertical || !expands, 'expands can only be true when axis is vertical');

  @override
  Widget build(BuildContext context) {
    final style = this.style(switch (axis) {
      .horizontal => context.theme.labelStyles.horizontalStyle,
      .vertical => context.theme.labelStyles.verticalStyle,
    });

    // This messes up error transitions if a label and description weren't previously provided. However, it is an
    // extremely rare edge case to want an error message without a label & description.
    // In those cases, users can just set label/description to an empty SizedBox().
    if (label == null && description == null && error == null) {
      return Padding(padding: style.childPadding, child: child);
    }

    return switch (axis) {
      .horizontal => _HorizontalLabel(
        style: style,
        label: label,
        description: description,
        error: error,
        variants: variants,
        child: child,
      ),
      .vertical => _VerticalLabel(
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
      ..add(EnumProperty('axis', axis))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(IterableProperty('variants', variants));
  }
}

abstract class _Label extends StatefulWidget {
  final FLabelStyle style;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final Set<FFormFieldVariant> variants;
  final Widget child;

  const _Label({
    required this.style,
    required this.label,
    required this.description,
    required this.error,
    required this.variants,
    required this.child,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(IterableProperty('variants', variants));
  }
}

abstract class _State<T extends _Label> extends State<T> with TickerProviderStateMixin {
  late final AnimationController _sizeController;
  late final AnimationController _fadeController;
  late final CurvedAnimation _curvedSize;
  late final CurvedAnimation _curvedFade;
  late Animation<double> _fade;
  Widget? _error;

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
      _error = widget.error;
    }
  }

  void _clearError(AnimationStatus status) {
    if (_sizeController.isDismissed && _fadeController.isDismissed) {
      setState(() => _error = null);
    }
  }

  @override
  void didUpdateWidget(covariant T old) {
    super.didUpdateWidget(old);
    if (old.style.labelMotion != widget.style.labelMotion) {
      final motion = widget.style.labelMotion;
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

    if (widget.variants.contains(FFormFieldVariant.error)) {
      _error = widget.error;
      _sizeController.forward();
      _fadeController.forward();
    } else {
      _fadeController.reverse();
      _sizeController.reverse();
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  Widget _animatedError(BuildContext context, [TextHeightBehavior? behavior]) => AnimatedBuilder(
    animation: _curvedSize,
    builder: (context, child) => Align(
      alignment: AlignmentDirectional.topStart,
      heightFactor: _curvedSize.value,
      widthFactor: 1.0,
      child: child,
    ),
    child: FadeTransition(
      opacity: _fade,
      child: Padding(
        padding: widget.style.errorPadding,
        child: AnimatedDefaultTextStyle(
          style: widget.style.errorTextStyle.resolve(widget.variants),
          duration: widget.style.labelMotion.textStyleTransitionDuration,
          curve: widget.style.labelMotion.textStyleTransitionCurve,
          textHeightBehavior: behavior,
          child: _error!,
        ),
      ),
    ),
  );
}

class _HorizontalLabel extends _Label {
  const _HorizontalLabel({
    required super.style,
    required super.label,
    required super.description,
    required super.error,
    required super.variants,
    required super.child,
  });

  @override
  State<_HorizontalLabel> createState() => _HorizontalState();
}

class _HorizontalState extends _State<_HorizontalLabel> {
  @override
  Widget build(BuildContext context) => Table(
    defaultColumnWidth: const IntrinsicColumnWidth(),
    defaultVerticalAlignment: .middle,
    columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
    children: [
      TableRow(
        children: [
          TableCell(
            child: Padding(padding: widget.style.childPadding, child: widget.child),
          ),
          if (widget.label != null)
            _cell(
              padding: widget.style.labelPadding,
              textStyle: widget.style.labelTextStyle.resolve(widget.variants),
              child: widget.label,
            )
          else
            _cell(
              padding: widget.style.descriptionPadding,
              textStyle: widget.style.descriptionTextStyle.resolve(widget.variants),
              child: widget.description,
            ),
        ],
      ),
      if (widget.label != null && widget.description != null)
        TableRow(
          children: [
            const TableCell(child: SizedBox()),
            _cell(
              padding: widget.style.descriptionPadding,
              textStyle: widget.style.descriptionTextStyle.resolve(widget.variants),
              child: widget.description,
            ),
          ],
        ),
      if (_error != null)
        TableRow(
          children: [
            const TableCell(child: SizedBox()),
            TableCell(child: _animatedError(context)),
          ],
        ),
    ],
  );

  Widget _cell({required EdgeInsetsGeometry padding, required TextStyle textStyle, Widget? child}) {
    if (child == null) {
      return const TableCell(child: SizedBox());
    }

    return TableCell(
      child: Padding(
        padding: padding,
        child: AnimatedDefaultTextStyle(
          style: textStyle,
          duration: widget.style.labelMotion.textStyleTransitionDuration,
          curve: widget.style.labelMotion.textStyleTransitionCurve,
          child: child,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('style', widget.style.toString()))
      ..add(IterableProperty('variants', widget.variants));
  }
}

class _VerticalLabel extends _Label {
  final bool expands;

  const _VerticalLabel({
    required super.style,
    required super.label,
    required super.description,
    required super.error,
    required super.variants,
    required super.child,
    required this.expands,
  });

  @override
  State<_VerticalLabel> createState() => _VerticalLabelState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('expands', value: expands, ifTrue: 'expands'));
  }
}

class _VerticalLabelState extends _State<_VerticalLabel> {
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    mainAxisSize: .min,
    children: [
      if (widget.label != null)
        Padding(
          padding: widget.style.labelPadding,
          child: AnimatedDefaultTextStyle(
            style: widget.style.labelTextStyle.resolve(widget.variants),
            duration: widget.style.labelMotion.textStyleTransitionDuration,
            curve: widget.style.labelMotion.textStyleTransitionCurve,
            textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            child: widget.label!,
          ),
        ),
      if (widget.expands)
        Expanded(
          child: Padding(padding: widget.style.childPadding, child: widget.child),
        )
      else
        Padding(padding: widget.style.childPadding, child: widget.child),
      if (widget.description != null)
        Padding(
          padding: widget.style.descriptionPadding,
          child: AnimatedDefaultTextStyle(
            style: widget.style.descriptionTextStyle.resolve(widget.variants),
            duration: widget.style.labelMotion.textStyleTransitionDuration,
            curve: widget.style.labelMotion.textStyleTransitionCurve,
            textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            child: widget.description!,
          ),
        ),
      if (_error != null) _animatedError(context, const TextHeightBehavior(applyHeightToFirstAscent: false)),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('style', widget.style.toString()))
      ..add(FlagProperty('expands', value: widget.expands, ifTrue: 'expands'))
      ..add(IterableProperty('variants', widget.variants));
  }
}

/// The [FLabel]'s styles.
class FLabelStyles with Diagnosticable, _$FLabelStylesFunctions {
  /// The horizontal label's style.
  @override
  final FLabelStyle horizontalStyle;

  /// The vertical label's style.
  @override
  final FLabelStyle verticalStyle;

  /// Creates a [FLabelStyles].
  const FLabelStyles({required this.horizontalStyle, required this.verticalStyle});

  /// Creates a [FLabelStyles] that inherits its properties.
  FLabelStyles.inherit({required FStyle style})
    : horizontalStyle = .inherit(
        style: style,
        descriptionPadding: const .only(top: 2),
        errorPadding: const .only(top: 2),
        childPadding: const .symmetric(horizontal: 8),
      ),
      verticalStyle = .inherit(
        style: style,
        labelPadding: const .only(bottom: 5),
        descriptionPadding: const .only(top: 5),
        errorPadding: const .only(top: 5),
      );
}

/// The [FLabel]'s style.
class FLabelStyle extends FFormFieldStyle with _$FLabelStyleFunctions {
  /// The label's padding.
  @override
  final EdgeInsetsGeometry labelPadding;

  /// The description's padding.
  @override
  final EdgeInsetsGeometry descriptionPadding;

  /// The error's padding.
  @override
  final EdgeInsetsGeometry errorPadding;

  /// The child's padding.
  @override
  final EdgeInsetsGeometry childPadding;

  /// The motion properties for error animations.
  @override
  final FLabelMotion labelMotion;

  /// Creates a [FLabelStyle].
  const FLabelStyle({
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.labelPadding = .zero,
    this.descriptionPadding = .zero,
    this.errorPadding = .zero,
    this.childPadding = .zero,
    this.labelMotion = const FLabelMotion(),
  });

  /// Creates a [FLabelStyle].
  FLabelStyle.inherit({
    required FStyle style,
    this.labelPadding = .zero,
    this.descriptionPadding = .zero,
    this.errorPadding = .zero,
    this.childPadding = .zero,
    this.labelMotion = const FLabelMotion(),
  }) : super(
         labelTextStyle: style.formFieldStyle.labelTextStyle,
         descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
         errorTextStyle: style.formFieldStyle.errorTextStyle,
       );
}

/// Motion-related properties for [FLabel] animations.
class FLabelMotion with Diagnosticable, _$FLabelMotionFunctions {
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

  /// The text style transition duration. Defaults to 100ms.
  @override
  final Duration textStyleTransitionDuration;

  /// The text style transition curve. Defaults to [Curves.linear].
  @override
  final Curve textStyleTransitionCurve;

  /// The error expansion duration. Defaults to 100ms.
  @override
  final Duration errorExpandDuration;

  /// The error collapse duration. Defaults to 100ms.
  @override
  final Duration errorCollapseDuration;

  /// The error expansion curve. Defaults to [Curves.easeOut].
  @override
  final Curve errorExpandCurve;

  /// The error collapse curve. Defaults to [Curves.easeOut].
  @override
  final Curve errorCollapseCurve;

  /// The error fade in duration. Defaults to 100ms.
  @override
  final Duration errorFadeInDuration;

  /// The error fade out duration. Defaults to 100ms.
  @override
  final Duration errorFadeOutDuration;

  /// The error fade in curve. Defaults to [Curves.linear].
  @override
  final Curve errorFadeInCurve;

  /// The error fade out curve. Defaults to [Curves.linear].
  @override
  final Curve errorFadeOutCurve;

  /// The error fade tween. Defaults to [defaultErrorFadeTween].
  ///
  /// Set to [noErrorFadeTween] to disable the fade effect.
  @override
  final Animatable<double> errorFadeTween;

  /// Creates a [FLabelMotion].
  const FLabelMotion({
    this.textStyleTransitionDuration = const Duration(milliseconds: 100),
    this.textStyleTransitionCurve = Curves.linear,
    this.errorExpandDuration = const Duration(milliseconds: 100),
    this.errorCollapseDuration = const Duration(milliseconds: 100),
    this.errorExpandCurve = Curves.easeOut,
    this.errorCollapseCurve = Curves.easeOut,
    this.errorFadeInDuration = const Duration(milliseconds: 100),
    this.errorFadeOutDuration = const Duration(milliseconds: 100),
    this.errorFadeInCurve = Curves.linear,
    this.errorFadeOutCurve = Curves.linear,
    this.errorFadeTween = defaultErrorFadeTween,
  });
}
