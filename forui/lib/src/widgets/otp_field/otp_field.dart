import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/widgets/otp_field/otp_field_control.dart';
import 'package:forui/src/widgets/text_field/input/form_input.dart';

/// Provides the [FOtpFieldStyle] to descendants.
class FOtpFieldScope extends InheritedWidget {
  /// Returns the [FOtpFieldScope] from the enclosing [FOtpField].
  static FOtpFieldScope of(BuildContext context) {
    assert(debugCheckHasAncestor<FOtpFieldScope>('$FOtpField', context));
    return context.dependOnInheritedWidgetOfExactType<FOtpFieldScope>()!;
  }

  /// The style.
  final FOtpFieldStyle style;

  /// The current variants.
  final Set<FTextFieldVariant> variants;

  /// Creates a [FOtpFieldScope].
  const FOtpFieldScope({required this.style, required this.variants, required super.child, super.key});

  @override
  bool updateShouldNotify(FOtpFieldScope old) => style != old.style || !setEquals(variants, old.variants);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(IterableProperty('variants', variants));
  }
}

/// A one-time password input field.
///
/// It is a [FormField] and therefore can be used in a [Form] widget.
///
/// To add a divider in the middle:
/// ```dart
/// FOtpField(
///   control: .managed(
///     children: [FOtpItem(), FOtpItem(), FOtpItem(), FOtpDivider(), FOtpItem(), FOtpItem(), FOtpItem()],
///   ),
/// )
/// ```
///
/// See:
/// * [FOtpController] for customizing the behavior of an OTP field.
/// * [FOtpFieldStyle] for customizing the appearance of an OTP field.
class FOtpField extends StatefulWidget with FFormFieldProperties<String> {
  /// The default input formatters that restrict input to digits only.
  static final List<TextInputFormatter> defaultInputFormatters = [FilteringTextInputFormatter.digitsOnly];

  /// The default builder that returns the child as-is.
  static Widget defaultBuilder(
    BuildContext context,
    FOtpFieldStyle style,
    Set<FTextFieldVariant> variants,
    Widget child,
  ) => child;

  /// Defines how the OTP field's state is controlled.
  ///
  /// Defaults to [FOtpFieldControl.managed].
  final FOtpFieldControl control;

  /// The style.
  final FOtpFieldStyleDelta style;

  /// {@macro forui.text_field.builder}
  final FFieldBuilder<FOtpFieldStyle> builder;

  @override
  final Widget? label;

  @override
  final Widget? description;

  /// {@macro forui.text_field.magnifier_configuration}
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// {@macro forui.text_field_groupId}
  final Object groupId;

  /// {@macro forui.text_field.focusNode}
  final FocusNode? focusNode;

  /// The type of keyboard to use for editing the text. Defaults to [TextInputType.text].
  final TextInputType? keyboardType;

  /// {@macro forui.text_field.textInputAction}
  final TextInputAction? textInputAction;

  /// {@macro forui.text_field.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro forui.text_field.textDirection}
  final TextDirection? textDirection;

  /// {@macro forui.text_field.autofocus}
  final bool autofocus;

  /// {@macro forui.text_field.statesController}
  final WidgetStatesController? statesController;

  /// {@macro forui.text_field.readOnly}
  final bool readOnly;

  /// {@macro forui.text_field.onTap}
  final GestureTapCallback? onTap;

  /// {@macro forui.text_field.onTapOutside}
  final TapRegionCallback? onTapOutside;

  /// {@macro forui.text_field.onTapAlwaysCalled}
  final bool onTapAlwaysCalled;

  /// {@macro forui.text_field.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro forui.text_field.onSubmit}
  final ValueChanged<String>? onSubmit;

  /// {@macro forui.text_field.onAppPrivateCommand}
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// {@macro forui.text_field.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  @override
  final bool enabled;

  /// {@macro forui.text_field.ignorePointers}
  final bool? ignorePointers;

  /// {@macro forui.text_field.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro forui.text_field.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro forui.text_field.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro forui.text_field.mouseCursor}
  final MouseCursor? mouseCursor;

