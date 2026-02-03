import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/widgets/badge/badge_content.dart';

@Variants('FBadge', {
  'secondary': (2, 'The secondary badge style.'),
  'outline': (3, 'The outline badge style.'),
  'destructive': (4, 'The destructive badge style.'),
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
  /// Defaults to an empty set, which resolves to the base (primary) style. The current platform variant is automatically
  /// included during style resolution. To change the platform variant, update the enclosing
  /// [FTheme.platform]/[FAdaptiveScope.platform].
  ///
  /// For example, to create a destructive badge:
  /// ```dart
  /// FBadge(
  ///   variants: {.destructive},
  ///   child: Text('Destructive'),
  /// )
  /// ```
  final Set<FBadgeVariant> variants;

  /// The style delta applied to the style resolved by [variants].
  ///
  /// The final style is computed by first resolving the base style from [FBadgeStyles] using [variants], then applying
  /// this delta. This allows modifying variant-specific styles:
  /// ```dart
  /// FBadge(
  ///   variants: {.destructive},
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
  FBadge({required Widget child, this.variants = const {}, this.style = const .inherit(), super.key})
    : builder = ((_, style) => Content(style: style, child: child));

  /// Creates a [FBadge] with a custom builder.
  const FBadge.raw({required this.builder, this.variants = const {}, this.style = const .inherit(), super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style(context.theme.badgeStyles.resolve({...variants, context.platformVariant}));
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
      ..add(IterableProperty('variants', variants))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// The [FBadgeStyle]s.
extension type FBadgeStyles._(FVariants<FBadgeVariantConstraint, FBadgeStyle, FBadgeStyleDelta> _)
    implements FVariants<FBadgeVariantConstraint, FBadgeStyle, FBadgeStyleDelta> {
  /// The default border radius for badges.
  static const BorderRadius defaultBadgeRadius = BorderRadius.all(Radius.circular(100));

  /// Creates a [FBadgeStyles] that inherits its properties.
  FBadgeStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this._(
        FVariants.delta(
          FBadgeStyle(
            decoration: BoxDecoration(color: colors.primary, borderRadius: defaultBadgeRadius),
            contentStyle: FBadgeContentStyle(
              labelTextStyle: typography.sm.copyWith(color: colors.primaryForeground, fontWeight: .w600),
            ),
          ),
          variants: {
            [.secondary]: .delta(
              decoration: .delta(color: colors.secondary),
              contentStyle: .delta(labelTextStyle: .delta(color: colors.secondaryForeground)),
            ),
            [.outline]: .delta(
              decoration: .delta(
                color: const Color(0x00000000),
                border: .all(color: colors.border, width: style.borderWidth),
              ),
              contentStyle: .delta(labelTextStyle: .delta(color: colors.foreground)),
            ),
            [.destructive]: .delta(
              decoration: .delta(color: colors.destructive),
              contentStyle: .delta(labelTextStyle: .delta(color: colors.destructiveForeground)),
            ),
          },
        ),
      );
}

/// A [FBadge]'s style.
final class FBadgeStyle with Diagnosticable, _$FBadgeStyleFunctions {
  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// The content's style.
  @override
  final FBadgeContentStyle contentStyle;

  /// Creates a [FBadgeStyle].
  const FBadgeStyle({required this.decoration, required this.contentStyle});
}
