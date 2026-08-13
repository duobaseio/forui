import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/foundation/form/form_field.dart';
import 'package:forui/src/foundation/input/input_controller.dart';
import 'package:forui/src/localizations/localization.dart';
import 'package:forui/src/localizations/localizations_en.dart';

@internal
// TODO: https://github.com/dart-lang/sdk/issues/64043
// ignore: public_member_api_docs
abstract class const Input<T>({
    required final ValueNotifier<T?> controller,
    required final FTextFieldSizeVariant size,
    required final FPlatformVariant platformVariant,
    required final Widget Function(BuildContext context, FTextFieldStyle style, Set<FTextFieldVariant> variants, Widget child) builder,
    required final Widget? label,
    required final Widget? description,
    required final Widget Function(BuildContext context, String message) errorBuilder,
    required final bool enabled,
    required final FormFieldSetter<T>? onSaved,
    required final VoidCallback? onReset,
    required final FormFieldValidator<T> validator,
    required final AutovalidateMode autovalidateMode,
    required final String? forceErrorText,
    required final FocusNode? focusNode,
    required final TextInputAction? textInputAction,
    required final TextAlign textAlign,
    required final TextAlignVertical? textAlignVertical,
    required final TextDirection? textDirection,
    required final bool autofocus,
    required final bool expands,
    required final VoidCallback? onEditingComplete,
    required final MouseCursor? mouseCursor,
    required final VoidCallback? onTap,
    required final bool canRequestFocus,
    required final Widget Function(BuildContext context, FTextFieldStyle style, Set<FTextFieldVariant> variants)? prefixBuilder,
    required final Widget Function(BuildContext context, FTextFieldStyle style, Set<FTextFieldVariant> variants)? suffixBuilder,
    required final bool clearable,
    required final FFieldClearIconBuilder<FTextFieldStyle> clearIconBuilder,
    required final FLocalizations localizations,
    required final Key? formFieldKey,
    super.key,
  }) extends StatefulWidget {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('platformVariant', platformVariant))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(ObjectFlagProperty.has('onEditingComplete', onEditingComplete))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(ObjectFlagProperty.has('onTap', onTap))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(DiagnosticsProperty('prefixBuilder', prefixBuilder))
      ..add(DiagnosticsProperty('suffixBuilder', suffixBuilder))
      ..add(FlagProperty('clearable', value: clearable, ifTrue: 'clearable'))
      ..add(ObjectFlagProperty.has('clearIconBuilder', clearIconBuilder))
      ..add(DiagnosticsProperty('localizations', localizations))
      ..add(DiagnosticsProperty('formFieldKey', formFieldKey));
  }
}

@internal
abstract class InputState<T extends Input<U>, U> extends State<T> {
  late FLocalizations localizations;
  late InputController inputController;

  @override
  void initState() {
    super.initState();
    localizations = scriptNumerals.contains(widget.localizations.localeName)
        ? FLocalizationsEn()
        : widget.localizations;
    inputController = createController();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @protected
  InputController createController();

  @override
  Widget build(BuildContext _) {
    assert(debugCheckFLocalizationsInitialized(localizations));
    return Shortcuts(
      shortcuts: const {SingleActivator(.arrowUp): AdjustIntent(1), SingleActivator(.arrowDown): AdjustIntent(-1)},
      child: Actions(
        actions: {
          AdjustIntent: CallbackAction<AdjustIntent>(onInvoke: (intent) => inputController.adjust(intent.amount)),
          ExtendSelectionByCharacterIntent: CallbackAction<ExtendSelectionByCharacterIntent>(
            onInvoke: (intent) => inputController.traverse(forward: intent.forward),
          ),
        },
        child: Field<U>(
          key: widget.formFieldKey,
          controller: widget.controller,
          enabled: widget.enabled,
          onSaved: widget.onSaved,
          onReset: widget.onReset,
          validator: (value) => switch (this.value) {
            null when inputController.text == inputController.placeholder => widget.validator(null),
            null => errorMessage,
            final value => widget.validator(value),
          },
          autovalidateMode: widget.autovalidateMode,
          forceErrorText: widget.forceErrorText,
          builder: (state) => FTextField(
            control: .managed(controller: inputController),
            size: widget.size,
            style: textFieldStyle,
            statesController: inputController.statesController,
            builder: widget.builder,
            autocorrect: false,
            // We cannot use TextInputType.number as it does not contain a done button on iOS.
            keyboardType: const .numberWithOptions(signed: true),
            minLines: 1,
            label: widget.label,
            description: widget.description,
            error: state.hasError ? widget.errorBuilder(context, state.errorText ?? '') : null,
            enabled: widget.enabled,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            textDirection: widget.textDirection,
            expands: widget.expands,
            autofocus: widget.autofocus,
            onEditingComplete: widget.onEditingComplete,
            mouseCursor: widget.mouseCursor,
            onTap: widget.onTap,
            canRequestFocus: widget.canRequestFocus,
            prefixBuilder: widget.prefixBuilder,
            suffixBuilder: widget.suffixBuilder,
            clearable: widget.clearable ? clearable : (_) => false,
            clearIconBuilder: widget.clearIconBuilder,
          ),
        ),
      ),
    );
  }

  @protected
  bool clearable(TextEditingValue value) => false;

  @protected
  FTextFieldStyle get textFieldStyle;

  @protected
  U get value;

  @protected
  String get errorMessage;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('localizations', localizations))
      ..add(DiagnosticsProperty('inputController', inputController))
      ..add(DiagnosticsProperty('textFieldStyle', textFieldStyle))
      ..add(DiagnosticsProperty('value', value))
      ..add(StringProperty('errorMessage', errorMessage));
  }
}

@internal
class AdjustIntent extends Intent {
  final int amount;

  const new(this.amount);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('amount', amount));
  }
}