  /// {@macro forui.text_field.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro forui.text_field.restorationId}
  final String? restorationId;

  /// {@macro forui.text_field.stylusHandwritingEnabled}
  final bool stylusHandwritingEnabled;

  /// {@macro forui.text_field.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro forui.text_field.contentInsertionConfiguration}
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// {@macro forui.text_field.contextMenuBuilder}
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// {@macro forui.text_field.canRequestFocus}
  final bool canRequestFocus;

  /// {@macro forui.text_field.undoController}
  final UndoHistoryController? undoController;

  @override
  final FormFieldSetter<String>? onSaved;

  @override
  final VoidCallback? onReset;

  @override
  final FormFieldValidator<String>? validator;

  @override
  final AutovalidateMode autovalidateMode;

  @override
  final String? forceErrorText;

  @override
  final Widget Function(BuildContext context, String message) errorBuilder;

  /// {@macro forui.foundation.doc_templates.formFieldKey}
  final Key? formFieldKey;

  /// Creates an [FOtpField].
  FOtpField({
    this.control = const .managed(),
    this.style = const .context(),
    this.builder = defaultBuilder,
    this.label,
    this.description,
    this.magnifierConfiguration,
    this.groupId = EditableText,
    this.focusNode,
    this.keyboardType = .text,
    this.textInputAction = .done,
    this.textCapitalization = .none,
    this.textDirection,
    this.autofocus = false,
    this.statesController,
    this.readOnly = false,
    this.onTap,
    this.onTapOutside,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    List<TextInputFormatter>? inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = .start,
    this.mouseCursor,
    this.autofillHints = const [AutofillHints.oneTimeCode],
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.onSaved,
    this.onReset,
    this.validator,
    this.autovalidateMode = .disabled,
    this.forceErrorText,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.formFieldKey,
    super.key,
  }) : inputFormatters = inputFormatters ?? defaultInputFormatters;

  @override
  State<FOtpField> createState() => _FOtpFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(DiagnosticsProperty('magnifierConfiguration', magnifierConfiguration))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('keyboardType', keyboardType))
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textCapitalization', textCapitalization))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('statesController', statesController))
      ..add(FlagProperty('readOnly', value: readOnly, ifTrue: 'readOnly'))
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
        FlagProperty(
          'enableInteractiveSelection',
          value: enableInteractiveSelection,
          ifTrue: 'enableInteractiveSelection',
        ),
      )
      ..add(DiagnosticsProperty('selectionControls', selectionControls))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
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
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(DiagnosticsProperty('formFieldKey', formFieldKey, level: .debug));
  }
}

class _FOtpFieldState extends State<FOtpField> {
  late FOtpController _controller;
  late WidgetStatesController _statesController;

