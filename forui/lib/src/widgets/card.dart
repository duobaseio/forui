import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/inner_path_clipper.dart';

part 'card.design.dart';

/// A card.
///
/// Cards are typically used to group related information together.
///
/// ## CLI
/// To generate a layout for this widget:
///
/// ```shell
/// dart run forui snippet create card
/// ```
///
/// See:
/// * https://forui.dev/docs/widgets/data/card for working examples and generatable layouts for this widget.
/// * [FCardStyle] for customizing a card's appearance.
class FCard extends StatelessWidget {
  /// The default [builder] that returns [child] unchanged.
  static Widget defaultBuilder(BuildContext _, FCardStyle _, Widget? child) => child!;

  /// The style. Defaults to [FThemeData.cardStyle].
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

  /// The clip behavior applied to the card's content.
  ///
  /// When set to a value other than [Clip.none], the card's content is clipped to the inner path of its decoration,
  /// so children cannot overflow the rounded corners or paint over the border ring.
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// The builder for the card's content.
  ///
  /// Defaults to returning the given child.
  final ValueWidgetBuilder<FCardStyle> builder;

  /// The child.
  final Widget? child;

  /// Creates a [FCard].
  ///
  /// ## CLI
  /// To generate a layout for this widget:
  ///
  /// ```shell
  /// dart run forui snippet create card
  /// ```
  ///
  /// See https://forui.dev/docs/widgets/data/card for other generatable layouts.
  const FCard({
    this.style = const .context(),
    this.clipBehavior = .none,
    this.builder = defaultBuilder,
    this.child,
    super.key,
  }) : assert(builder != defaultBuilder || child != null, 'Either builder or child must be provided.');

  @override
  Widget build(BuildContext context) {
    final style = this.style(context.theme.cardStyle);
    final decoration = style.decoration;
    final child = builder(context, style, this.child);
    return DecoratedBox(
      decoration: decoration,
      child: clipBehavior == .none
          ? child
          : ClipPath(
              clipBehavior: clipBehavior,
              clipper: InnerPathClipper(decoration: decoration, direction: Directionality.maybeOf(context) ?? .ltr),
              child: child,
            ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('clipBehavior', clipBehavior))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// [FCard]'s style.
class FCardStyle with Diagnosticable, _$FCardStyleFunctions {
  /// The decoration.
  @override
  final Decoration decoration;

  /// The title's [TextStyle].
  @override
  final TextStyle titleTextStyle;

  /// The subtitle's [TextStyle].
  @override
  final TextStyle subtitleTextStyle;

  /// The padding. Defaults to `EdgeInsets.all(16)`.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FCardStyle].
  FCardStyle({
    required this.decoration,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    this.padding = const .all(16),
  });

  /// Creates a [FCardStyle] that inherits its properties.
  factory FCardStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) => FCardStyle(
    decoration: ShapeDecoration(
      shape: RoundedSuperellipseBorder(
        side: BorderSide(color: colors.border, width: style.borderWidth),
        borderRadius: style.borderRadius.lg,
      ),
      color: colors.card,
    ),
    titleTextStyle: touch
        ? typography.display.lg.copyWith(fontWeight: .w500, color: colors.foreground)
        : typography.display.md.copyWith(fontWeight: .w500, color: colors.foreground),
    subtitleTextStyle: typography.body.sm.copyWith(color: colors.mutedForeground),
  );
}
