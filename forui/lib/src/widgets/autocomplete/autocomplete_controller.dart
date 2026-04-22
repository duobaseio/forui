import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/widgets/autocomplete/autocomplete.dart';

part 'autocomplete_controller.control.dart';

/// A controller for managing autocomplete functionality in a text field.
class FAutocompleteController<T> extends FTypeaheadController<T> {
  static String _defaultDisplayStringForOption<T>(T option) => option.toString();

  /// Creates a [FAutocompleteController] with an optional initial text and suggestions.
  FAutocompleteController({super.text, super.suggestions = const [], String Function(T option)? displayStringForOption})
    : super(
        displayStringForOption: displayStringForOption ?? _defaultDisplayStringForOption,
        textStyles: (context) {
          final AutocompleteFieldScope(:style, :variants) = .of(context);
          return (
            style.contentTextStyle.resolve(variants),
            style.composingTextStyle.resolve(variants),
            style.typeaheadTextStyle.resolve(variants),
          );
        },
      );

  /// Creates a [FAutocompleteController] from a [TextEditingValue].
  FAutocompleteController.fromValue(
    super.value, {
    super.suggestions = const [],
    String Function(T option)? displayStringForOption,
  }) : super.fromValue(
         displayStringForOption: displayStringForOption ?? _defaultDisplayStringForOption,
         textStyles: (context) {
           final AutocompleteFieldScope(:style, :variants) = .of(context);
           return (
             style.contentTextStyle.resolve(variants),
             style.composingTextStyle.resolve(variants),
             style.typeaheadTextStyle.resolve(variants),
           );
         },
       );
}

class _ProxyController<T> extends FAutocompleteController<T> {
  TextEditingValue? _unsynced;
  ValueChanged<TextEditingValue> _onChange;

  _ProxyController(super.value, this._onChange, {required super.displayStringForOption})
    : _unsynced = value,
      super.fromValue();

  void update(TextEditingValue newValue, ValueChanged<TextEditingValue> onChange) {
    _onChange = onChange;
    if (super.rawValue != newValue) {
      _unsynced = newValue;
      super.rawValue = newValue;
    } else if (_unsynced != newValue) {
      _unsynced = newValue;
      notifyListeners();
    }
  }

  @override
  set rawValue(TextEditingValue value) {
    if (super.value != value) {
      _unsynced = value;
      _onChange(value);
    }
  }
}

@internal
class InheritedAutocompleteController extends InheritedWidget {
  static InheritedAutocompleteController of(BuildContext context) {
    assert(debugCheckHasAncestor<InheritedAutocompleteController>('$FAutocomplete', context));
    return context.dependOnInheritedWidgetOfExactType<InheritedAutocompleteController>()!;
  }

  final FPopoverController popover;
  final ValueChanged<FTypeaheadSuggestion<Object?>> onPress;
  final ValueChanged<FTypeaheadSuggestion<Object?>> onFocus;

  const InheritedAutocompleteController({
    required this.popover,
    required this.onPress,
    required this.onFocus,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(InheritedAutocompleteController old) => popover != old.popover || onPress != old.onPress;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popover', popover))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onFocus', onFocus));
  }
}

/// A [FAutocompleteControl] defines how a [FAutocomplete] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FAutocompleteControl<T> with Diagnosticable, _$FAutocompleteControlMixin<T> {
  /// Creates a [FAutocompleteControl].
  const factory FAutocompleteControl.managed({
    FAutocompleteController<T>? controller,
    TextEditingValue? initial,
    ValueChanged<TextEditingValue>? onChange,
  }) = FAutocompleteManagedControl;

  /// Creates a [FAutocompleteControl] for controlling an autocomplete using lifted state.
  const factory FAutocompleteControl.lifted({
    required TextEditingValue value,
    required ValueChanged<TextEditingValue> onChange,
  }) = _Lifted;

  const FAutocompleteControl._();

  (FAutocompleteController<T>, bool) _update(
    FAutocompleteControl<T> old,
    FAutocompleteController<T> controller,
    VoidCallback callback,
    FutureOr<Iterable<T>> Function(String) filter,
    String Function(T option) displayStringForOption,
  );
}

/// A [FAutocompleteManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FAutocompleteManagedControl<T> extends FAutocompleteControl<T> with _$FAutocompleteManagedControlMixin<T> {
  /// The controller.
  @override
  final FAutocompleteController<T>? controller;

  /// The initial value. Defaults to null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final TextEditingValue? initial;

  /// Called when the value changes.
  @override
  final ValueChanged<TextEditingValue>? onChange;

  /// Creates a [FAutocompleteControl].
  const FAutocompleteManagedControl({this.controller, this.initial, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial value. Pass initial value to the controller instead.',
      ),
      super._();

  @override
  FAutocompleteController<T> createController(
    FutureOr<Iterable<T>> Function(String) _,
    String Function(T option) displayStringForOption,
  ) => controller ?? .fromValue(initial, displayStringForOption: displayStringForOption);
}

class _Lifted<T> extends FAutocompleteControl<T> with _$_LiftedMixin<T> {
  @override
  final TextEditingValue value;
  @override
  final ValueChanged<TextEditingValue> onChange;

  const _Lifted({required this.value, required this.onChange}) : super._();

  @override
  FAutocompleteController<T> createController(
    FutureOr<Iterable<T>> Function(String) _,
    String Function(T option) displayStringForOption,
  ) => _ProxyController(value, onChange, displayStringForOption: displayStringForOption);

  @override
  void _updateController(FAutocompleteController<T> controller, FutureOr<Iterable<T>> Function(String) filter) {
    (controller as _ProxyController)
      ..update(value, onChange)
      ..loadSuggestions(filter(controller.text));
  }
}