  // The error widget cannot be computed inline because `_statesController` is updated one frame after `build`. When
  // transitioning from error → non-error, this causes the build method to be called once with an error variant but no
  // error widget, causing a layout "jump" and the error text disappearing immediately instead of fading out.
  Widget _error = const SizedBox();

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleOnChange);
    _statesController = widget.statesController ?? .new();
    _statesController.addListener(_handleStatesChange);
  }

  @override
  void didUpdateWidget(covariant FOtpField old) {
    super.didUpdateWidget(old);
    _controller = widget.control.update(old.control, _controller, _handleOnChange).$1;

    if (widget.statesController != old.statesController) {
      if (old.statesController == null) {
        _statesController.dispose();
      } else {
        _statesController.removeListener(_handleStatesChange);
      }

      _statesController = widget.statesController ?? .new();
      _statesController.addListener(_handleStatesChange);
    }
  }

  @override
  void dispose() {
    if (widget.statesController == null) {
      _statesController.dispose();
    } else {
      _statesController.removeListener(_handleStatesChange);
    }
    widget.control.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.control case FOtpFieldManagedControl(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  void _handleStatesChange() => SchedulerBinding.instance.addPostFrameCallback((_) {
    if (mounted) {
      setState(() {});
    }
  });

  @override
  Widget build(BuildContext context) {
    final style = widget.style(context.theme.otpFieldStyle);
    final variants = toTextFieldVariants(context.platformVariant, _statesController.value);

    return FormInput(
      key: widget.formFieldKey,
      controller: _controller,
      initialValue: _controller.text,
      onSaved: widget.onSaved,
      onReset: widget.onReset,
      validator: widget.validator,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      restorationId: widget.restorationId,
      builder: (state) {
        final errorText = state.errorText;
        final error = errorText == null ? null : widget.errorBuilder(state.context, errorText);
        if (error != null) {
          _error = error;
        }

        /// A stripped down version of the input used by [FTextField].
        final textfield = IntrinsicWidth(
          child: CallbackShortcuts(
            bindings: {
              const SingleActivator(.arrowLeft): () => _controller.traverse(forward: false),
              const SingleActivator(.arrowRight): () => _controller.traverse(forward: true),
            },
            child: FOtpFieldScope(
              style: style,
              variants: variants,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  // This is necessary to prevent the TextField's height from shrinking to the textstyle's height.
                  border: WidgetStateInputBorder.resolveWith(
                    (_) => const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), gapPadding: 0),
                  ),
                  constraints: .tightFor(height: style.itemSize.height),
                  contentPadding: .zero,
                  error: error == null ? null : const SizedBox(),
                ),
                focusNode: widget.focusNode,
                undoController: widget.undoController,
                cursorErrorColor: style.cursorColor,
                cursorWidth: style.cursorWidth,
                cursorOpacityAnimates:
                    style.cursorOpacityAnimates ??
                    (context.platformVariant == .iOS || context.platformVariant == .macOS),
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                textDirection: widget.textDirection,
                readOnly: widget.readOnly,
                showCursor: false,
                autofocus: widget.autofocus,
                statesController: _statesController,
                autocorrect: false,
                enableSuggestions: false,
                onTap: widget.onTap,
                onTapOutside: widget.onTapOutside,
                onTapAlwaysCalled: widget.onTapAlwaysCalled,
                onEditingComplete: widget.onEditingComplete,
                onSubmitted: widget.onSubmit,
                onAppPrivateCommand: widget.onAppPrivateCommand,
                inputFormatters: widget.inputFormatters,
                enabled: widget.enabled,
                ignorePointers: widget.ignorePointers,
                enableInteractiveSelection: widget.enableInteractiveSelection,
                keyboardAppearance: style.keyboardAppearance,
                scrollPadding: .zero,
                dragStartBehavior: widget.dragStartBehavior,
                mouseCursor: widget.mouseCursor,
                selectAllOnFocus: false,
                selectionControls: widget.selectionControls,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                autofillHints: widget.autofillHints,
                restorationId: widget.restorationId,
                stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
                enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
                contentInsertionConfiguration: widget.contentInsertionConfiguration,
                contextMenuBuilder: widget.contextMenuBuilder,
                canRequestFocus: widget.canRequestFocus,
                magnifierConfiguration: widget.magnifierConfiguration,
                groupId: widget.groupId,
              ),
            ),
          ),
        );

        Widget field = FLabel(
          layout: .vertical,
          variants: variants as Set<FFormFieldVariant>,
          label: widget.label,
          style: style,
          description: widget.description,
          error: _error,
          child: widget.builder(context, style, variants, textfield),
        );

        field = MergeSemantics(
          child: Material(
            color: Colors.transparent,
            child: Theme(
              data: Theme.of(context).copyWith(
                visualDensity: .standard,
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.transparent,
                  selectionColor: Colors.transparent,
                  selectionHandleColor: style.cursorColor,
                ),
              ),
              child: CupertinoTheme(
                data: CupertinoTheme.of(context).copyWith(primaryColor: style.cursorColor),
                child: field,
              ),
            ),
          ),
        );

        final materialLocalizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
        if (materialLocalizations == null) {
          field = Localizations(
            locale: Localizations.maybeLocaleOf(context) ?? const Locale('en', 'US'),
            delegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            child: field,
          );
        }

        return field;
      },
    );
  }
}
