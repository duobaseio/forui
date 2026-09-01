import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/inherited_controller.dart';
import 'package:forui/src/widgets/slider/inherited_data.dart';
import 'package:forui/src/widgets/slider/inherited_variants.dart';

part 'thumb.design.dart';

class const _HomeIntent() extends Intent;

class const _EndIntent() extends Intent;

class const _ShrinkIntent() extends Intent;

class const _ExpandIntent() extends Intent;

@internal
class const Thumb({required final bool min, super.key}) extends StatefulWidget {
  @override
  State<Thumb> createState() => _ThumbState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('min', value: min, ifTrue: 'min', ifFalse: 'max'));
  }
}

class _ThumbState extends State<Thumb> with TickerProviderStateMixin {
  MouseCursor _cursor = SystemMouseCursors.grab;
  ({double min, double max})? _origin;
  bool _gesture = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final InheritedController(:controller, :minTooltipController, :maxTooltipController) = .of(context);
    final tooltip = widget.min ? minTooltipController : maxTooltipController;
    final offset = widget.min ? controller.value.min : controller.value.max;
    final variants = InheritedVariants.of(context).variants;
    final InheritedData(
      style: FSliderStyle(
        :thumbSize,
        :thumbStyle,
        :tooltipStyle,
        :tooltipTipAnchor,
        :tooltipThumbAnchor,
        :tickHapticFeedback,
        :collisionHapticFeedback,
      ),
      :layout,
      :tooltipBuilder,
      :enabled,
      :onEnd,
    ) = .of(
      context,
    );

