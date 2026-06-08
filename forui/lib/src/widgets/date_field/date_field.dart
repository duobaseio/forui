import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart' hide TextDirection;

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/form/form_field.dart';
import 'package:forui/src/widgets/calendar/calendar_controller.dart';
import 'package:forui/src/widgets/calendar/date_selection_controller.dart';
import 'package:forui/src/widgets/date_field/input/date_input.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';

part 'calendar/calendar_date_field.dart';

part 'input/input_date_field.dart';

/// A builder that wraps [FDateField]'s popover content.
typedef FDateFieldPopoverBuilder =
    Widget Function(
      BuildContext context,
      FCalendarController calendarController,
      FPopoverController popoverController,
      Widget content,
    );

/// A date field allows a date to be selected from a calendar, input field, or both.
///
/// A [FDateField] is internally a [FormField], therefore it can be used in a [Form].
///
/// It is recommended to use [FDateField.calendar] on touch devices and [FDateField.new]/[FDateField.input] on
/// non-touch devices.
///
/// The input field supports both arrow key navigation:
/// * Up/Down arrows: Increment/decrement values
/// * Left/Right arrows: Move between date segments
///
/// The input field does not support the following locales that use non-western numerals, it will default to English:
/// {@macro forui.localizations.scriptNumerals}
///
/// Consider providing a [validator] to perform custom date validation logic. By default, all dates are valid.
///
/// See:
/// * https://forui.dev/docs/widgets/form/date-field for working examples.
/// * [FDateSelectionControl] for controlling the selected date.
/// * [FDateFieldCalendarProperties] for choosing & customizing the calendar.
/// * [FDateFieldStyle] for customizing a date field's appearance.
abstract class FDateField extends StatefulWidget {
  /// The default prefix builder that shows a calendar icon.
  static Widget defaultIconBuilder(BuildContext context, FTextFieldStyle style, Set<FTextFieldVariant> variants) =>
      FTextField.prefixIconBuilder(context, style, variants, context.theme.icons.calendar(context));

  /// The default format for [FDateField.calendar], which formats [value] using [format].
  static String defaultFormat(BuildContext context, DateTime value, DateFormat format) => format.format(value);

  /// The default validator that always returns null, indicating all dates are valid.
  static String? defaultValidator(DateTime? _) => null;

  /// The control for managing the date field's selected date. Defaults to [FDateSelectionControl.managedSingle].
  final FDateSelectionControl<DateTime?> selectionControl;

  /// {@macro forui.text_field.size}
  final FTextFieldSizeVariant size;

  /// The style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FDateFieldStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create date-field
  /// ```
  final FDateFieldStyleDelta style;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// The builder used to decorate the date-field. It should use the given child.
  ///
  /// Defaults to returning the given child.
  final FFieldBuilder<FDateFieldStyle> builder;

  /// Builds a widget at the start of the input field that can be pressed to toggle the calendar popover. Defaults to
  /// [defaultIconBuilder].
  final FFieldIconBuilder<FTextFieldStyle>? prefixBuilder;

  /// Builds a widget at the end of the input field that can be pressed to toggle the calendar popover. Defaults to
  /// no prefix.
  final FFieldIconBuilder<FTextFieldStyle>? suffixBuilder;

  /// The label.
  final Widget? label;

  /// The description.
  final Widget? description;

  /// {@macro forui.foundation.FFormFieldProperties.errorBuilder}
  final Widget Function(BuildContext context, String message) errorBuilder;

  /// {@macro forui.foundation.FFormFieldProperties.enabled}
  final bool enabled;

  /// {@macro forui.foundation.FFormFieldProperties.onSaved}
  final FormFieldSetter<DateTime>? onSaved;

  /// {@macro forui.foundation.FFormFieldProperties.onReset}
  final VoidCallback? onReset;

  /// Used to enable/disable this checkbox auto validation and update its error text.
  ///
  /// Defaults to [AutovalidateMode.onUnfocus].
  ///
  /// If [AutovalidateMode.onUserInteraction], this checkbox will only auto-validate after its content changes. If
  /// [AutovalidateMode.always], it will auto-validate even without user interaction. If [AutovalidateMode.disabled],
  /// auto-validation will be disabled.
  final AutovalidateMode autovalidateMode;

  /// An optional property that forces the [FormFieldState] into an error state by directly setting the
  /// [FormFieldState.errorText] property without running the validator function.
  ///
  /// When the [forceErrorText] property is provided, the [FormFieldState.errorText] will be set to the provided value,
  /// causing the form field to be considered invalid and to display the error message specified.
  ///
  /// When [validator] is provided, [forceErrorText] will override any error that it returns.
  /// [validator] will not be called unless [forceErrorText] is null.
  final String? forceErrorText;

  /// Returns an error string to display if the input is invalid, or null otherwise.
  ///
  /// Defaults to always returning null.
  final FormFieldValidator<DateTime> validator;

