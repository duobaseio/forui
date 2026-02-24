import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'sidebar_item.design.dart';

/// A sidebar item.
///
/// The [FSidebarItem] widget is useful for creating interactive items in a sidebar. It can display an icon, label, and
/// optional action, with support for selected and enabled states.
///
/// See:
/// * https://forui.dev/docs/navigation/sidebar for working examples.
/// * [FSidebarItemStyle] for customizing a sidebar item's appearance.
class FSidebarItem extends StatefulWidget {
  /// The sidebar item's style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FSidebarItemStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create sidebar
  /// ```
  final FSidebarItemStyleDelta style;

  /// The icon to display before the label.
  final Widget? icon;

  /// The main content of the item.
  final Widget? label;

  /// Whether this item is currently selected.
  final bool selected;

  /// Whether this item is initially expanded.
  final bool initiallyExpanded;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// Called when the item is pressed.
  ///
  /// The method will run concurrently with animations if [children] is non-null.
  final VoidCallback? onPress;

  /// Called when the item is long pressed.
  final VoidCallback? onLongPress;

  /// Called when the hover state changes.
  final ValueChanged<bool>? onHoverChange;

  /// Called when the variant changes.
  final FTappableVariantChangeCallback? onVariantChange;

  /// The sidebar item's children.
  final List<Widget> children;

  /// Creates a [FSidebarItem].
  const FSidebarItem({
    this.style = const .context(),
    this.icon,
    this.label,
    this.selected = false,
    this.initiallyExpanded = false,
    this.autofocus = false,
    this.focusNode,
    this.onPress,
    this.onLongPress,
    this.onHoverChange,
    this.onVariantChange,
    this.children = const [],
    super.key,
  });

  @override
  State<FSidebarItem> createState() => _FSidebarItemState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(FlagProperty('initiallyExpanded', value: initiallyExpanded, ifTrue: 'initiallyExpanded'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onVariantChange', onVariantChange))
      ..add(DiagnosticsProperty('children', children));
  }
}

class _FSidebarItemState extends State<FSidebarItem> with TickerProviderStateMixin {
  FSidebarItemStyle? _style;
  AnimationController? _controller;
  CurvedAnimation? _curvedReveal;
  CurvedAnimation? _curvedFade;
  CurvedAnimation? _curvedIconRotation;
  Animation<double>? _reveal;
  Animation<double>? _fade;
  Animation<double>? _iconRotation;
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update();
  }

  @override
  void didUpdateWidget(FSidebarItem old) {
    super.didUpdateWidget(old);
    _update();
  }

  void _update() {
    final style = widget.style(
      FSidebarGroupData.maybeOf(context)?.style.itemStyle ??
          FSidebarData.maybeOf(context)?.style.groupStyle.itemStyle ??
          context.theme.sidebarStyle.groupStyle.itemStyle,
    );

    if (_style != style) {
      _style = style;
      _curvedIconRotation?.dispose();
      _curvedFade?.dispose();
      _curvedReveal?.dispose();
      _controller?.dispose();

      _controller = AnimationController(
        vsync: this,
        value: _expanded ? 1.0 : 0.0,
        duration: style.motion.expandDuration,
        reverseDuration: style.motion.collapseDuration,
      );
      _curvedReveal = CurvedAnimation(
        curve: style.motion.expandCurve,
        reverseCurve: style.motion.collapseCurve,
        parent: _controller!,
      );
      _curvedFade = CurvedAnimation(curve: Curves.easeIn, reverseCurve: Curves.easeOut, parent: _controller!);
      _curvedIconRotation = CurvedAnimation(
        curve: style.motion.iconExpandCurve,
        reverseCurve: style.motion.iconCollapseCurve,
        parent: _controller!,
      );
      _reveal = style.motion.revealTween.animate(_curvedReveal!);
      _fade = style.motion.fadeTween.animate(_curvedFade!);
      _iconRotation = style.motion.iconTween.animate(_curvedIconRotation!);
    }
  }

  @override
  void dispose() {
    _curvedIconRotation?.dispose();
    _curvedFade?.dispose();
    _curvedReveal?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      FTappable(
        style: _style!.tappableStyle,
        focusedOutlineStyle: _style!.focusedOutlineStyle,
        selected: widget.selected,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        onPress: widget.children.isNotEmpty
            ? () {
                _toggle();
                widget.onPress?.call();
              }
            : widget.onPress,
        onLongPress: widget.onLongPress,
        onHoverChange: widget.onHoverChange,
        onVariantChange: widget.onVariantChange,
        builder: (_, variants, child) => Container(
          padding: _style!.padding,
          decoration: ShapeDecoration(
            shape: RoundedSuperellipseBorder(borderRadius: _style!.borderRadius),
            color: _style!.backgroundColor.resolve(variants),
          ),
          child: Row(
            spacing: _style!.collapsibleIconSpacing,
            mainAxisAlignment: .spaceBetween,
            children: [
              Expanded(
                child: Row(
                  spacing: _style!.iconSpacing,
                  children: [
                    if (widget.icon != null) IconTheme(data: _style!.iconStyle.resolve(variants), child: widget.icon!),
                    if (widget.label != null)
                      Expanded(
                        child: DefaultTextStyle.merge(style: _style!.textStyle.resolve(variants), child: widget.label!),
                      ),
                  ],
                ),
              ),
              if (widget.children.isNotEmpty)
                IconTheme(
                  data: _style!.collapsibleIconStyle.resolve(variants),
                  child: RotationTransition(turns: _iconRotation!, child: const Icon(FIcons.chevronRight)),
                ),
            ],
          ),
        ),
      ),
      if (widget.children.isNotEmpty)
        AnimatedBuilder(
          animation: _reveal!,
          builder: (_, _) => FCollapsible(
            value: _reveal!.value,
            child: Padding(
              padding: _style!.childrenPadding,
              child: AnimatedBuilder(
                animation: _fade!,
                builder: (context, child) => FadeTransition(
                  opacity: _fade!,
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: _style!.childrenSpacing,
                    children: widget.children,
                  ),
                ),
              ),
            ),
          ),
        ),
    ],
  );

  void _toggle() {
    _controller?.toggle();
    setState(() => _expanded = !_expanded);
  }
}

