import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'select_style.design.dart';

/// A [FSelect]'s style.
class FSelectStyle({
  /// The select field's size styles.
  @override required final FTextFieldSizeStyles fieldStyles,

  /// The search's style.
  @override required final FSelectSearchStyle searchStyle,

  /// The content's style.
  @override required final FSelectContentStyle contentStyle,

  /// The default text style when there are no results.
  @override required final TextStyle emptyTextStyle,
}) with Diagnosticable, _$FSelectStyleFunctions {
  /// Creates a [FSelectStyle].
  this;

  /// Creates a [FSelectStyle] that inherits its properties.
  new inherit({
    required FColors colors,
    required FIcons icons,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) : this(
         fieldStyles: .inherit(colors: colors, typography: typography, style: style, touch: touch),
         searchStyle: .inherit(colors: colors, typography: typography, style: style, touch: touch),
         contentStyle: .inherit(colors: colors, icons: icons, typography: typography, style: style, touch: touch),
         emptyTextStyle: typography.body.xs,
       );
}
