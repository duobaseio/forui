import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';

part 'header.design.dart';

/// The current picker type.
enum FCalendarPickerType {
  /// The day picker.
  day,

  /// The year-month picker.
  yearMonth,
}

@internal
class Header extends StatefulWidget {
  static double height(FCalendarHeaderStyle style) => math.max(
    (style.headerTextStyle.fontSize ?? 16) * (style.headerTextStyle.height ?? 1),
    style.buttonStyle.resolve(variants).iconContentStyle.padding.vertical +
        (style.buttonStyle.iconContentStyle.iconStyle.base.size ?? 16),
  );

  final FCalendarHeaderStyle style;
  final ValueNotifier<FCalendarPickerType> type;
  final LocalDate month;

  const Header({required this.style, required this.type, required this.month, super.key});

  @override
  State<Header> createState() => _HeaderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('month', month));
  }
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _height;

  @override
  void initState() {
    super.initState();
    widget.type.addListener(_animate);
    _controller = AnimationController(vsync: this, duration: widget.style.animationDuration);
    _controller.value = widget.type.value == .day ? 0.0 : 1.0;
    _height = Header.height(widget.style);
  }

  @override
  Widget build(BuildContext context) => FTappable.static(
    focusedOutlineStyle: widget.style.focusedOutlineStyle,
    onPress: () => widget.type.value = switch (widget.type.value) {
      .day => .yearMonth,
      .yearMonth => .day,
    },
    excludeSemantics: true,
    builder: (_, variants, _) => SizedBox(
      height: _height,
      child: Padding(
        padding: const .symmetric(horizontal: 15),
        child: Row(
          mainAxisSize: .min,
          mainAxisAlignment: .center,
          children: [
            Text(
              (FLocalizations.of(context) ?? FDefaultLocalizations()).yearMonth(widget.month.toNative()),
              style: widget.style.headerTextStyle,
            ),
            RotationTransition(
              turns: Tween(
                begin: 0.0,
                end: Directionality.maybeOf(context) == .rtl ? -0.25 : 0.25,
              ).animate(_controller),
              child: Padding(
                padding: const .all(2.0),
                child: IconTheme(
                  data: widget.style.buttonStyle.iconContentStyle.iconStyle
                      .resolve(variants)
                      .copyWith(color: widget.style.headerTextStyle.color),
                  child: Icon(FIcons.chevronRight, size: widget.style.headerIconSize),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  void didUpdateWidget(Header old) {
    super.didUpdateWidget(old);
    old.type.removeListener(_animate);
    widget.type.addListener(_animate);
    _height = Header.height(widget.style);
  }

  @override
  void dispose() {
    widget.type.removeListener(_animate);
    _controller.dispose();
    super.dispose();
  }

  void _animate() {
    // we check the picker type to prevent de-syncs
    switch ((widget.type.value, _controller.isCompleted)) {
      case (.yearMonth, false):
        _controller.forward();
      case (.day, true):
        _controller.reverse();

      case _:
    }
  }
}

@internal
class Navigation extends StatelessWidget {
  final FCalendarHeaderStyle style;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const Navigation({required this.style, required this.onPrevious, required this.onNext, super.key});

  @override
  Widget build(BuildContext _) => Padding(
    padding: const .only(bottom: 5),
    child: SizedBox(
      height: Header.height(style),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Padding(
            padding: const .directional(start: 7),
            child: FButton.icon(style: style.buttonStyle, onPress: onPrevious, child: const Icon(FIcons.chevronLeft)),
          ),

          const Expanded(child: SizedBox()),
          Padding(
            padding: const .directional(end: 7),
            child: FButton.icon(style: style.buttonStyle, onPress: onNext, child: const Icon(FIcons.chevronRight)),
          ),
        ],
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onPrevious', onPrevious))
      ..add(ObjectFlagProperty.has('onNext', onNext));
  }
}

/// The calendar header's style.
class FCalendarHeaderStyle with Diagnosticable, _$FCalendarHeaderStyleFunctions {
  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The button style. Defaults to outline sm on touch and outline xs on desktop.
  @override
  final FVariants<FPlatformVariantConstraint, FPlatformVariant, FButtonStyle, FButtonStyleDelta> buttonStyle;

  /// The header's text style.
  @override
  final TextStyle headerTextStyle;

  /// The header's icon size. Defaults to 16.
  @override
  final double headerIconSize;

  /// The arrow turn animation's duration. Defaults to 200ms.
  @override
  final Duration animationDuration;

  /// Creates a [FCalendarHeaderStyle].
  FCalendarHeaderStyle({
    required this.focusedOutlineStyle,
    required this.buttonStyle,
    required this.headerTextStyle,
    this.headerIconSize = 16,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  /// Creates a [FCalendarHeaderStyle] that inherits its properties.
  factory FCalendarHeaderStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) {
    final buttons = FButtonStyles.inherit(colors: colors, typography: typography, style: style).outline;
    return .new(
      focusedOutlineStyle: style.focusedOutlineStyle,
      buttonStyle: FVariants(
        buttons.xs,
        variants: {
          [.desktop]: buttons.sm,
        },
      ),
      headerTextStyle: typography.sm.copyWith(color: colors.foreground, fontWeight: .w500),
      headerIconSize: typography.md.fontSize!,
    );
  }
}
