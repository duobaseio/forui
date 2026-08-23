import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/text_field/input/input.dart';
import 'package:forui/src/widgets/text_field/obscure_text_control.dart';

/// A callback for building a field's icon.
///
/// [style] is the field's style.
/// [obscure] controls the visibility of the password.
/// [variants] is the current variants.
///
/// See [FTextField.prefixBuilder] and [FTextField.suffixBuilder].
typedef FPasswordFieldIconBuilder<T> = Widget Function(
  BuildContext context,
  T style,
  ValueNotifier<bool> obscure,
  Set<FTextFieldVariant> variants,
);

@internal
class PasswordFieldProperties({
  required final FTextFieldSizeVariant size,
  required final FTextFieldStyleDelta style,
  required final FFieldBuilder<FTextFieldStyle> builder,
  required final Widget? label,
  required final String? hint,
  required final Widget? description,
  required final Widget? error,
  required final TextMagnifierConfiguration? magnifierConfiguration,
  required final Object groupId,
  required final FocusNode? focusNode,
  required final TextInputType? keyboardType,
  required final TextInputAction textInputAction,
  required final TextCapitalization textCapitalization,
  required final TextAlign textAlign,
  required final TextAlignVertical? textAlignVertical,
  required final TextDirection? textDirection,
  required final bool autofocus,
  required final WidgetStatesController? statesController,
  required final String obscuringCharacter,
  required final bool autocorrect,
  required final SmartDashesType? smartDashesType,
  required final SmartQuotesType? smartQuotesType,
  required final bool enableSuggestions,
  required final int? minLines,
  required final int maxLines,
  required final bool expands,
  required final bool readOnly,
  required final bool? showCursor,
  required final int? maxLength,
  required final MaxLengthEnforcement? maxLengthEnforcement,
  required final GestureTapCallback? onTap,
  required final TapRegionCallback? onTapOutside,
  required final bool onTapAlwaysCalled,
  required final VoidCallback? onEditingComplete,
  required final ValueChanged<String>? onSubmit,
  required final AppPrivateCommandCallback? onAppPrivateCommand,
  required final List<TextInputFormatter>? inputFormatters,
  required final bool enabled,
  required final bool? ignorePointers,
  required final bool enableInteractiveSelection,
  required final bool? selectAllOnFocus,
  required final TextSelectionControls? selectionControls,
  required final DragStartBehavior dragStartBehavior,
  required final MouseCursor? mouseCursor,
  required final FTextFieldCounterBuilder? counterBuilder,
  required final ScrollPhysics? scrollPhysics,
  required final ScrollController? scrollController,
  required final Iterable<String> autofillHints,
  required final String? restorationId,
  required final bool stylusHandwritingEnabled,
  required final bool enableIMEPersonalizedLearning,
  required final ContentInsertionConfiguration? contentInsertionConfiguration,
  required final EditableTextContextMenuBuilder? contextMenuBuilder,
  required final bool canRequestFocus,
  required final UndoHistoryController? undoController,
  required final SpellCheckConfiguration? spellCheckConfiguration,
  required final FPasswordFieldIconBuilder<FTextFieldStyle>? prefixBuilder,
  required final FPasswordFieldIconBuilder<FTextFieldStyle>? suffixBuilder,
  required final bool Function(TextEditingValue) clearable,
  required final FFieldClearIconBuilder<FTextFieldStyle> clearIconBuilder,
  required final FObscureTextControl obscureTextControl,
}) with Diagnosticable {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty('magnifierConfiguration', magnifierConfiguration))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('keyboardType', keyboardType))
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textCapitalization', textCapitalization))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('statesController', statesController))
      ..add(StringProperty('obscuringCharacter', obscuringCharacter, defaultValue: '•'))
      ..add(FlagProperty('autocorrect', value: autocorrect, ifTrue: 'autocorrect'))
      ..add(EnumProperty('smartDashesType', smartDashesType))
      ..add(EnumProperty('smartQuotesType', smartQuotesType))
      ..add(FlagProperty('enableSuggestions', value: enableSuggestions, ifTrue: 'enableSuggestions'))
      ..add(IntProperty('minLines', minLines))
      ..add(IntProperty('maxLines', maxLines))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(FlagProperty('readOnly', value: readOnly, ifTrue: 'readOnly'))
      ..add(FlagProperty('showCursor', value: showCursor, ifTrue: 'showCursor'))
      ..add(IntProperty('maxLength', maxLength))
      ..add(EnumProperty('maxLengthEnforcement', maxLengthEnforcement))
      ..add(ObjectFlagProperty.has('onTap', onTap))
      ..add(ObjectFlagProperty.has('onTapOutside', onTapOutside))
      ..add(FlagProperty('onTapAlwaysCalled', value: onTapAlwaysCalled, ifTrue: 'onTapAlwaysCalled'))
      ..add(ObjectFlagProperty.has('onEditingComplete', onEditingComplete))
      ..add(ObjectFlagProperty.has('onSubmit', onSubmit))
      ..add(ObjectFlagProperty.has('onAppPrivateCommand', onAppPrivateCommand))
      ..add(IterableProperty('inputFormatters', inputFormatters))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('ignorePointers', value: ignorePointers, ifTrue: 'ignorePointers'))
      ..add(
        FlagProperty('enableInteractSelection', value: enableInteractiveSelection, ifTrue: 'enableInteractSelection'),
      )
      ..add(FlagProperty('selectAllOnFocus', value: selectAllOnFocus, ifTrue: 'selectAllOnFocus'))
      ..add(DiagnosticsProperty('selectionControls', selectionControls))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(ObjectFlagProperty.has('buildCounter', counterBuilder))
      ..add(DiagnosticsProperty('scrollPhysics', scrollPhysics))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(IterableProperty('autofillHints', autofillHints))
      ..add(StringProperty('restorationId', restorationId))
      ..add(
        FlagProperty('stylusHandwritingEnabled', value: stylusHandwritingEnabled, ifTrue: 'stylusHandwritingEnabled'),
      )
      ..add(
        FlagProperty(
          'enableIMEPersonalizedLearning',
          value: enableIMEPersonalizedLearning,
          ifTrue: 'enableIMEPersonalizedLearning',
        ),
      )
      ..add(DiagnosticsProperty('contentInsertionConfiguration', contentInsertionConfiguration))
      ..add(ObjectFlagProperty.has('contextMenuBuilder', contextMenuBuilder))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(DiagnosticsProperty('undoController', undoController))
      ..add(DiagnosticsProperty('spellCheckConfiguration', spellCheckConfiguration))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(ObjectFlagProperty.has('clearable', clearable))
      ..add(ObjectFlagProperty.has('clearIconBuilder', clearIconBuilder))
      ..add(DiagnosticsProperty('obscureTextControl', obscureTextControl));
  }
}

