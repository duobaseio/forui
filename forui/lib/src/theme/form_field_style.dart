import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@Variants('FFormField', {
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
  'error': (2, 'The semantic variant when this widget is in an error state.'),
})
@Variants('FFormFieldError', {
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
})
part 'form_field_style.design.dart';

/// A form field state's style.
class FFormFieldStyle with Diagnosticable, _$FFormFieldStyleFunctions {
  /// The label's text style.
  @override
  final FVariants<FFormFieldVariantConstraint, TextStyle, TextStyleDelta> labelTextStyle;

  /// The description's text style.
  @override
  final FVariants<FFormFieldVariantConstraint, TextStyle, TextStyleDelta> descriptionTextStyle;

  /// The error's text style.
  @override
  final FVariants<FFormFieldErrorVariantConstraint, TextStyle, TextStyleDelta> errorTextStyle;

  /// Creates a [FFormFieldStyle].
  const FFormFieldStyle({
    required this.labelTextStyle,
    required this.descriptionTextStyle,
    required this.errorTextStyle,
  });

  /// Creates a [FFormFieldStyle] that inherits its properties.
  FFormFieldStyle.inherit({required FColors colors, required FTypography typography})
    : labelTextStyle = .delta(
        typography.sm.copyWith(color: colors.primary, fontWeight: .w600),
        variants: {
          [.error]: .delta(color: colors.error),
          [.disabled]: .delta(color: colors.disable(colors.primary)),
          [.disabled.and(.error)]: .delta(color: colors.disable(colors.error)),
        },
      ),
      descriptionTextStyle = .delta(
        typography.sm.copyWith(color: colors.mutedForeground),
        variants: {
          [.disabled]: .delta(color: colors.disable(colors.mutedForeground)),
        },
      ),
      errorTextStyle = .delta(
        typography.sm.copyWith(color: colors.error, fontWeight: .w600),
        variants: {
          [.disabled]: .delta(color: colors.disable(colors.error)),
        },
      );
}
