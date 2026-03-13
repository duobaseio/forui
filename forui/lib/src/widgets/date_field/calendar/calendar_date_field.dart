part of '../date_field.dart';

// ignore: avoid_implementing_value_types
class _CalendarDateField extends FDateField implements FDateFieldCalendarProperties {
  final FPopoverControl popoverControl;
  final DateFormat? format;
  final String? hint;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool expands;
  final MouseCursor mouseCursor;
  final bool canRequestFocus;
  final bool clearable;
  @override
  final AlignmentGeometry anchor;
  @override
  final AlignmentGeometry fieldAnchor;
  @override
  final FPortalSpacing spacing;
  @override
  final FPortalOverflow overflow;
  @override
  final Offset offset;
  @override
  final bool useViewPadding;
  @override
  final bool useViewInsets;
  @override
  final FPopoverHideRegion hideRegion;
  @override
  final Object? groupId;
  @override
  final VoidCallback? onTapHide;
  @override
  final bool cutout;
  @override
  final void Function(Path path, Rect bounds) cutoutBuilder;
  @override
  final FDateFieldPopoverBuilder popoverBuilder;
  @override
  final ValueWidgetBuilder<FCalendarDayData> dayBuilder;
  @override
  final DateTime? start;
  @override
  final DateTime? end;
  @override
  final DateTime? today;
  @override
  final FCalendarPickerType initialType;
  @override
  final bool autoHide;

  const _CalendarDateField({
    this.popoverControl = const .managed(),
    this.format,
    this.hint,
    this.textAlign = .start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.mouseCursor = .defer,
    this.canRequestFocus = true,
    this.clearable = false,
    this.anchor = .topLeft,
    this.fieldAnchor = .bottomLeft,
    this.spacing = const .spacing(4),
    this.overflow = .flip,
    this.offset = .zero,
    this.useViewPadding = true,
    this.useViewInsets = true,
    this.hideRegion = .excludeChild,
    this.groupId,
    this.onTapHide,
    this.cutout = true,
    this.cutoutBuilder = FModalBarrier.defaultCutoutBuilder,
    this.popoverBuilder = FPopover.defaultPopoverBuilder,
    this.dayBuilder = FCalendar.defaultDayBuilder,
    this.start,
    this.end,
    this.today,
    this.initialType = .day,
    this.autoHide = true,
    super.control,
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
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(FlagProperty('clearable', value: clearable, ifTrue: 'clearable'))
      ..add(ObjectFlagProperty.has('popoverBuilder', popoverBuilder));
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
    _controller = widget.control.create(_handleOnChange, this);
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
    final (controller, updated) = widget.control.update(old.control, _controller, _handleOnChange, this);
    if (updated) {
      _controller = controller;
      _updateTextController();
    }
  }

  @override
  void dispose() {
    widget.popoverControl.dispose(_popoverController, _handleOnPopoverChange);
    widget.control.dispose(_controller, _handleOnChange);
    _textController
      ..removeListener(_onTextChange)
      ..dispose();
    super.dispose();
  }

  void _onTextChange() {
    if (_textController.text.isEmpty) {
      _controller.value = null;
    }
  }

  void _handleOnChange() {
    _updateTextController();
    if (widget.control case FDateFieldManagedControl(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  void _updateTextController() {
    if (_controller.value case final value?) {
      _textController.text = widget.format?.format(value) ?? _format?.format(value) ?? '';
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
      controller: _controller,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      onSaved: onSaved,
      onReset: widget.onReset,
      validator: _controller.validator,
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
          controller: _controller,
          popoverBuilder: widget.popoverBuilder,
          style: style,
          properties: widget,
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
    const {AnimationStatus.completed, AnimationStatus.reverse}.contains(_popoverController.status)
        ? _focus.requestFocus()
        : _focus.unfocus();
    _popoverController.toggle();
  }
}

class _CalendarPopover extends StatelessWidget {
  final FDateFieldController controller;
  final FPopoverController popoverController;
  final FDateFieldPopoverBuilder popoverBuilder;
  final FDateFieldStyle style;
  final FDateFieldCalendarProperties properties;
  final bool autofocus;
  final FocusNode? fieldFocusNode;
  final Widget child;

  const _CalendarPopover({
    required this.controller,
    required this.popoverController,
    required this.popoverBuilder,
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
    popoverBuilder: (context, _) => TextFieldTapRegion(
      child: popoverBuilder(
        context,
        controller,
        popoverController,
        ValueListenableBuilder(
          valueListenable: controller.calendar,
          builder: (_, value, _) => FCalendar(
            control: .managedDate(controller: controller.calendar),
            style: style.calendarStyle,
            initialMonth: switch (value) {
              null => null,
              _ when value.isBefore(properties.start ?? .utc(1900)) => properties.today,
              _ when value.isAfter(properties.end ?? .utc(2100)) => properties.today,
              _ => value,
            },
            onPress: properties.autoHide ? (_) => _hide() : null,
            dayBuilder: properties.dayBuilder,
            start: properties.start,
            end: properties.end,
            today: properties.today,
            initialType: properties.initialType,
          ),
        ),
      ),
    ),
    child: child,
  );

  void _hide() {
    fieldFocusNode?.requestFocus();
    popoverController.hide();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('popoverController', popoverController))
      ..add(ObjectFlagProperty.has('popoverBuilder', popoverBuilder))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('properties', this.properties))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('fieldFocusNode', fieldFocusNode));
  }
}
