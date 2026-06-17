part of '../date_field.dart';

class _CalendarDateField extends FDateField {
  final FPopoverControl popoverControl;
  final String Function(BuildContext context, DateTime value, DateFormat format) format;
  final String? hint;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool expands;
  final MouseCursor mouseCursor;
  final bool canRequestFocus;
  final bool clearable;

  _CalendarDateField({
    this.popoverControl = const .managed(),
    this.format = FDateField.defaultFormat,
    this.hint,
    this.textAlign = .start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.mouseCursor = .defer,
    this.canRequestFocus = true,
    this.clearable = false,
    super.calendar = const FDateFieldGridCalendarProperties(),
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
  }) : super._();

  @override
  State<StatefulWidget> createState() => _CalendarDatePickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popoverControl', popoverControl))
      ..add(DiagnosticsProperty('format', format))
      ..add(StringProperty('hint', hint))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(FlagProperty('clearable', value: clearable, ifTrue: 'clearable'));
  }
}

class _CalendarDatePickerState extends _FDateFieldState<_CalendarDateField> {
  final TextEditingController _textController = .new();
  late FPopoverController _popoverController;
  DateFormat? _format;

  @override
  String get _focusLabel => 'CalendarDatePicker';

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChange);
    _popoverController = widget.popoverControl.create(_handleOnPopoverChange, this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _format = .yMMMd(FLocalizations.of(context)?.localeName);
    _updateTextController();
  }

  @override
  void didUpdateWidget(covariant _CalendarDateField old) {
    super.didUpdateWidget(old);
    _popoverController = widget.popoverControl
        .update(old.popoverControl, _popoverController, _handleOnPopoverChange, this)
        .$1;
    _updateTextController();
  }

  @override
  void dispose() {
    widget.popoverControl.dispose(_popoverController, _handleOnPopoverChange);
    _textController
      ..removeListener(_onTextChange)
      ..dispose();
    super.dispose();
  }

  void _onTextChange() {
    if (_textController.text.isEmpty) {
      _selectionController.value = null;
    }
  }

  @override
  void _handleOnSelectionChange() {
    super._handleOnSelectionChange();
    _updateTextController();
  }

  void _updateTextController() {
    if (_selectionController.value case final value?) {
      _textController.text = widget.format(context, value, _format!);
    } else {
      _textController.text = '';
    }
  }

  void _handleOnPopoverChange() {
    if (_popoverController case FPopoverManagedControl(:final onChange?)) {
      onChange(_popoverController.status.isForwardOrCompleted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style(context.theme.dateFieldStyle);
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final hint = widget.hint ?? localizations.dateFieldHint;
    final onSaved = widget.onSaved;

    return Field<DateTime>(
      key: widget.formFieldKey,
      controller: _selectionController,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      onSaved: onSaved,
      onReset: widget.onReset,
      validator: widget.validator,
      builder: (state) => FTextField(
        control: .managed(controller: _textController),
        focusNode: _focus,
        size: widget.size,
        style: style.fieldStyles.resolve({widget.size, context.platformVariant}),
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: widget.textDirection,
        expands: widget.expands,
        mouseCursor: widget.mouseCursor,
        canRequestFocus: widget.canRequestFocus,
        onTap: _onTap,
        onTapAlwaysCalled: true,
        hint: hint,
        readOnly: true,
        enableInteractiveSelection: false,
        prefixBuilder: widget.prefixBuilder,
        suffixBuilder: widget.suffixBuilder,
        clearable: widget.clearable ? (value) => value.text.isNotEmpty : (_) => false,
        label: widget.label,
        description: widget.description,
        error: state.hasError ? widget.errorBuilder(context, state.errorText ?? '') : null,
        enabled: widget.enabled,
        builder: (context, _, variants, field) => _CalendarPopover(
          popoverController: _popoverController,
          calendarController: _calendarController!,
          selectionController: _selectionController,
          style: style,
          properties: widget._calendar!,
          autofocus: true,
          fieldFocusNode: _focus,
          child: CallbackShortcuts(
            bindings: {const SingleActivator(.enter): _onTap},
            child: widget.builder(context, style, variants, field),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (const {AnimationStatus.completed, AnimationStatus.reverse}.contains(_popoverController.status)) {
      _focus.requestFocus();
      _syncCalendar();
    } else {
      _focus.unfocus();
    }
    _popoverController.toggle();
  }
}

class _CalendarPopover extends StatelessWidget {
  final FCalendarController calendarController;
  final FDateSelectionController<DateTime?> selectionController;
  final FPopoverController popoverController;
  final FDateFieldStyle style;
  final FDateFieldCalendarProperties properties;
  final bool autofocus;
  final FocusNode? fieldFocusNode;
  final Widget child;

  const _CalendarPopover({
    required this.calendarController,
    required this.selectionController,
    required this.popoverController,
    required this.style,
    required this.properties,
    required this.autofocus,
    required this.fieldFocusNode,
    required this.child,
  });

  @override
  Widget build(BuildContext _) => FPopover(
    control: .managed(controller: popoverController),
    traversalEdgeBehavior: .parentScope,
    style: style.popoverStyle,
    popoverAnchor: properties.anchor,
    childAnchor: properties.fieldAnchor,
    spacing: properties.spacing,
    overflow: properties.overflow,
    offset: properties.offset,
    useViewPadding: properties.useViewPadding,
    useViewInsets: properties.useViewInsets,
    hideRegion: properties.hideRegion,
    groupId: properties.groupId,
    cutout: properties.cutout,
    cutoutBuilder: properties.cutoutBuilder,
    autofocus: autofocus,
    shortcuts: {const SingleActivator(.escape): _hide},
    popoverBuilder: (context, _) {
      final selection = FDateSelectionControl.managedSingle(controller: selectionController);
      return TextFieldTapRegion(
        child: properties.popoverBuilder(context, calendarController, popoverController, switch (properties) {
          final FDateFieldGridCalendarProperties properties => FCalendar.grid(
            control: FGridCalendarControl(controller: calendarController as FGridCalendarController),
            selectionControl: selection,
            style: style.calendarStyle,
            fixedWeeks: properties.fixedWeeks,
            dayBuilder: properties.dayBuilder,
            monthBuilder: properties.monthBuilder,
            yearBuilder: properties.yearBuilder,
            dayScrollPhysics: properties.dayScrollPhysics,
            dayScrollCacheExtent: properties.dayScrollCacheExtent,
            dayScrollBehavior: properties.dayScrollBehavior,
            monthScrollPhysics: properties.monthScrollPhysics,
            monthScrollCacheExtent: properties.monthScrollCacheExtent,
            monthScrollBehavior: properties.monthScrollBehavior,
            yearScrollPhysics: properties.yearScrollPhysics,
            yearScrollCacheExtent: properties.yearScrollCacheExtent,
            yearScrollBehavior: properties.yearScrollBehavior,
            headerBuilder: properties.headerBuilder,
            footerBuilder: properties.footerBuilder,
            onDayPress: _onDayPress(properties.onDayPress),
            onDayLongPress: properties.onDayLongPress,
          ),
          final FDateFieldGridSplitCalendarProperties properties => FCalendar.splitGrid(
            control: FGridSplitCalendarControl(controller: calendarController as FGridSplitCalendarController),
            selectionControl: selection,
            style: style.calendarStyle,
            fixedWeeks: properties.fixedWeeks,
            dayBuilder: properties.dayBuilder,
            monthBuilder: properties.monthBuilder,
            yearBuilder: properties.yearBuilder,
            dayScrollPhysics: properties.dayScrollPhysics,
            dayScrollCacheExtent: properties.dayScrollCacheExtent,
            dayScrollBehavior: properties.dayScrollBehavior,
            yearScrollPhysics: properties.yearScrollPhysics,
            yearScrollCacheExtent: properties.yearScrollCacheExtent,
            yearScrollBehavior: properties.yearScrollBehavior,
            headerBuilder: properties.headerBuilder,
            footerBuilder: properties.footerBuilder,
            onDayPress: _onDayPress(properties.onDayPress),
            onDayLongPress: properties.onDayLongPress,
          ),
          final FDateFieldWheelCalendarProperties properties => FCalendar.wheel(
            control: FWheelCalendarControl(controller: calendarController as FWheelCalendarController),
            selectionControl: selection,
            style: style.calendarStyle,
            fixedWeeks: properties.fixedWeeks,
            dayBuilder: properties.dayBuilder,
            loop: properties.loop,
            monthFlex: properties.monthFlex,
            yearFlex: properties.yearFlex,
            dayScrollPhysics: properties.dayScrollPhysics,
            dayScrollCacheExtent: properties.dayScrollCacheExtent,
            dayScrollBehavior: properties.dayScrollBehavior,
            headerBuilder: properties.headerBuilder,
            footerBuilder: properties.footerBuilder,
            onDayPress: _onDayPress(properties.onDayPress),
            onDayLongPress: properties.onDayLongPress,
          ),
        }),
      );
    },
    child: child,
  );

  FutureOr<void> Function(DateTime)? _onDayPress(FutureOr<void> Function(DateTime)? onDayPress) {
    if (!properties.autoHide && onDayPress == null) {
      return null;
    }

    return (date) async {
      await onDayPress?.call(date);
      if (properties.autoHide) {
        await _hide();
      }
    };
  }

  Future<void> _hide() async {
    fieldFocusNode?.requestFocus();
    await popoverController.hide();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('calendarController', calendarController))
      ..add(DiagnosticsProperty('selectionController', selectionController))
      ..add(DiagnosticsProperty('popoverController', popoverController))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('properties', this.properties))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('fieldFocusNode', fieldFocusNode));
  }
}
