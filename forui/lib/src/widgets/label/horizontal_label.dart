import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/src/widgets/label/label.dart';
import 'package:forui/src/widgets/label/semantics.dart';

@internal
class HorizontalLeadingLabel extends Label {
  const new({
    required super.style,
    required super.label,
    required super.description,
    required super.error,
    required super.variants,
    required super.child,
    super.key,
  });

  @override
  State<HorizontalLeadingLabel> createState() => _HorizontalLeadingState();
}

class _HorizontalLeadingState extends LabelState<HorizontalLeadingLabel> {
  @override
  Widget build(BuildContext context) => LabelSemantics(
    child: _Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      defaultVerticalAlignment: .middle,
      columnWidths: const {0: FlexColumnWidth(), 1: IntrinsicColumnWidth()},
      children: [
        TableRow(
          children: [
            if (widget.label != null)
              _cell(
                padding: widget.style.labelPadding,
                textStyle: widget.style.labelTextStyle.resolve(widget.variants),
                child: widget.label,
              )
            else
              _cell(
                padding: widget.style.descriptionPadding,
                textStyle: widget.style.descriptionTextStyle.resolve(widget.variants),
                tag: RenderLabelSemantics.descriptionTag,
                child: widget.description,
              ),
            Padding(padding: widget.style.childPadding, child: widget.child),
          ],
        ),
        if (widget.label != null && widget.description != null)
          TableRow(
            children: [
              _cell(
                padding: widget.style.descriptionPadding,
                textStyle: widget.style.descriptionTextStyle.resolve(widget.variants),
                tag: RenderLabelSemantics.descriptionTag,
                child: widget.description,
              ),
              const SizedBox(),
            ],
          ),
        if (error != null) TableRow(children: [animatedError(context), const SizedBox()]),
      ],
    ),
  );

  Widget _cell({required EdgeInsetsGeometry padding, required TextStyle textStyle, SemanticsTag? tag, Widget? child}) {
    if (child == null) {
      return const SizedBox();
    }

    final motion = this.motion;
    return Padding(
      padding: padding,
      child: AnimatedDefaultTextStyle(
        style: textStyle,
        duration: motion.textStyleTransitionDuration,
        curve: motion.textStyleTransitionCurve,
        child: tag == null ? child : Semantics(tagForChildren: tag, child: child),
      ),
    );
  }
}

@internal
class HorizontalTrailingLabel extends Label {
  const new({
    required super.style,
    required super.label,
    required super.description,
    required super.error,
    required super.variants,
    required super.child,
    super.key,
  });

  @override
  State<HorizontalTrailingLabel> createState() => _HorizontalTrailingState();
}

class _HorizontalTrailingState extends LabelState<HorizontalTrailingLabel> {
  @override
  Widget build(BuildContext context) => LabelSemantics(
    child: _Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      defaultVerticalAlignment: .middle,
      columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
      children: [
        TableRow(
          children: [
            Padding(padding: widget.style.childPadding, child: widget.child),
            if (widget.label != null)
              _cell(
                padding: widget.style.labelPadding,
                textStyle: widget.style.labelTextStyle.resolve(widget.variants),
                child: widget.label,
              )
            else
              _cell(
                padding: widget.style.descriptionPadding,
                textStyle: widget.style.descriptionTextStyle.resolve(widget.variants),
                tag: RenderLabelSemantics.descriptionTag,
                child: widget.description,
              ),
          ],
        ),
        if (widget.label != null && widget.description != null)
          TableRow(
            children: [
              const SizedBox(),
              _cell(
                padding: widget.style.descriptionPadding,
                textStyle: widget.style.descriptionTextStyle.resolve(widget.variants),
                tag: RenderLabelSemantics.descriptionTag,
                child: widget.description,
              ),
            ],
          ),
        if (error != null) TableRow(children: [const SizedBox(), animatedError(context)]),
      ],
    ),
  );

  Widget _cell({required EdgeInsetsGeometry padding, required TextStyle textStyle, SemanticsTag? tag, Widget? child}) {
    if (child == null) {
      return const SizedBox();
    }

    final motion = this.motion;
    return Padding(
      padding: padding,
      child: AnimatedDefaultTextStyle(
        style: textStyle,
        duration: motion.textStyleTransitionDuration,
        curve: motion.textStyleTransitionCurve,
        child: tag == null ? child : Semantics(tagForChildren: tag, child: child),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('style', widget.style.toString()))
      ..add(IterableProperty('variants', widget.variants));
  }
}

/// A [Table] with no table/row/cell semantics.
class _Table extends Table {
  new({super.columnWidths, super.defaultColumnWidth, super.defaultVerticalAlignment, super.children});

  @override
  RenderTable createRenderObject(BuildContext context) => _RenderTable(
    columns: children.isNotEmpty ? children[0].children.length : 0,
    rows: children.length,
    columnWidths: columnWidths,
    defaultColumnWidth: defaultColumnWidth,
    textDirection: textDirection ?? Directionality.of(context),
    configuration: createLocalImageConfiguration(context),
    defaultVerticalAlignment: defaultVerticalAlignment,
  );
}

class _RenderTable extends RenderTable {
  new({
    required super.textDirection,
    super.columns,
    super.rows,
    super.columnWidths,
    super.defaultColumnWidth,
    super.configuration,
    super.defaultVerticalAlignment,
  });

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {}
}