    Widget thumb = FocusableActionDetector(
      shortcuts: {
        const SingleActivator(.home): const _HomeIntent(),
        const SingleActivator(.end): const _EndIntent(),
        ...switch ((layout, widget.min)) {
          (.ltr, true) || (.rtl, false) => const {
            SingleActivator(.arrowLeft): _ExpandIntent(),
            SingleActivator(.arrowRight): _ShrinkIntent(),
          },
          (.ltr, false) || (.rtl, true) => const {
            SingleActivator(.arrowLeft): _ShrinkIntent(),
            SingleActivator(.arrowRight): _ExpandIntent(),
          },
          (.ttb, true) || (.btt, false) => const {
            SingleActivator(.arrowUp): _ExpandIntent(),
            SingleActivator(.arrowDown): _ShrinkIntent(),
          },
          (.ttb, false) || (.btt, true) => const {
            SingleActivator(.arrowUp): _ShrinkIntent(),
            SingleActivator(.arrowDown): _ExpandIntent(),
          },
        },
      },
      actions: {
        _HomeIntent: CallbackAction(
          onInvoke: (_) {
            controller.value = controller.value.move(min: widget.min, to: 0);
            onEnd?.call(controller.value);
            return null;
          },
        ),
        _EndIntent: CallbackAction(
          onInvoke: (_) {
            controller.value = controller.value.move(min: widget.min, to: controller.value.pixelConstraints.extent);
            onEnd?.call(controller.value);
            return null;
          },
        ),
        _ExpandIntent: CallbackAction(
          onInvoke: (_) {
            if (controller.step(min: widget.min, expand: true)) {
              unawaited(tickHapticFeedback());
            }
            onEnd?.call(controller.value);
            return null;
          },
        ),
        _ShrinkIntent: CallbackAction(
          onInvoke: (_) {
            if (controller.step(min: widget.min, expand: false)) {
              unawaited(tickHapticFeedback());
            }
            onEnd?.call(controller.value);
            return null;
          },
        ),
      },
      enabled: enabled,
      mouseCursor: enabled ? _cursor : .defer,
      includeFocusSemantics: false,
      onFocusChange: (focused) => setState(() => _focused = focused),
      child: FFocusedOutline(
        style: thumbStyle.focusedOutlineStyle,
        focused: _focused,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: .circle,
            color: thumbStyle.color.resolve(variants),
            border: .all(color: thumbStyle.borderColor.resolve(variants), width: thumbStyle.borderWidth),
          ),
          child: SizedBox.square(dimension: thumbSize),
        ),
      ),
    );

    if (!enabled) {
      return thumb;
    }

    if (tooltip != null) {
      thumb = MouseRegion(
        onEnter: (_) => tooltip.show(),
        onExit: (_) {
          if (!_gesture) {
            tooltip.hide();
          }
        },
        child: FTooltip(
          control: .managed(controller: tooltip),
          style: tooltipStyle,
          tipAnchor: tooltipTipAnchor,
          childAnchor: tooltipThumbAnchor,
          tipBuilder: (_, tooltipController) => tooltipBuilder(tooltipController, offset),
          longPress: false,
          hover: false,
          child: thumb,
        ),
      );
    }

    void down(TapDownDetails _) {
      setState(() => _cursor = SystemMouseCursors.grabbing);
      _gesture = true;
      tooltip?.show();
    }

    void up(TapUpDetails _) {
      setState(() => _cursor = SystemMouseCursors.grab);
      _gesture = false;
      tooltip?.hide();
      InheritedData.of(context).onEnd?.call(controller.value);
    }

    void start(DragStartDetails _) {
      setState(() => _cursor = SystemMouseCursors.grabbing);
      _origin = null;
      _origin = controller.value.pixels;
      _gesture = true;
      tooltip?.show();
    }

    void end(DragEndDetails _) {
      setState(() => _cursor = SystemMouseCursors.grab);
      _origin = null;
      _gesture = false;
      tooltip?.hide();
      InheritedData.of(context).onEnd?.call(controller.value);
    }

    if (layout.vertical) {
      return GestureDetector(
        excludeFromSemantics: true,
        onTapDown: down,
        onTapUp: up,
        onVerticalDragStart: start,
        onVerticalDragUpdate: _drag(controller, thumbSize, layout, tickHapticFeedback, collisionHapticFeedback),
        onVerticalDragEnd: end,
        child: thumb,
      );
    } else {
      return GestureDetector(
        excludeFromSemantics: true,
        onTapDown: down,
        onTapUp: up,
        onHorizontalDragStart: start,
        onHorizontalDragUpdate: _drag(controller, thumbSize, layout, tickHapticFeedback, collisionHapticFeedback),
        onHorizontalDragEnd: end,
        child: thumb,
      );
    }
  }

  GestureDragUpdateCallback? _drag(
    FSliderController controller,
    double thumbSize,
    FLayout layout,
    Future<void> Function() tickHapticFeedback,
    Future<void> Function() collisionHapticFeedback,
  ) {
    if (controller.interaction == .tap) {
      return null;
    }

    final translate = layout.translateThumbDrag(thumbSize);

    void drag(DragUpdateDetails details) {
      final origin = widget.min ? _origin!.min : _origin!.max;
      final velocity = (layout.vertical ? details.delta.dy : details.delta.dx).abs();
      switch (controller.slide(origin + translate(details.localPosition), min: widget.min, velocity: velocity)) {
        case .tick:
          unawaited(tickHapticFeedback());
        case .collision:
          unawaited(collisionHapticFeedback());
        case null:
          break;
      }
    }

    return drag;
  }
}

/// A slider thumb's style.
///
/// **Note**:
/// The thumb size can be configured inside [FSliderStyle] instead. This is due to an unfortunate limitation of the
/// implementation.
class FSliderThumbStyle({
  /// The thumb's color.
  @override required final FVariants<FSliderVariantConstraint, FSliderVariant, Color, Delta> color,

  /// The border's color.
  @override required final FVariants<FSliderVariantConstraint, FSliderVariant, Color, Delta> borderColor,

  /// The thumb's focused outline style.
  @override required final FFocusedOutlineStyle focusedOutlineStyle,

  /// The border's width. Defaults to `2`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [borderWidth] is not positive.
  @override final double borderWidth = 2,
}) with Diagnosticable, _$FSliderThumbStyleFunctions {
  /// Creates a [FSliderThumbStyle].
  this : assert(0 < borderWidth, 'borderWidth ($borderWidth) must be > 0');
}

@internal
extension Layouts on FLayout {
  double Function(Offset) translateThumbDrag(double thumbSize) => switch (this) {
    .ltr => (delta) => delta.dx - thumbSize / 2,
    .rtl => (delta) => -delta.dx + thumbSize / 2,
    .ttb => (delta) => delta.dy - thumbSize / 2,
    .btt => (delta) => -delta.dy + thumbSize / 2,
  };
}