@internal
class const PasswordField({
  required final TextEditingController controller,
  required final PasswordFieldProperties properties,
  super.key,
}) extends StatefulWidget {
  @override
  State<PasswordField> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('properties', this.properties));
  }
}

class _State extends State<PasswordField> {
  late ValueNotifier<bool> _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.properties.obscureTextControl.create(_handleOnChange);
  }

  @override
  void didUpdateWidget(PasswordField old) {
    super.didUpdateWidget(old);
    _controller = widget.properties.obscureTextControl
        .update(old.properties.obscureTextControl, _controller, _handleOnChange)
        .$1;
  }

  @override
  void dispose() {
    widget.properties.obscureTextControl.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.properties.obscureTextControl case FObscureTextManagedControl(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _controller,
    builder: (context, obscured, child) => Input(
      controller: widget.controller,
      size: widget.properties.size,
      style: widget.properties.style,
      builder: widget.properties.builder,
      label: widget.properties.label,
      hint: widget.properties.hint,
      description: widget.properties.description,
      error: widget.properties.error,
      magnifierConfiguration: widget.properties.magnifierConfiguration,
      groupId: widget.properties.groupId,
      focusNode: widget.properties.focusNode,
      keyboardType: widget.properties.keyboardType,
      textInputAction: widget.properties.textInputAction,
      textCapitalization: widget.properties.textCapitalization,
      textAlign: widget.properties.textAlign,
      textAlignVertical: widget.properties.textAlignVertical,
      textDirection: widget.properties.textDirection,
      autofocus: widget.properties.autofocus,
      statesController: widget.properties.statesController,
      obscuringCharacter: widget.properties.obscuringCharacter,
      obscureText: obscured,
      autocorrect: widget.properties.autocorrect,
      smartDashesType: widget.properties.smartDashesType,
      smartQuotesType: widget.properties.smartQuotesType,
      enableSuggestions: widget.properties.enableSuggestions,
      minLines: widget.properties.minLines,
      maxLines: widget.properties.maxLines,
      expands: widget.properties.expands,
      readOnly: widget.properties.readOnly,
      showCursor: widget.properties.showCursor,
      maxLength: widget.properties.maxLength,
      maxLengthEnforcement: widget.properties.maxLengthEnforcement,
      onTap: widget.properties.onTap,
      onTapOutside: widget.properties.onTapOutside,
      onTapAlwaysCalled: widget.properties.onTapAlwaysCalled,
      onEditingComplete: widget.properties.onEditingComplete,
      onSubmit: widget.properties.onSubmit,
      onAppPrivateCommand: widget.properties.onAppPrivateCommand,
      inputFormatters: widget.properties.inputFormatters,
      enabled: widget.properties.enabled,
      ignorePointers: widget.properties.ignorePointers,
      enableInteractiveSelection: widget.properties.enableInteractiveSelection,
      selectAllOnFocus: widget.properties.selectAllOnFocus,
      selectionControls: widget.properties.selectionControls,
      dragStartBehavior: widget.properties.dragStartBehavior,
      mouseCursor: widget.properties.mouseCursor,
      counterBuilder: widget.properties.counterBuilder,
      scrollPhysics: widget.properties.scrollPhysics,
      scrollController: widget.properties.scrollController,
      autofillHints: widget.properties.autofillHints,
      restorationId: widget.properties.restorationId,
      stylusHandwritingEnabled: widget.properties.stylusHandwritingEnabled,
      enableIMEPersonalizedLearning: widget.properties.enableIMEPersonalizedLearning,
      contentInsertionConfiguration: widget.properties.contentInsertionConfiguration,
      contextMenuBuilder: widget.properties.contextMenuBuilder,
      canRequestFocus: widget.properties.canRequestFocus,
      undoController: widget.properties.undoController,
      spellCheckConfiguration: widget.properties.spellCheckConfiguration,
      prefixBuilder: widget.properties.prefixBuilder == null
          ? null
          : (context, style, variants) => widget.properties.prefixBuilder!(context, style, _controller, variants),
      suffixBuilder: widget.properties.suffixBuilder == null
          ? null
          : (context, style, variants) => widget.properties.suffixBuilder!(context, style, _controller, variants),
      clearable: widget.properties.clearable,
      clearIconBuilder: widget.properties.clearIconBuilder,
    ),
  );
}
