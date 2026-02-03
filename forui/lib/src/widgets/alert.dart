import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FAlert', {'destructive': (2, 'The destructive alert style.')})
part 'alert.design.dart';

/// A visual element displaying status information (info, warning, success, or error).
///
/// Use alerts to communicate statuses, provide feedback, or convey important contextual information.
///
/// See:
/// * https://forui.dev/docs/feedback/alert for working examples.
/// * [FAlertStyle] for customizing an alert's appearance.
class FAlert extends StatelessWidget {
  /// The variants used to resolve the style from [FAlertStyles].
  ///
  /// Defaults to an empty set, which resolves to the base (primary) style. The current platform variant is automatically
  /// included during style resolution. To change the platform variant, update the enclosing
  /// [FTheme.platform]/[FAdaptiveScope.platform].
  ///
  /// For example, to create a destructive alert:
  /// ```dart
  /// FAlert(
  ///  variant: {.destructive},
  ///  title: Text('This is a destructive alert'),
  ///  )
  ///  ```
  final Set<FAlertVariant> variants;

  /// The style delta applied to the style resolved by [variants].
  ///
  /// The final style is computed by first resolving the base style from [FAlertStyles] using [variants], then applying
  /// this delta. This allows modifying variant-specific styles:
  /// ```dart
  /// FAlert(
  ///   variant: {.destructive},
  ///   style: .delta(iconStyle: .delta(size: 24)), // modifies the destructive style
  ///   title: Text('Large icon destructive alert'),
  /// )
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create alert
  /// ```
  final FAlertStyleDelta style;

  /// The title of the alert.
  final Widget title;

  /// The subtitle of the alert.
  final Widget? subtitle;

  /// The icon displayed on the left side of the alert.
  final Widget icon;

  /// Creates a [FAlert] with a title, subtitle, and icon.
  ///
  /// The alert's layout is as follows:
  /// ```diagram
  /// |---------------------------|
  /// |  [icon]  [title]          |
  /// |          [subtitle]       |
  /// |---------------------------|
  /// ```
  const FAlert({
    required this.title,
    this.icon = const Icon(FIcons.circleAlert),
    this.subtitle,
    this.variants = const {},
    this.style = const .inherit(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style(context.theme.alertStyles.resolve({...variants, context.platformVariant}));
    return DecoratedBox(
      decoration: style.decoration,
      child: Padding(
        padding: style.padding,
        child: Column(
          mainAxisSize: .min,
          children: [
            Row(
              children: [
                IconTheme(data: style.iconStyle, child: icon),
                Flexible(
                  child: Padding(
                    padding: const .only(left: 8),
                    child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
                  ),
                ),
              ],
            ),
            if (subtitle case final subtitle?)
              Row(
                children: [
                  SizedBox(width: style.iconStyle.size),
                  Flexible(
                    child: Padding(
                      padding: const .only(top: 3, left: 8),
                      child: DefaultTextStyle.merge(style: style.subtitleTextStyle, child: subtitle),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty('variant', variants))
      ..add(DiagnosticsProperty('style', style));
  }
}

/// The alert styles.
extension type FAlertStyles._(FVariants<FAlertVariantConstraint, FAlertStyle, FAlertStyleDelta> _)
    implements FVariants<FAlertVariantConstraint, FAlertStyle, FAlertStyleDelta> {
  /// Creates a [FAlertStyles] that inherits its properties.
  FAlertStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this._(
        FVariants.delta(
          FAlertStyle(
            iconStyle: IconThemeData(color: colors.foreground, size: 20),
            titleTextStyle: typography.base.copyWith(fontWeight: .w500, color: colors.foreground, height: 1.2),
            subtitleTextStyle: typography.sm.copyWith(color: colors.foreground),
            decoration: BoxDecoration(
              border: .all(color: colors.border),
              borderRadius: style.borderRadius,
              color: colors.background,
            ),
          ),
          variants: {
            [.destructive]: .delta(
              iconStyle: .delta(color: colors.destructive),
              titleTextStyle: .delta(color: colors.destructive),
              subtitleTextStyle: .delta(color: colors.destructive),
              decoration: .delta(border: .all(color: colors.destructive)),
            ),
          },
        ),
      );
}

/// A [FAlert] style.
final class FAlertStyle with Diagnosticable, _$FAlertStyleFunctions {
  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// The padding. Defaults to `EdgeInsets.fromLTRB(16, 12, 16, 12)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The icon's style.
  @override
  final IconThemeData iconStyle;

  /// The title's [TextStyle].
  @override
  final TextStyle titleTextStyle;

  /// The subtitle's [TextStyle].
  @override
  final TextStyle subtitleTextStyle;

  /// Creates a [FAlertStyle].
  FAlertStyle({
    required this.decoration,
    required this.iconStyle,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    this.padding = const .fromLTRB(16, 12, 16, 12),
  });
}
