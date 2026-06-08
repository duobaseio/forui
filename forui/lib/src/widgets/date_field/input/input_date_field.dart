part of '../date_field.dart';

class _InputDateField extends FDateField {
  final FPopoverControl popoverControl;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool expands;
  final VoidCallback? onEditingComplete;
  final ValueChanged<DateTime>? onSubmit;
  final MouseCursor? mouseCursor;
  final bool canRequestFocus;
  final bool clearable;
  final int baselineInputYear;

  _InputDateField({
    this.popoverControl = const .managed(),
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.onEditingComplete,
    this.onSubmit,
    this.mouseCursor,
    this.canRequestFocus = true,
    this.clearable = false,
    this.baselineInputYear = 2000,
    super.calendar = const FDateFieldGridCalendarProperties(),
    super.selectionControl,
    super.validator,
    super.size,
    super.style,
    super.autofocus,
    super.focusNode,
    super.builder,
    super.prefixBuilder,
    super.suffixBuilder,
    super.label,
    super.description,
    super.enabled,
    super.onSaved,
    super.onReset,
    super.autovalidateMode,
    super.forceErrorText,
    super.errorBuilder,
    super.formFieldKey,
    super.key,
  }) : super._();

  @override
  State<_InputDateField> createState() => _InputDateFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popoverControl', popoverControl))
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(ObjectFlagProperty.has('onEditingComplete', onEditingComplete))
      ..add(ObjectFlagProperty.has('onSubmit', onSubmit))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(FlagProperty('clearable', value: clearable, ifTrue: 'clearable'))
      ..add(IntProperty('baselineInputYear', baselineInputYear));
  }
}

class _InputDateFieldState extends _FDateFieldState<_InputDateField> {
  late FPopoverController _popoverController;

  @override
  String get _focusLabel => 'InputDateField';

  @override
  void initState() {
    super.initState();
    _popoverController = widget.popoverControl.create(_handleOnPopoverChange, this);
  }

  @override
  void didUpdateWidget(covariant _InputDateField old) {
    super.didUpdateWidget(old);
    _popoverController = widget.popoverControl
        .update(old.popoverControl, _popoverController, _handleOnPopoverChange, this)
        .$1;
  }

  @override
  void dispose() {
    widget.popoverControl.dispose(_popoverController, _handleOnPopoverChange);
    super.dispose();
  }

  void _handleOnPopoverChange() {
    if (_popoverController case FPopoverManagedControl(:final onChange?)) {
      onChange(_popoverController.status.isForwardOrCompleted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style(context.theme.dateFieldStyle);
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(.enter): () {
          _focus.unfocus();
          _popoverController.hide();
        },
      },
      child: DateInput(
        controller: _selectionController,
        selectionController: _selectionController,
        onTap: _popoverController.show,
        size: widget.size,
        platformVariant: context.platformVariant,
        style: style,
        label: widget.label,
        description: widget.description,
        errorBuilder: widget.errorBuilder,
        clearable: widget.clearable,
        enabled: widget.enabled,
        onSaved: widget.onSaved,
        onReset: widget.onReset,
        validator: widget.validator,
        autovalidateMode: widget.autovalidateMode,
        forceErrorText: widget.forceErrorText,
        formFieldKey: widget.formFieldKey,
        focusNode: _focus,
        textInputAction: widget.textInputAction,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: widget.textDirection,
        expands: widget.expands,
        autofocus: widget.autofocus,
        onEditingComplete: widget.onEditingComplete,
        mouseCursor: widget.mouseCursor,
        canRequestFocus: widget.canRequestFocus,
        prefixBuilder: widget.prefixBuilder,
        suffixBuilder: widget.suffixBuilder,
        localizations: FLocalizations.of(context) ?? FDefaultLocalizations(),
        baselineYear: widget.baselineInputYear,
        builder: (context, _, variants, child) => _CalendarPopover(
          calendarController: _calendarController!,
          selectionController: _selectionController,
          popoverController: _popoverController,
          style: style,
          properties: widget._calendar!,
          autofocus: false,
          fieldFocusNode: null,
          child: widget.builder(context, style, variants, child),
        ),
      ),
    );
  }
}

class _InputOnlyDateField extends FDateField {
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool expands;
  final VoidCallback? onEditingComplete;
  final ValueChanged<DateTime>? onSubmit;
  final MouseCursor? mouseCursor;
  final bool canRequestFocus;
  final bool clearable;
  final int baselineInputYear;

  _InputOnlyDateField({
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.onEditingComplete,
    this.onSubmit,
    this.mouseCursor,
    this.canRequestFocus = true,
    this.clearable = false,
    this.baselineInputYear = 2000,
    super.selectionControl,
    super.size,
    super.style,
    super.autofocus,
    super.focusNode,
    super.builder,
    super.prefixBuilder,
    super.suffixBuilder,
    super.label,
    super.description,
    super.enabled,
    super.onSaved,
    super.onReset,
    super.autovalidateMode,
    super.forceErrorText,
    super.validator,
    super.errorBuilder,
    super.formFieldKey,
    super.key,
  }) : super._(calendar: null);

  @override
  State<_InputOnlyDateField> createState() => _InputOnlyDateFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(ObjectFlagProperty.has('onEditingComplete', onEditingComplete))
      ..add(ObjectFlagProperty.has('onSubmit', onSubmit))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(FlagProperty('clearable', value: clearable, ifTrue: 'clearable'))
      ..add(IntProperty('baselineInputYear', baselineInputYear));
  }
}

class _InputOnlyDateFieldState extends _FDateFieldState<_InputOnlyDateField> {
  @override
  String get _focusLabel => 'InputOnlyDateField';

  @override
  Widget build(BuildContext context) {
    final style = widget.style(context.theme.dateFieldStyle);
    return DateInput(
      controller: _selectionController,
      selectionController: _selectionController,
      onTap: null,
      size: widget.size,
      platformVariant: context.platformVariant,
      style: style,
      label: widget.label,
      description: widget.description,
      errorBuilder: widget.errorBuilder,
      clearable: widget.clearable,
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      onReset: widget.onReset,
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      validator: widget.validator,
      formFieldKey: widget.formFieldKey,
      focusNode: _focus,
      textInputAction: widget.textInputAction,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      expands: widget.expands,
      autofocus: widget.autofocus,
      onEditingComplete: widget.onEditingComplete,
      mouseCursor: widget.mouseCursor,
      canRequestFocus: widget.canRequestFocus,
      prefixBuilder: widget.prefixBuilder,
      suffixBuilder: widget.suffixBuilder,
      localizations: FLocalizations.of(context) ?? FDefaultLocalizations(),
      baselineYear: widget.baselineInputYear,
      builder: (context, _, variants, child) => widget.builder(context, style, variants, child),
    );
  }
}
