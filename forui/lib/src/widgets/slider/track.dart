import 'dart:async';
import 'dart:math';

import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/inherited_controller.dart';
import 'package:forui/src/widgets/slider/inherited_data.dart';
import 'package:forui/src/widgets/slider/inherited_variants.dart';
import 'package:forui/src/widgets/slider/thumb.dart';

@internal
class const Track({super.key}) extends StatefulWidget {
  @override
  State<Track> createState() => _TrackState();
}

class _TrackState extends State<Track> {
  FSliderController? _controller;
  late bool _max;
  late String Function(FSliderValue) _semanticFormatterCallback;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _semanticFormatterCallback = InheritedData.of(context).semanticFormatterCallback;
    final controller = InheritedController.of(context).controller;
    if (_controller != controller) {
      _controller = controller;
      _max = controller.active.max && !controller.active.min;
    }
  }

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :enabled, :layout, :semanticValueFormatterCallback, :onEnd) = .of(context);
    final position = layout.position;
    final controller = _controller!;
    final crossAxisExtent = max(style.thumbSize, style.crossAxisExtent);
    final (height, width) = layout.vertical ? (null, crossAxisExtent) : (crossAxisExtent, null);

    String? increasedValue;
    VoidCallback? increase;
    if (controller.value.step(min: !_max, expand: _max) case final value when controller.value != value) {
      increasedValue = semanticValueFormatterCallback(_max ? value.max : value.min);
      increase = () {
        if (controller.step(min: !_max, expand: _max)) {
          unawaited(style.tickHapticFeedback());
        }
        onEnd?.call(controller.value);
      };
    }

    String? decreasedValue;
    VoidCallback? decrease;
    if (controller.value.step(min: !_max, expand: !_max) case final value when controller.value != value) {
      decreasedValue = semanticValueFormatterCallback(_max ? value.max : value.min);
      decrease = () {
        if (controller.step(min: !_max, expand: !_max)) {
          unawaited(style.tickHapticFeedback());
        }
        onEnd?.call(controller.value);
      };
    }

    final range = controller.active.min && controller.active.max;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return SizedBox(
      height: height,
      width: width,
      child: Semantics(
        slider: true,
        enabled: enabled,
        value: range ? _describe() : _semanticFormatterCallback(controller.value),
        increasedValue: increasedValue,
        decreasedValue: decreasedValue,
        onIncrease: enabled ? increase : null,
        onDecrease: enabled ? decrease : null,
        // onTap + customSemanticsAction is a workaround Flutter engine's focused outlines "lagging" behind a moving
        // focusable semantics node & causing focus to switch from a focused thumb to a background track.
        hint: range && enabled ? localizations.sliderSwitchThumbsSemanticsHint : null,
        onTap: range && enabled ? _toggle : null,
        customSemanticsActions: range && enabled
            ? {
                CustomSemanticsAction(
                  label: _max
                      ? localizations.sliderSelectMinThumbSemanticsLabel
                      : localizations.sliderSelectMaxThumbSemanticsLabel,
                ): _toggle,
              }
            : null,
        child: Stack(
          alignment: .center,
          children: [
            const _GestureDetector(),
            if (controller.active.min)
              position(
                offset: controller.value.min * controller.value.pixelConstraints.extent,
                child: const Thumb(min: true),
              ),
            if (controller.active.max)
              position(
                offset: controller.value.max * controller.value.pixelConstraints.extent,
                child: const Thumb(min: false),
              ),
          ],
        ),
      ),
    );
  }

  void _toggle() {
    setState(() => _max = !_max);
    SemanticsService.sendAnnouncement(View.of(context), _describe(), Directionality.of(context));
  }

  String _describe() {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final value = _semanticFormatterCallback(_controller!.value);
    return _max ? localizations.sliderMaxSemanticsValue(value) : localizations.sliderMinSemanticsValue(value);
  }
}

class const _GestureDetector() extends StatefulWidget {
  @override
  State<_GestureDetector> createState() => _GestureDetectorState();
}

class _GestureDetectorState extends State<_GestureDetector> {
  static const Set<FSliderInteraction> tappable = {.tap, .tapAndSlideThumb};

  ({double min, double max})? _origin;
  Offset? _pointerOrigin;

  @override
  Widget build(BuildContext context) {
    final InheritedController(:controller, :minTooltipController, :maxTooltipController) = .of(context);
    final InheritedData(:style, :layout, :trackHitRegionCrossExtent, :enabled, :onEnd) = .of(context);

    Widget track = const Center(child: _Track());

    if (!enabled) {
      return track;
    }

    if (context.platformVariant.touch || trackHitRegionCrossExtent != null) {
      final crossAxisExtent = trackHitRegionCrossExtent ?? max(style.thumbSize, style.crossAxisExtent);
      final (height, width) = layout.vertical ? (null, crossAxisExtent) : (crossAxisExtent, null);

      track = Container(height: height, width: width, color: const Color(0x00000000), child: track);
    }

    void start(DragStartDetails details) {
      _origin = controller.value.pixels;
      _pointerOrigin = details.localPosition;
      minTooltipController?.show();
      maxTooltipController?.show();
    }

    void end(DragEndDetails _) {
      _origin = null;
      _pointerOrigin = null;
      minTooltipController?.hide();
      maxTooltipController?.hide();
      onEnd?.call(controller.value);
    }

    if (layout.vertical) {
      return GestureDetector(
        excludeFromSemantics: true,
        onTapDown: _tap(controller, style, minTooltipController, maxTooltipController, style.thumbSize, layout),
        onTapUp: (_) {
          minTooltipController?.hide();
          maxTooltipController?.hide();
          onEnd?.call(controller.value);
        },
        onVerticalDragStart: start,
        onVerticalDragUpdate: _drag(controller, style, layout),
        onVerticalDragEnd: end,
        child: track,
      );
    } else {
      return GestureDetector(
        excludeFromSemantics: true,
        onTapDown: _tap(controller, style, minTooltipController, maxTooltipController, style.thumbSize, layout),
        onTapUp: (_) {
          minTooltipController?.hide();
          maxTooltipController?.hide();
          onEnd?.call(controller.value);
        },
        onHorizontalDragStart: start,
        onHorizontalDragUpdate: _drag(controller, style, layout),
        onHorizontalDragEnd: end,
        child: track,
      );
    }
  }

