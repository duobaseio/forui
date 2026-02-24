import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/widgets/badge/badge_content.dart';

@Variants('FBadge', {
  'primary': (2, 'The primary badge style.'),
  'secondary': (2, 'The secondary badge style.'),
  'outline': (2, 'The outline badge style.'),
  'destructive': (2, 'The destructive badge style.'),
})
part 'badge.design.dart';

/// A badge. Badges are typically used to draw attention to specific information, such as labels and counts.
///
/// See:
/// * https://forui.dev/docs/data/badge for working examples.
/// * [FBadgeStyle] for customizing a badge's appearance.
class FBadge extends StatelessWidget {
  /// The variants used to resolve the style from [FBadgeStyles].
  ///
  /// Defaults to [FBadgeVariant.primary]. The current platform variant is automatically included during style
  /// resolution. To change the platform variant, update the enclosing [FTheme.platform]/[FAdaptiveScope.platform].
  ///
  /// For example, to create a destructive badge:
  /// ```dart
  /// FBadge(
  ///   variant: .destructive,
  ///   child: Text('Destructive'),
  /// )
  /// ```
  final FBadgeVariant variant;

  /// The style delta applied to the style resolved by [variant].
  ///
  /// The final style is computed by first resolving the base style from [FBadgeStyles] using [variant], then applying
  /// this delta. This allows modifying variant-specific styles:
  /// ```dart
  /// FBadge(
  ///   variant: .destructive,
  ///   style: .delta(decoration: .delta(borderRadius: .all(.circular(4)))),
  ///   child: Text('Custom destructive badge'),
  /// )
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create badge
  /// ```
  final FBadgeStyleDelta style;

  /// The builder used to build the badge's content.
  final Widget Function(BuildContext context, FBadgeStyle style) builder;

  /// Creates a [FBadge].
  FBadge({required Widget child, this.variant = .primary, this.style = const .context(), super.key})
    : builder = ((_, style) => Content(style: style, child: child));

  /// Creates a [FBadge] with a custom builder.
  const FBadge.raw({required this.builder, this.variant = .primary, this.style = const .context(), super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style(context.theme.badgeStyles.resolve({variant, context.platformVariant}));
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: DecoratedBox(decoration: style.decoration, child: builder(context, style)),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('variant', variant))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// The [FBadgeStyle]s.
extension type FBadgeStyles(FVariants<FBadgeVariantConstraint, FBadgeVariant, FBadgeStyle, FBadgeStyleDelta> _)
    implements FVariants<FBadgeVariantConstraint, FBadgeVariant, FBadgeStyle, FBadgeStyleDelta> {
  /// Creates a [FBadgeStyles] that inherits its properties.
  FBadgeStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        .from(
          FBadgeStyle(
            decoration: ShapeDecoration(
              shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.pill),
              color: colors.primary,
            ),
            contentStyle: FBadgeContentStyle(
              labelTextStyle: typography.sm.copyWith(color: colors.primaryForeground, fontWeight: .w600),
            ),
          ),
          variants: {
            [.primary]: const .delta(),
            [.secondary]: .delta(
              decoration: .shapeDelta(color: colors.secondary),
              contentStyle: .delta(labelTextStyle: .delta(color: colors.secondaryForeground)),
            ),
            [.destructive]: FBadgeStyle(
              decoration: ShapeDecoration(
                shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.pill),
                color: colors.destructive.withValues(alpha: colors.brightness == .light ? 0.1 : 0.2),
              ),
              contentStyle: FBadgeContentStyle(
                labelTextStyle: typography.sm.copyWith(color: colors.destructive, fontWeight: .w600),
              ),
            ),
            [.outline]: .delta(
              decoration: .shapeDelta(
                shape: RoundedSuperellipseBorder(
                  side: BorderSide(color: colors.border, width: style.borderWidth),
                  borderRadius: style.borderRadius.pill,
                ),
                color: colors.card,
              ),
              contentStyle: .delta(labelTextStyle: .delta(color: colors.foreground)),
            ),
          },
        ),
      );

  /// The primary badge style.
  FBadgeStyle get primary => resolve({FBadgeVariant.primary});

  /// The secondary badge style.
  FBadgeStyle get secondary => resolve({FBadgeVariant.secondary});

  /// The destructive badge style.
  FBadgeStyle get destructive => resolve({FBadgeVariant.destructive});

  /// The outline badge style.
  FBadgeStyle get outline => resolve({FBadgeVariant.outline});
}

/// A [FBadge]'s style.
final class FBadgeStyle with Diagnosticable, _$FBadgeStyleFunctions {
  /// The decoration.
  @override
  final Decoration decoration;

  /// The content's style.
  @override
  final FBadgeContentStyle contentStyle;

  /// Creates a [FBadgeStyle].
  const FBadgeStyle({required this.decoration, required this.contentStyle});
}
