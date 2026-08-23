import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'picker_style.design.dart';

/// [FPickerStyle]'s style.
class const FPickerStyle({
  /// The picker's text style.
  @override required final TextStyle textStyle,

  /// The selection's decoration.
  @override required final Decoration selectionDecoration,

  /// The focused outline style.
  @override required final FFocusedOutlineStyle focusedOutlineStyle,

  /// The haptic feedback for when the picker snaps to an item.
  @override required final Future<void> Function() hapticFeedback,

  /// A ratio between the diameter of the cylinder and the viewport's size. Defaults to 1.07.
  @override final double diameterRatio = 1.07,

  /// The angular compactness of the children on the wheel. Defaults to 1.
  @override final double squeeze = 1,

  /// The zoomed-in rate of the magnifier. Defaults to 1.
  @override final double magnification = 1,

  /// The opacity value applied to the wheel above and below the magnifier. Defaults to 0.25.
  @override final double overAndUnderCenterOpacity = 0.25,

  /// The spacing between the picker's wheels. Defaults to 5.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the spacing is less than 0.
  @override final double spacing = 5,

  /// The picker's text height behavior.
  @override
  final TextHeightBehavior textHeightBehavior = const TextHeightBehavior(
    applyHeightToFirstAscent: false,
    applyHeightToLastDescent: false,
  ),

  /// An amount to add to the height of the selection. Defaults to 0.
  @override final double selectionHeightAdjustment = 0,
}) with Diagnosticable, _$FPickerStyleFunctions {
  /// Creates a [FPickerStyle].
  this
    : assert(0 < diameterRatio, 'diameterRatio ($diameterRatio) must be > 0'),
      assert(0 < squeeze, 'squeeze ($squeeze) must be > 0'),
      assert(0 < magnification, 'magnification ($magnification) must be > 0'),
      assert(
        0 <= overAndUnderCenterOpacity && overAndUnderCenterOpacity <= 1,
        'overAndUnderCenterOpacity ($overAndUnderCenterOpacity) must be between 0 and 1',
      ),
      assert(spacing >= 0, 'spacing ($spacing) must be >= 0');

  /// Creates a [FPickerStyle] that inherits its properties.
  new inherit({
    required FColors colors,
    required FStyle style,
    required FTypography typography,
    required FHapticFeedback hapticFeedback,
    required bool touch,
  }) : this(
         textStyle: touch
             ? typography.body.lg.copyWith(fontWeight: .w500, height: 1.25)
             : typography.body.sm.copyWith(fontWeight: .w500),
         selectionDecoration: ShapeDecoration(
           shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md),
           color: colors.muted,
         ),
         focusedOutlineStyle: style.focusedOutlineStyle,
         hapticFeedback: hapticFeedback.selectionClick,
       );
}
