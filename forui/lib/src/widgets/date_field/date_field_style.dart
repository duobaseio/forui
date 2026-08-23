import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'date_field_style.design.dart';

/// A date field's style.
class FDateFieldStyle({
  /// The date field's text-field styles.
  @override required final FTextFieldSizeStyles fieldStyles,

  /// The date field calendar's popover style.
  @override required final FPopoverStyle popoverStyle,

  /// The date field's calendar style.
  @override required final FCalendarStyle calendarStyle,
}) with Diagnosticable, _$FDateFieldStyleFunctions {
  /// Creates a [FDateFieldStyle].
  this;

  /// Creates a [FDateFieldStyle] that inherits its properties.
  new inherit({
    required FColors colors,
    required FTypography typography,
    required FIcons icons,
    required FStyle style,
    required FHapticFeedback hapticFeedback,
    required bool touch,
  }) : this(
         fieldStyles: .inherit(colors: colors, typography: typography, style: style, touch: touch),
         popoverStyle: .inherit(colors: colors, style: style),
         calendarStyle: .inherit(
           colors: colors,
           typography: typography,
           icons: icons,
           style: style,
           hapticFeedback: hapticFeedback,
           touch: touch,
         ),
       );
}