  /// {@macro forui.foundation.doc_templates.formFieldKey}
  final Key? formFieldKey;

  final FDateFieldCalendarProperties? _calendar;

  FDateField._({
    required this._calendar,
    this.size = .md,
    this.style = const .context(),
    this.autofocus = false,
    this.focusNode,
    this.builder = FTextField.defaultBuilder,
    this.prefixBuilder = defaultIconBuilder,
    this.suffixBuilder,
    this.label,
    this.description,
    this.enabled = true,
    this.onSaved,
    this.onReset,
    this.autovalidateMode = .onUnfocus,
    this.forceErrorText,
    this.validator = defaultValidator,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.formFieldKey,
    FDateSelectionControl<DateTime?>? selectionControl,
    super.key,
  }) : selectionControl = selectionControl ?? .managedSingle();

  /// Creates a [FDateField] that allows date selection through both an input field and a calendar popover.
  ///
  /// The input field supports arrow key navigation:
  /// * Up/Down arrows: Increment/decrement values
  /// * Left/Right arrows: Move between date segments
  ///
  /// The [textInputAction] property can be used to specify the action button on the soft keyboard. The [textAlign]
  /// property is used to specify the alignment of the text within the input field.
  ///
  /// The [textAlignVertical] property is used to specify the vertical alignment of the text and can be useful when
  /// used with a prefix or suffix.
  ///
  /// The [textDirection] property can be used to specify the directionality of the text input.
  ///
  /// If [expands] is true, the input field will expand to fill its parent's height.
  ///
  /// The [onEditingComplete] callback is called when the user submits the input field, such as by pressing the done
  /// button on the keyboard.
  ///
  /// The [onSubmit] callback is called when the user submits a valid date value.
  ///
  /// The [mouseCursor] can be used to specify the cursor shown when hovering over the input field.
  ///
  /// If [canRequestFocus] is false, the input field cannot obtain focus but can still be selected.
  ///
  /// If [clearable] is true, the input field will show a clear button when a date is selected. Defaults to false.
  ///
  /// The [baselineInputYear] is used as a reference point for two-digit year input. Years will be interpreted as
  /// being within 80 years before or 20 years after this year.
  ///
  /// The [calendar] is used to customize the calendar mode, its appearance and behavior.
  ///
  /// See also:
  /// * [FDateField.calendar] - Creates a date field with only a calendar.
  /// * [FDateField.input] - Creates a date field with only an input field.
  factory FDateField({
    FDateSelectionControl<DateTime?>? selectionControl,
    FPopoverControl popoverControl,
    FTextFieldSizeVariant size,
    FDateFieldStyleDelta style,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    TextAlign textAlign,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool autofocus,
    bool expands,
    VoidCallback? onEditingComplete,
    ValueChanged<DateTime>? onSubmit,
    MouseCursor? mouseCursor,
    bool canRequestFocus,
    bool clearable,
    int baselineInputYear,
    FDateFieldCalendarProperties calendar,
    FFieldBuilder<FDateFieldStyle> builder,
    FFieldIconBuilder<FTextFieldStyle>? prefixBuilder,
    FFieldIconBuilder<FTextFieldStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    FormFieldSetter<DateTime>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    FormFieldValidator<DateTime> validator,
    Widget Function(BuildContext context, String message) errorBuilder,
    Key? formFieldKey,
    Key? key,
  }) = _InputDateField;

  /// Creates a [FDateField] that allows a date to be selected using only a calendar.
  ///
  /// The [format] customizes the appearance of the date in the input field.
  ///
  /// The [hint] is displayed when the input field is empty. Defaults to the current locale's
  /// [FLocalizations.dateFieldHint].
  ///
  /// The [textAlign] property is used to specify the alignment of the text within the input field.
  ///
  /// The [textAlignVertical] property is used to specify the vertical alignment of the text and can be useful when
  /// used with a prefix or suffix.
  ///
  /// The [textDirection] property can be used to specify the directionality of the text input.
  ///
  /// If [expands] is true, the input field will expand to fill its parent's height.
  ///
  /// The [mouseCursor] can be used to specify the cursor shown when hovering over the input field.
  ///
  /// If [canRequestFocus] is false, the input field cannot obtain focus but can still be selected.
  ///
  /// If [clearable] is true, the input field will show a clear button when a date is selected. Defaults to false.
  ///
  /// The [calendar] is used to customize the calendar mode, its appearance and behavior.
  ///
  /// See also:
  /// * [FDateField] - Creates a date field with both input field and calendar.
  /// * [FDateField.input] - Creates a date field with only an input field.
  factory FDateField.calendar({
    FDateSelectionControl<DateTime?>? selectionControl,
    FPopoverControl popoverControl,
    FTextFieldSizeVariant size,
    FDateFieldStyleDelta style,
    String Function(BuildContext context, DateTime value, DateFormat format) format,
    TextAlign textAlign,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands,
    MouseCursor mouseCursor,
    bool canRequestFocus,
    bool clearable,
    String? hint,
    bool autofocus,
    FocusNode? focusNode,
    FDateFieldCalendarProperties calendar,
    FFieldBuilder<FDateFieldStyle> builder,
    FFieldIconBuilder<FTextFieldStyle>? prefixBuilder,
    FFieldIconBuilder<FTextFieldStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    FormFieldSetter<DateTime>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    FormFieldValidator<DateTime> validator,
    Widget Function(BuildContext context, String message) errorBuilder,
    Key? formFieldKey,
    Key? key,
  }) = _CalendarDateField;