/// The style for a [FSidebarItem].
class FSidebarItemStyle with Diagnosticable, _$FSidebarItemStyleFunctions {
  /// The label's text style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> textStyle;

  /// The spacing between the icon and label. Defaults to 8.
  @override
  final double iconSpacing;

  /// The icon's style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> iconStyle;

  /// The spacing between the label and collapsible widget. Defaults to 8.
  @override
  final double collapsibleIconSpacing;

  /// The collapsible icon's style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> collapsibleIconStyle;

  /// The spacing between child items. Defaults to 2.
  @override
  final double childrenSpacing;

  /// The padding around the children container. Defaults to `EdgeInsets.only(left: 26, top: 2)`.
  @override
  final EdgeInsetsGeometry childrenPadding;

  /// The background color.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, Color, Delta> backgroundColor;

  /// The padding around the content. Defaults to `EdgeInsets.symmetric(horizontal: 12, vertical: 10)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The item's border radius.
  @override
  final BorderRadius borderRadius;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The motion-related properties.
  @override
  final FSidebarItemMotion motion;

  /// Creates a [FSidebarItemStyle].
  const FSidebarItemStyle({
    required this.textStyle,
    required this.iconStyle,
    required this.collapsibleIconStyle,
    required this.backgroundColor,
    required this.borderRadius,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    this.iconSpacing = 8,
    this.collapsibleIconSpacing = 8,
    this.childrenSpacing = 2,
    this.childrenPadding = const .only(left: 26, top: 2),
    this.padding = const .symmetric(horizontal: 12, vertical: 10),
    this.motion = const FSidebarItemMotion(),
  });

  /// Creates a [FSidebarItemStyle] that inherits its properties.
  FSidebarItemStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        textStyle: FVariants.from(
          typography.md.copyWith(color: colors.foreground, overflow: .ellipsis, height: 1),
          variants: {
            [.disabled]: .delta(color: colors.mutedForeground),
          },
        ),
        iconStyle: FVariants.from(
          IconThemeData(color: colors.foreground, size: 16),
          variants: {
            [.disabled]: .delta(color: colors.mutedForeground),
          },
        ),
        collapsibleIconStyle: FVariants.from(
          IconThemeData(color: colors.foreground, size: 16),
          variants: {
            [.disabled]: .delta(color: colors.mutedForeground),
          },
        ),
        backgroundColor: FVariants(
          colors.background,
          variants: {
            [.selected, .hovered, .pressed]: colors.secondary,
            //
            [.disabled]: colors.background,
          },
        ),
        borderRadius: style.borderRadius.md,
        tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
        focusedOutlineStyle: style.focusedOutlineStyle.copyWith(spacing: 0),
      );
}

/// The motion-related properties for a [FSidebarItem].
class FSidebarItemMotion with Diagnosticable, _$FSidebarItemMotionFunctions {
  /// The expand animation's duration. Defaults to 200ms.
  @override
  final Duration expandDuration;

  /// The collapse animation's duration. Defaults to 150ms.
  @override
  final Duration collapseDuration;

  /// The expand animation's curve. Defaults to [Curves.easeOutCubic].
  @override
  final Curve expandCurve;

  /// The collapse animation's curve. Defaults to [Curves.easeInCubic].
  @override
  final Curve collapseCurve;

  /// The fade-in animation's curve. Defaults to [Curves.linear].
  @override
  final Curve fadeInCurve;

  /// The fade-out animation's curve. Defaults to [Curves.linear].
  @override
  final Curve fadeOutCurve;

  /// The icon's animation curve when expanding. Defaults to [Curves.easeOut].
  @override
  final Curve iconExpandCurve;

  /// The icon's animation curve when collapsing. Defaults to [Curves.easeOut].
  @override
  final Curve iconCollapseCurve;

  /// The reveal animation's tween. Defaults to `FImmutableTween(begin: 0.0, end: 1.0)`.
  @override
  final Animatable<double> revealTween;

  /// The fade animation's tween. Defaults to `FImmutableTween(begin: 0.0, end: 1.0)`.
  @override
  final Animatable<double> fadeTween;

  /// The icon animation's tween. Defaults to `FImmutableTween(begin: 0.0, end: 0.25)`.
  @override
  final Animatable<double> iconTween;

  /// Creates a [FSidebarItemMotion].
  const FSidebarItemMotion({
    this.expandDuration = const Duration(milliseconds: 200),
    this.collapseDuration = const Duration(milliseconds: 150),
    this.expandCurve = Curves.easeOutCubic,
    this.collapseCurve = Curves.easeInCubic,
    this.fadeInCurve = Curves.linear,
    this.fadeOutCurve = Curves.linear,
    this.iconExpandCurve = Curves.easeOut,
    this.iconCollapseCurve = Curves.easeOut,
    this.revealTween = const FImmutableTween(begin: 0.0, end: 1.0),
    this.fadeTween = const FImmutableTween(begin: 0.0, end: 1.0),
    this.iconTween = const FImmutableTween(begin: 0.0, end: 0.25),
  });
}
