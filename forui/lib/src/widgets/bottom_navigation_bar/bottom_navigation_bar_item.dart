import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'bottom_navigation_bar_item.design.dart';

/// A [FBottomNavigationBar] item.
class FBottomNavigationBarItem extends StatelessWidget {
  /// The style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FBottomNavigationBarItemStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create bottom-navigation-bar-item
  /// ```
  final FBottomNavigationBarItemStyleDelta style;

  /// The icon, wrapped in a [IconTheme].
  final Widget icon;

  /// The label.
  final Widget? label;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.foundation.FTappable.onHoverChange}
  final ValueChanged<bool>? onHoverChange;

  /// {@macro forui.foundation.FTappable.onVariantChange}
  final FTappableVariantChangeCallback? onVariantChange;

  /// Creates a [FBottomNavigationBarItem].
  const FBottomNavigationBarItem({
    required this.icon,
    this.label,
    this.style = const .inherit(),
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onVariantChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FBottomNavigationBarData(:itemStyle, :selected, :index, :onChange) = .of(context);
    final style = this.style(itemStyle);

    return FTappable(
      style: style.tappableStyle,
      focusedOutlineStyle: style.focusedOutlineStyle,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onVariantChange: onVariantChange,
      behavior: .opaque,
      selected: selected,
      onPress: () => onChange?.call(index),
      builder: (_, states, _) => Padding(
        padding: style.padding,
        child: Column(
          mainAxisSize: .min,
          spacing: style.spacing,
          children: [
            ExcludeSemantics(
              child: IconTheme(data: style.iconStyle.resolve(states), child: icon),
            ),
            if (label case final label?)
              DefaultTextStyle.merge(style: style.textStyle.resolve(states), overflow: .ellipsis, child: label),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(ObjectFlagProperty.has('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onVariantChange', onVariantChange));
  }
}

/// [FBottomNavigationBarItem]'s style.
class FBottomNavigationBarItemStyle with Diagnosticable, _$FBottomNavigationBarItemStyleFunctions {
  /// The icon's style.
  @override
  final FVariants<FTappableVariantConstraint, IconThemeData, IconThemeDataDelta> iconStyle;

  /// The text style.
  @override
  final FVariants<FTappableVariantConstraint, TextStyle, TextStyleDelta> textStyle;

  /// The padding. Defaults to `EdgeInsets.all(5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The spacing between the icon and the label. Defaults to 2.
  @override
  final double spacing;

  /// The item's tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// The item's focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FBottomNavigationBarItemStyle].
  FBottomNavigationBarItemStyle({
    required this.iconStyle,
    required this.textStyle,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    this.padding = const .all(5),
    this.spacing = 2,
  });

  /// Creates a [FBottomNavigationBarItemStyle] that inherits its properties.
  FBottomNavigationBarItemStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) : this(
         iconStyle: .delta(
           IconThemeData(color: colors.disable(colors.foreground), size: 24),
           variants: {
             [.selected]: .delta(color: colors.primary),
           },
         ),
         textStyle: .delta(
           typography.base.copyWith(color: colors.disable(colors.foreground), fontSize: 10),
           variants: {
             [.selected]: .delta(color: colors.primary),
           },
         ),
         tappableStyle: style.tappableStyle,
         focusedOutlineStyle: style.focusedOutlineStyle,
       );
}
