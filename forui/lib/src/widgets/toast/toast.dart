import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A toast.
///
/// See:
/// * https://forui.dev/docs/overlay/toast for working examples.
/// * [showFToast] for displaying a toast.
/// * [FToasterStyle] for customizing a toaster's appearance.
/// * [FToastStyle] for customizing a toast's appearance.
class FToast extends StatelessWidget {
  /// The variants used to resolve the style from [FToastStyles].
  ///
  /// Defaults to [FToastVariant.primary]. The current platform variant is automatically included during style
  /// resolution. To change the platform variant, update the enclosing [FTheme.platform]/[FAdaptiveScope.platform].
  ///
  /// For example, to create a destructive toast:
  /// ```dart
  /// FToast(
  ///   variant: .destructive,
  ///   title: Text('Something went wrong'),
  /// )
  /// ```
  final FToastVariant variant;

  /// The style delta applied to the style resolved by [variant].
  ///
  /// The final style is computed by first resolving the base style from [FToastStyles] using [variant], then applying
  /// this delta. This allows modifying variant-specific styles:
  /// ```dart
  /// FToast(
  ///   variant: .destructive,
  ///   style: .delta(iconStyle: .delta(size: 24)), // modifies the destructive style
  ///   title: Text('Large icon destructive toast'),
  /// )
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create toast
  /// ```
  final FToastStyleDelta style;

  /// An optional icon aligned to the start of the toast (left in LTR locales).
  final Widget? icon;

  /// The toast's title. Defaults to a maximum of 100 lines. Set [Text.maxLines] to change this.
  final Widget title;

  /// The toast's description. Defaults to a maximum of 100 lines. Set [Text.maxLines] to change this.
  final Widget? description;

  /// An optional widget aligned to the end of the toast (left in LTR locales).
  final Widget? suffix;

  /// Creates a [FToast].
  const FToast({
    required this.title,
    this.variant = .primary,
    this.style = const .context(),
    this.icon,
    this.description,
    this.suffix,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style(context.theme.toasterStyle.toastStyles.resolve({variant, context.platformVariant}));
    Widget toast = DecoratedBox(
      decoration: style.decoration,
      child: Padding(
        padding: style.padding,
        child: Row(
          mainAxisSize: .min,
          children: [
            if (icon case final icon?) ...[
              IconTheme(data: style.iconStyle, child: icon),
              SizedBox(width: style.iconSpacing),
            ],
            Flexible(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                spacing: style.titleSpacing,
                children: [
                  DefaultTextStyle(style: style.titleTextStyle, maxLines: 100, child: title),
                  if (description case final description?)
                    DefaultTextStyle(style: style.descriptionTextStyle, maxLines: 100, child: description),
                ],
              ),
            ),
            if (suffix case final suffix?) ...[SizedBox(width: style.suffixSpacing), suffix],
          ],
        ),
      ),
    );

    if (style.backgroundFilter case final background?) {
      toast = Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(filter: background, child: Container()),
            ),
          ),
          toast,
        ],
      );
    }

    return toast;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('variant', variant))
      ..add(DiagnosticsProperty('style', style));
  }
}
