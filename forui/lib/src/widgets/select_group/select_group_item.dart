import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// Represents an item in a [FSelectGroup].
mixin FSelectGroupItemMixin<T> on Widget {
  /// Creates a [FCheckbox] that is part of a [FSelectGroup].
  static FSelectGroupItemMixin<T> checkbox<T>({
    required T value,
    FCheckboxStyle? style,
    Widget? label,
    Widget? description,
    Widget? error,
    String? semanticsLabel,
    bool? enabled,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
  }) => _Checkbox(
    value: value,
    style: style,
    label: label,
    description: description,
    error: error,
    semanticsLabel: semanticsLabel,
    enabled: enabled,
    autofocus: autofocus,
    focusNode: focusNode,
    onFocusChange: onFocusChange,
  );

  /// Creates a [FRadio] that is part of a [FSelectGroup].
  static FSelectGroupItemMixin<T> radio<T>({
    required T value,
    Widget? label,
    Widget? description,
    Widget? error,
    String? semanticsLabel,
    FRadioStyle? style,
    bool? enabled,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
  }) => _Radio<T>(
    value: value,
    label: label,
    description: description,
    error: error,
    semanticsLabel: semanticsLabel,
    style: style,
    enabled: enabled,
    autofocus: autofocus,
    focusNode: focusNode,
    onFocusChange: onFocusChange,
  );

  /// The value.
  T get value;
}

class _Checkbox<T> extends StatelessWidget with FSelectGroupItemMixin<T> {
  @override
  final T value;
  final FCheckboxStyle? style;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final String? semanticsLabel;
  final bool? enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;

  const _Checkbox({
    required this.value,
    this.style,
    this.label,
    this.description,
    this.error,
    this.semanticsLabel,
    this.enabled,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FSelectGroupItemData(:controller, :style, :enabled, :selected, :error) = .of<T>(context);
    final checkboxStyle = this.style ?? style.checkboxStyle;
    return FCheckbox(
      style: checkboxStyle,
      label: label,
      description: description,
      semanticsLabel: semanticsLabel,
      enabled: this.enabled ?? enabled,
      value: selected,
      onChange: (state) => controller.update(value, add: state),
      error: this.error ?? (error ? const SizedBox.shrink() : null),
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      key: key,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(DiagnosticsProperty('value', value))
      ..add(FlagProperty('autofocus', value: autofocus, ifFalse: 'not autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

class _Radio<T> extends StatelessWidget with FSelectGroupItemMixin<T> {
  @override
  final T value;
  final FRadioStyle? style;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final String? semanticsLabel;
  final bool? enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;

  const _Radio({
    required this.value,
    this.style,
    this.label,
    this.description,
    this.error,
    this.semanticsLabel,
    this.enabled,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FSelectGroupItemData(:controller, :selected, :style, :enabled, :error) = .of<T>(context);
    final radioStyle = this.style ?? style.radioStyle;

    return FRadio(
      style: radioStyle,
      label: label,
      description: description,
      semanticsLabel: semanticsLabel,
      enabled: this.enabled ?? enabled,
      value: selected,
      onChange: (state) => controller.update(value, add: state),
      error: this.error ?? (error ? const SizedBox.shrink() : null),
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      key: key,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(DiagnosticsProperty('value', value))
      ..add(FlagProperty('autofocus', value: autofocus, ifFalse: 'not autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}
