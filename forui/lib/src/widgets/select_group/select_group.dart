import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/foundation/form/multi_value_form_field.dart';
import 'package:forui/src/foundation/notifiers.dart';

part 'select_group.design.dart';

/// A [FSelectGroup]'s item data. Useful for creating your own [FSelectGroupItemMixin].
class FSelectGroupItemData<T> extends InheritedWidget {
  /// Return the [FSelectGroup]'s item data.
  static FSelectGroupItemData<T> of<T>(BuildContext context) {
    assert(debugCheckHasAncestor<FSelectGroupItemData<T>>('${FSelectGroup<T>}', context, generic: true));
    return context.dependOnInheritedWidgetOfExactType<FSelectGroupItemData<T>>()!;
  }

  /// The controller.
  final FMultiValueNotifier<T> controller;

  /// The style.
  final FSelectGroupStyle style;

  /// True if the [FSelectGroup] is enabled.
  final bool enabled;

  /// True if the item is selected.
  final bool selected;

  /// True if the [FSelectGroup] is in an error state.
  final bool error;

  /// The [FSelectGroup]'s item data.
  const FSelectGroupItemData({
    required this.controller,
    required this.style,
    required this.enabled,
    required this.selected,
    required this.error,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FSelectGroupItemData old) =>
      controller != old.controller ||
      style != old.style ||
      enabled != old.enabled ||
      selected != old.selected ||
      error != old.error;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(FlagProperty('error', value: error, ifTrue: 'error'));
  }
}

/// A set of items that are treated as a single selection.
///
/// Typically used to group multiple [FSelectGroupItemMixin]s.
///
/// For touch devices, a [FSelectTileGroup] is generally recommended over this.
///
/// {@macro forui.widgets.label.error_transition}
///
/// See:
/// * https://forui.dev/docs/form/select-group for working examples.
/// * [FSelectGroupStyle] for customizing a select group's appearance.
class FSelectGroup<T> extends StatefulWidget with FFormFieldProperties<Set<T>> {
  /// Defines how the select group's value is controlled.
  ///
  /// Defaults to [FMultiValueControl.managed].
  final FMultiValueControl<T>? control;

  /// The style. Defaults to [FThemeData.selectGroupStyle].
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FSelectGroupStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create select-group
  /// ```
  final FSelectGroupStyleDelta style;

  @override
  final Widget? label;

  @override
  final Widget? description;

  /// The items.
  final List<FSelectGroupItemMixin<T>> children;

  @override
  final Widget Function(BuildContext context, String message) errorBuilder;

  /// {@macro forui.foundation.FFormFieldProperties.onSaved}
  @override
  final FormFieldSetter<Set<T>>? onSaved;

  /// {@macro forui.foundation.FFormFieldProperties.onReset}
  @override
  final VoidCallback? onReset;

  /// {@macro forui.foundation.FFormFieldProperties.validator}
  @override
  final FormFieldValidator<Set<T>>? validator;

  /// {@macro forui.foundation.FFormFieldProperties.forceErrorText}
  @override
  final String? forceErrorText;

  /// Whether the form field is enabled. Defaults to true.
  @override
  final bool enabled;

  /// {@macro flutter.widgets.FormField.autovalidateMode}
  @override
  final AutovalidateMode autovalidateMode;

  /// Creates a [FSelectGroup].
  const FSelectGroup({
    required this.children,
    this.control,
    this.style = const .inherit(),
    this.label,
    this.description,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.onSaved,
    this.onReset,
    this.validator,
    this.forceErrorText,
    this.enabled = true,
    this.autovalidateMode = .disabled,
    super.key,
  });

  @override
  State<FSelectGroup<T>> createState() => _FSelectGroupState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(EnumProperty('autovalidateMode', autovalidateMode));
  }
}

class _FSelectGroupState<T> extends State<FSelectGroup<T>> {
  late FMultiValueNotifier<T> _controller;

  @override
  void initState() {
    super.initState();
    _controller = (widget.control ?? FMultiValueControl<T>.managed()).create(_handleChange);
  }

  @override
  void didUpdateWidget(covariant FSelectGroup<T> old) {
    super.didUpdateWidget(old);
    final current = widget.control ?? FMultiValueControl<T>.managed();
    final previous = old.control ?? FMultiValueControl<T>.managed();
    _controller = current.update(previous, _controller, _handleChange).$1;
  }

