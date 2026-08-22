import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'time_field_style.design.dart';

/// A time field's style.
class FTimeFieldStyle({
  /// The time field's text field size styles.
  @override required final FTextFieldSizeStyles fieldStyles,

  /// The time field picker's popover style.
  @override required final FPopoverStyle popoverStyle,

  /// The time field's picker style.
  @override required final FTimePickerStyle pickerStyle,
}) with Diagnosticable, _$FTimeFieldStyleFunctions {
  /// Creates a [FTimeFieldStyle].
  this;

  /// Creates a [FTimeFieldStyle] that inherits its properties.
  new inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required FHapticFeedback hapticFeedback,
    required bool touch,
  }) : this(
         fieldStyles: .inherit(colors: colors, typography: typography, style: style, touch: touch),
         popoverStyle: .inherit(colors: colors, style: style),
         pickerStyle: .inherit(
           colors: colors,
           typography: typography,
           style: style,
           hapticFeedback: hapticFeedback,
           touch: touch,
         ),
       );
}
