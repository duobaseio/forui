import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/widgets/card/card_content.dart';

@Variants('FCard', {})
part 'card.design.dart';

/// A card.
///
/// Cards are typically used to group related information together.
///
/// See:
/// * https://forui.dev/docs/data/card for working examples.
/// * [FCardStyle] for customizing a card's appearance.
class FCard extends StatelessWidget {
  /// The style. Defaults to [FThemeData.cardStyles].
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FCardStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create card
  /// ```
  final FCardStyleDelta style;

  /// The child.
  final Widget child;

  /// Creates a [FCard] with a title, subtitle, and [child].
  ///
  /// The card's layout is as follows:
  /// ```diagram
  /// |---------------------------|
  /// |  [image]                  |
  /// |                           |
  /// |  [title]                  |
  /// |  [subtitle]               |
  /// |                           |
  /// |  [child]                  |
  /// |---------------------------|
  /// ```
  FCard({
    Widget? image,
    Widget? title,
    Widget? subtitle,
    Widget? child,
    MainAxisSize mainAxisSize = .min,
    this.style = const .context(),
    super.key,
  }) : child = Content(
         image: image,
         title: title,
         subtitle: subtitle,
         mainAxisSize: mainAxisSize,
         style: style,
         child: child,
       );

  /// Creates a [FCard] with custom content.
  const FCard.raw({required this.child, this.style = const .context(), super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: style(context.theme.cardStyles.resolve({context.platformVariant})).decoration,
    child: child,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// The [FCardStyle]s.
extension type FCardStyles(FVariants<FCardVariantConstraint, FCardVariant, FCardStyle, FCardStyleDelta> _)
    implements FVariants<FCardVariantConstraint, FCardVariant, FCardStyle, FCardStyleDelta> {
  /// Creates a [FCardStyles] that inherits its properties.
  factory FCardStyles.inherit({required FColors colors, required FTypography typography, required FStyle style}) {
    final base = FCardStyle(
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(
          side: BorderSide(color: colors.border, width: style.borderWidth),
          borderRadius: style.borderRadius.lg,
        ),
        color: colors.card,
      ),
      contentStyle: FCardContentStyle(
        titleTextStyle: typography.lg.copyWith(fontWeight: .w500, color: colors.foreground),
        subtitleTextStyle: typography.sm.copyWith(color: colors.mutedForeground),
      ),
    );

    return FCardStyles(
      .from(
        base,
        variants: {
          [.touch]: const .delta(),
          [.desktop]: .delta(
            contentStyle: .delta(
              titleTextStyle: .value(typography.md.copyWith(fontWeight: .w500, color: colors.foreground)),
            ),
          ),
        },
      ),
    );
  }
}

/// [FCard]'s style.
class FCardStyle with Diagnosticable, _$FCardStyleFunctions {
  /// The decoration.
  @override
  final Decoration decoration;

  /// The card content's style.
  @override
  final FCardContentStyle contentStyle;

  /// Creates a [FCardStyle].
  FCardStyle({required this.decoration, required this.contentStyle});
}