  void _handleChange() {
    setState(() {});
    if (widget.control case FMultiValueManagedControl(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupStyle = widget.style(context.theme.selectGroupStyle);

    return MultiValueFormField<T>(
      controller: _controller,
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      validator: widget.validator,
      forceErrorText: widget.forceErrorText,
      autovalidateMode: widget.autovalidateMode,
      builder: (state) {
        final variants = <FFormFieldVariant>{if (!widget.enabled) .disabled, if (state.errorText != null) .error};

        return FLabel(
          axis: .vertical,
          variants: variants,
          style: groupStyle,
          label: widget.label,
          description: widget.description,
          error: state.errorText == null ? null : widget.errorBuilder(context, state.errorText!),
          child: Column(
            children: [
              for (final child in widget.children)
                Padding(
                  padding: groupStyle.itemPadding,
                  child: FSelectGroupItemData<T>(
                    controller: _controller,
                    style: groupStyle,
                    selected: _controller.contains(child.value),
                    enabled: widget.enabled,
                    error: state.errorText != null,
                    child: child,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    (widget.control ?? FMultiValueControl<T>.managed()).dispose(_controller, _handleChange);
    super.dispose();
  }
}

/// [FSelectGroup]'s style.
class FSelectGroupStyle extends FLabelStyle with Diagnosticable, _$FSelectGroupStyleFunctions {
  /// The [FCheckbox]'s style.
  @override
  final FCheckboxStyle checkboxStyle;

  /// The [FRadio]'s style.
  @override
  final FRadioStyle radioStyle;

  /// The padding surrounding an item. Defaults to `EdgeInsets.symmetric(vertical: 2)`.
  @override
  final EdgeInsetsGeometry itemPadding;

  /// Creates a [FSelectGroupStyle].
  const FSelectGroupStyle({
    required this.checkboxStyle,
    required this.radioStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.itemPadding = const .symmetric(vertical: 2),
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
    super.labelMotion,
  });

  /// Creates a [FSelectGroupStyle] that inherits its properties.
  factory FSelectGroupStyle.inherit({required FColors colors, required FTypography typography, required FStyle style}) {
    final vertical = FLabelStyles.inherit(style: style).verticalStyle;

    final itemLabelTextStyle = FVariants<FFormFieldVariantConstraint, TextStyle, TextStyleDelta>.delta(
      typography.sm.copyWith(color: colors.foreground, fontWeight: .w500),
      variants: {
        [.disabled]: .delta(color: colors.disable(colors.foreground)),
        //
        [.error]: .delta(color: colors.error),
        [.error.and(.disabled)]: .delta(color: colors.disable(colors.error)),
      },
    );
    final itemDescriptionTextStyle = FVariants<FFormFieldVariantConstraint, TextStyle, TextStyleDelta>.delta(
      typography.sm.copyWith(color: colors.mutedForeground),
      variants: {
        [.disabled]: .delta(color: colors.disable(colors.mutedForeground)),
      },
    );
    final itemErrorTextStyle = FVariants<FFormFieldErrorVariantConstraint, TextStyle, TextStyleDelta>.delta(
      typography.sm.copyWith(color: colors.error, fontWeight: .w500),
      variants: {
        [.disabled]: .delta(color: colors.disable(colors.error)),
      },
    );

    return .new(
      checkboxStyle: .inherit(colors: colors, style: style).copyWith(
        labelTextStyle: .value(itemLabelTextStyle),
        descriptionTextStyle: .value(itemDescriptionTextStyle),
        errorTextStyle: .value(itemErrorTextStyle),
      ),
      radioStyle: .inherit(colors: colors, style: style).copyWith(
        labelTextStyle: .value(itemLabelTextStyle),
        descriptionTextStyle: .value(itemDescriptionTextStyle),
        errorTextStyle: .value(itemErrorTextStyle),
      ),
      labelTextStyle: style.formFieldStyle.labelTextStyle,
      descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
      errorTextStyle: style.formFieldStyle.errorTextStyle,
      labelPadding: vertical.labelPadding,
      descriptionPadding: vertical.descriptionPadding,
      errorPadding: vertical.errorPadding,
      childPadding: vertical.childPadding,
    );
  }
}