  GestureTapDownCallback? _tap(
    FSliderController controller,
    FSliderStyle style,
    FTooltipController? min,
    FTooltipController? max,
    double thumbSize,
    FLayout layout,
  ) {
    final translate = layout.translateTrackTap(controller.value.pixelConstraints.extent, thumbSize);

    void down(TapDownDetails details) {
      final offset = switch (translate(details.localPosition)) {
        < 0 => 0.0,
        final translated when controller.value.pixelConstraints.extent < translated =>
          controller.value.pixelConstraints.extent,
        final translated => translated,
      };

      final (:thumb, :haptic) = controller.tap(offset);
      switch (thumb) {
        case .min:
          min?.show();
        case .max:
          max?.show();
        case null:
      }

      if (haptic) {
        unawaited(style.tickHapticFeedback());
      }
    }

    return tappable.contains(controller.interaction) ? down : null;
  }

  GestureDragUpdateCallback? _drag(FSliderController controller, FSliderStyle style, FLayout layout) {
    if (controller.interaction != FSliderInteraction.slide) {
      return null;
    }

    assert(
      controller.active.min ^ controller.active.max,
      'Slider must be active at one edge when ${controller.interaction}.',
    );

    final translate = layout.translateTrackDrag();

    return (details) {
      final origin = controller.active.min ? _origin!.min : _origin!.max;
      switch (controller.slide(
        origin + translate(details.localPosition - _pointerOrigin!),
        min: controller.active.min,
        velocity: (layout.vertical ? details.delta.dy : details.delta.dx).abs(),
      )) {
        case .tick:
          unawaited(style.tickHapticFeedback());
        case .collision:
          unawaited(style.collisionHapticFeedback());
        case null:
          break;
      }
    };
  }
}

class const _Track() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :layout, :marks, :enabled) = InheritedData.of(context);
    final variants = InheritedVariants.of(context).variants;
    final crossAxisExtent = style.crossAxisExtent;

    final extent = InheritedController.of(
      context,
      InheritedController.pixelConstraints,
    ).controller.value.pixelConstraints.extent;

    final position = layout.position;
    final half = style.thumbSize / 2;
    final (height, width) = layout.vertical ? (null, crossAxisExtent) : (crossAxisExtent, null);

    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius),
        color: style.inactiveColor.resolve(variants),
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: .center,
          children: [
            for (var FSliderMark(style: markStyle, :value, :tick) in marks)
              if (tick)
                position(
                  offset: value * extent + half - ((markStyle ??= style.markStyle).tickSize / 2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(shape: .circle, color: markStyle.tickColor.resolve(variants)),
                    child: SizedBox.square(dimension: markStyle.tickSize),
                  ),
                ),
            const ActiveTrack(),
          ],
        ),
      ),
    );
  }
}

@internal
class const ActiveTrack({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :layout) = .of(context);
    final variants = InheritedVariants.of(context).variants;
    final crossAxisExtent = style.crossAxisExtent;
    final pixels = InheritedController.of(context, InheritedController.pixels).controller.value.pixels;

    final mainAxisExtent = pixels.max - pixels.min + style.thumbSize / 2;
    final (height, width) = layout.vertical ? (mainAxisExtent, crossAxisExtent) : (crossAxisExtent, mainAxisExtent);

    return layout.position(
      offset: pixels.min,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius),
          color: style.activeColor.resolve(variants),
        ),
        child: SizedBox(height: height, width: width),
      ),
    );
  }
}

@internal
extension Layouts on FLayout {
  double Function(Offset) translateTrackTap(double extent, double thumbSize) => switch (this) {
    .ltr => (offset) => offset.dx - thumbSize / 2,
    .rtl => (offset) => extent - offset.dx + thumbSize / 2,
    .ttb => (offset) => offset.dy - thumbSize / 2,
    .btt => (offset) => extent - offset.dy + thumbSize / 2,
  };

  double Function(Offset) translateTrackDrag() => switch (this) {
    .ltr => (delta) => delta.dx,
    .rtl => (delta) => -delta.dx,
    .ttb => (delta) => delta.dy,
    .btt => (delta) => -delta.dy,
  };

  Positioned Function({required double offset, required Widget child}) get position => switch (this) {
    .ltr => ({required offset, required child}) => Positioned(left: offset, child: child),
    .rtl => ({required offset, required child}) => Positioned(right: offset, child: child),
    .ttb => ({required offset, required child}) => Positioned(top: offset, child: child),
    .btt => ({required offset, required child}) => Positioned(bottom: offset, child: child),
  };
}