  /// Creates a date field that wraps a text input field.
  ///
  /// The [textInputAction] property can be used to specify the action button on the soft keyboard. The [textAlign]
  /// property is used to specify the alignment of the text within the input field.
  ///
  /// The [textAlignVertical] property is used to specify the vertical alignment of the text and can be useful when
  /// used with a prefix or suffix.
  ///
  /// The [textDirection] property can be used to specify the directionality of the text input.
  ///
  /// If [expands] is true, the input field will expand to fill its parent's height.
  ///
  /// The [onEditingComplete] callback is called when the user submits the input field, such as by pressing the done
  /// button on the keyboard.
  ///
  /// The [onSubmit] callback is called when the user submits a valid date value.
  ///
  /// The [mouseCursor] can be used to specify the cursor shown when hovering over the input field.
  ///
  /// If [canRequestFocus] is false, the input field cannot obtain focus but can still be selected.
  ///
  /// If [clearable] is true, the input field will show a clear button when a date is selected. Defaults to false.
  ///
  /// The [baselineInputYear] is used as a reference point for two-digit year input. Years will be interpreted as
  /// being within 80 years before or 20 years after this year.
  ///
  /// See also:
  /// * [FDateField] - Creates a date field with both input field and calendar.
  /// * [FDateField.calendar] - Creates a date field with only a calendar.
  factory FDateField.input({
    FDateSelectionControl<DateTime?>? selectionControl,
    FTextFieldSizeVariant size,
    FDateFieldStyleDelta style,
    bool autofocus,
    FocusNode? focusNode,
    FFieldBuilder<FDateFieldStyle> builder,
    FFieldIconBuilder<FTextFieldStyle>? prefixBuilder,
    FFieldIconBuilder<FTextFieldStyle>? suffixBuilder,
    TextInputAction? textInputAction,
    TextAlign textAlign,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands,
    VoidCallback? onEditingComplete,
    ValueChanged<DateTime>? onSubmit,
    MouseCursor? mouseCursor,
    bool canRequestFocus,
    bool clearable,
    int baselineInputYear,
    Widget? label,
    Widget? description,
    bool enabled,
    FormFieldSetter<DateTime>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    FormFieldValidator<DateTime> validator,
    Widget Function(BuildContext context, String message) errorBuilder,
    Key? formFieldKey,
    Key? key,
  }) = _InputOnlyDateField;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectionControl', selectionControl))
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('builder', builder))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(DiagnosticsProperty('formFieldKey', formFieldKey));
  }
}

abstract class _FDateFieldState<T extends FDateField> extends State<T> with TickerProviderStateMixin {
  late FocusNode _focus;
  late FDateSelectionController<DateTime?> _selectionController;
  FCalendarController? _calendarController;

  @override
  void initState() {
    super.initState();
    _focus = widget.focusNode ?? .new(debugLabel: _focusLabel);
    _selectionController = widget.selectionControl.create(_handleOnSelectionChange);
    _calendarController = widget._calendar?.control.create(_handleOnCalendarChange);
  }

  @override
  void didUpdateWidget(covariant T old) {
    super.didUpdateWidget(old);
    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _focus.dispose();
      }
      _focus = widget.focusNode ?? .new(debugLabel: _focusLabel);
    }
    _selectionController = widget.selectionControl
        .update(old.selectionControl, _selectionController, _handleOnSelectionChange)
        .$1;
    if (widget._calendar?.control case final control?) {
      _calendarController = control.update(old._calendar!.control, _calendarController!, _handleOnCalendarChange).$1;
    }
  }

  @override
  void dispose() {
    if (widget._calendar?.control case final control?) {
      control.dispose(_calendarController!, _handleOnCalendarChange);
    }
    widget.selectionControl.dispose(_selectionController, _handleOnSelectionChange);
    if (widget.focusNode == null) {
      _focus.dispose();
    }
    super.dispose();
  }

  void _handleOnSelectionChange() {
    if (widget.selectionControl case final FDateSelectionManagedControl control) {
      control.handleOnChange(_selectionController);
    }
  }

  void _handleOnCalendarChange() {}

  String get _focusLabel;
}
