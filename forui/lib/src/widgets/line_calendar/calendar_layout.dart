import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:sugar/sugar.dart' hide Offset;

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar_controller.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar_item.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar_scroll_controller.dart';

@internal
class CalendarLayout extends StatefulWidget {
  final FLineCalendarControl control;
  final FLineCalendarScrollControl scrollControl;
  final FLineCalendarStyle style;
  final ScrollPhysics? physics;
  final ScrollCacheExtent? scrollCacheExtent;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final TextScaler scale;
  final TextStyle textStyle;
  final bool Function(DateTime) selectable;
  final ValueWidgetBuilder<FLineCalendarItemData> builder;
  final BoxConstraints constraints;

  const CalendarLayout({
    required this.control,
    required this.scrollControl,
    required this.style,
    required this.physics,
    required this.scrollCacheExtent,
    required this.keyboardDismissBehavior,
    required this.scale,
    required this.textStyle,
    required this.selectable,
    required this.builder,
    required this.constraints,
    super.key,
  });

  @override
  State<CalendarLayout> createState() => _CalendarLayoutState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('scrollControl', scrollControl))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(DiagnosticsProperty('scrollCacheExtent', scrollCacheExtent))
      ..add(DiagnosticsProperty('keyboardDismissBehavior', keyboardDismissBehavior))
      ..add(DiagnosticsProperty('scaler', scale))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(ObjectFlagProperty.has('selectable', selectable))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(DiagnosticsProperty('constraints', constraints));
  }
}

class _CalendarLayoutState extends State<CalendarLayout> {
  late FDateSelectionController<DateTime?> _controller;
  late FLineCalendarScrollController _scrollController;
  late double _itemExtent;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleOnChange);
    _scrollController = widget.scrollControl.create(_handleOnScroll)
      ..initialize(_itemExtent = _estimateExtent(), widget.constraints.maxWidth);
  }

  @override
  void didUpdateWidget(covariant CalendarLayout old) {
    super.didUpdateWidget(old);
    if (widget.style != old.style || widget.scale != old.scale || widget.textStyle != old.textStyle) {
      _itemExtent = _estimateExtent();
    }

    _controller = widget.control.update(old.control, _controller, _handleOnChange).$1;
    _scrollController = widget.scrollControl.update(old.scrollControl, _scrollController, _handleOnScroll).$1
      ..initialize(_itemExtent, widget.constraints.maxWidth);
  }

  double _estimateExtent() {
    final scale = widget.scale;
    final textStyle = widget.textStyle;

    double height(FLineCalendarStyle style, Set<FTappableVariant> variants) {
      final dateHeight = scale.scale(style.dateTextStyle.resolve(variants).fontSize ?? textStyle.fontSize ?? 0);
      final weekdayHeight = scale.scale(style.weekdayTextStyle.resolve(variants).fontSize ?? textStyle.fontSize ?? 0);
      final otherHeight = widget.style.contentSpacing + (widget.style.contentEdgeSpacing * 2);

      return dateHeight + weekdayHeight + otherHeight;
    }

    // We use the height to estimate the item's extent.
    return [
      height(widget.style, {.selected}),
      height(widget.style, {.selected, .hovered}),
      height(widget.style, {.hovered}),
      height(widget.style, const {}),
    ].max!;
  }

  @override
  void dispose() {
    widget.scrollControl.dispose(_scrollController, _handleOnScroll);
    widget.control.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.control case FLineCalendarManagedControl(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  void _handleOnScroll() {
    if (widget.scrollControl case FLineCalendarScrollManagedControl(:final onChange?)) {
      onChange(_scrollController.offset);
    }
  }

  @override
  Widget build(BuildContext _) => SpeculativeLayout(
    children: [
      ItemContent(style: widget.style, variants: {.selected}, date: _scrollController.today),
      ItemContent(style: widget.style, variants: {.selected, .hovered}, date: _scrollController.today),
      ItemContent(style: widget.style, variants: const {}, date: _scrollController.today),
      ItemContent(style: widget.style, variants: {.hovered}, date: _scrollController.today),
      ListView.builder(
        scrollCacheExtent: widget.scrollCacheExtent,
        controller: _scrollController,
        scrollDirection: .horizontal,
        padding: .zero,
        physics: widget.physics,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        itemExtent: _itemExtent,
        itemCount: _scrollController.end == null
            ? null
            : _scrollController.end!.difference(_scrollController.start).inDays + 1,
        itemBuilder: (_, index) {
          final date = _scrollController.start.plus(days: index);
          return Padding(
            padding: .symmetric(horizontal: widget.style.itemSpacing / 2),
            child: Item(
              controller: _controller,
              style: widget.style,
              date: date,
              today: _scrollController.today == date,
              selectable: widget.selectable,
              builder: widget.builder,
            ),
          );
        },
      ),
    ],
  );
}

@internal
class SpeculativeLayout extends MultiChildRenderObjectWidget {
  const SpeculativeLayout({required super.children, super.key});

  @override
  RenderObject createRenderObject(BuildContext _) => _SpeculativeBox();
}

class _SpeculativeBox extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, DefaultData>, RenderBoxContainerDefaultsMixin<RenderBox, DefaultData> {
  @override
  void setupParentData(RenderObject child) => child.parentData = DefaultData();

  @override
  void performLayout() {
    final selected = firstChild!;
    final selectedHovered = childAfter(selected)!;
    final unselected = childAfter(selectedHovered)!;
    final unselectedHovered = childAfter(unselected)!;

    final maxHeight = [
      selected.getDryLayout(constraints).height,
      selectedHovered.getDryLayout(constraints).height,
      unselected.getDryLayout(constraints).height,
      unselectedHovered.getDryLayout(constraints).height,
    ].max!;

    // Layout measurement children with tight zero constraints so they have a valid size.
    // This prevents the widget inspector from crashing when it walks all children.
    const zero = BoxConstraints.tightFor(width: 0, height: 0);
    selected.layout(zero);
    selectedHovered.layout(zero);
    unselected.layout(zero);
    unselectedHovered.layout(zero);

    final heightConstraints = constraints.copyWith(maxHeight: maxHeight);
    final viewport = childAfter(unselectedHovered)!..layout(heightConstraints, parentUsesSize: true);
    size = constraints.constrain(viewport.size);
  }

  @override
  void paint(PaintingContext context, Offset offset) => context.paintChild(lastChild!, offset);

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final viewport = lastChild!;
    return result.addWithPaintOffset(
      offset: viewport.data.offset,
      position: position,
      hitTest: (result, transformed) => viewport.hitTest(result, position: transformed),
    );
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) => visitor(lastChild!);
}
