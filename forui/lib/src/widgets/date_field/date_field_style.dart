import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'date_field_style.design.dart';

/// A date field's style.
class FDateFieldStyle with Diagnosticable, _$FDateFieldStyleFunctions {
  /// The date field's textfield styles.
  @override
  final FTextFieldSizeStyles fieldStyles;

  /// The date field calendar's popover style.
  @override
  final FPopoverStyle popoverStyle;

  /// The date field's calendar style.
  @override
  final FCalendarStyle calendarStyle;

  /// Creates a [FDateFieldStyle].
  FDateFieldStyle({required this.fieldStyles, required this.popoverStyle, required this.calendarStyle});

  /// Creates a [FDateFieldStyle] that inherits its properties.
  FDateFieldStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) : this(
         fieldStyles: .inherit(colors: colors, typography: typography, style: style, touch: touch),
         popoverStyle: .inherit(colors: colors, style: style, touch: touch),
         calendarStyle: .inherit(colors: colors, typography: typography, style: style, touch: touch),
       );
}
