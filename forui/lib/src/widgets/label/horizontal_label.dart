import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/src/widgets/label/label.dart';

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
  Widget build(BuildContext context) => Table(
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
              child: widget.description,
            ),
          TableCell(
            child: Padding(padding: widget.style.childPadding, child: widget.child),
          ),
        ],
      ),
      if (widget.label != null && widget.description != null)
        TableRow(
          children: [
            _cell(
              padding: widget.style.descriptionPadding,
              textStyle: widget.style.descriptionTextStyle.resolve(widget.variants),
              child: widget.description,
            ),
            const TableCell(child: SizedBox()),
          ],
        ),
      if (error != null)
        TableRow(
          children: [
            TableCell(child: animatedError(context)),
            const TableCell(child: SizedBox()),
          ],
        ),
    ],
  );

  Widget _cell({required EdgeInsetsGeometry padding, required TextStyle textStyle, Widget? child}) {
    if (child == null) {
      return const TableCell(child: SizedBox());
    }

    final motion = this.motion;
    return TableCell(
      child: Padding(
        padding: padding,
        child: AnimatedDefaultTextStyle(
          style: textStyle,
          duration: motion.textStyleTransitionDuration,
          curve: motion.textStyleTransitionCurve,
          child: child,
        ),
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
  Widget build(BuildContext context) => Table(
    defaultColumnWidth: const IntrinsicColumnWidth(),
    defaultVerticalAlignment: .middle,
    columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
    children: [
      TableRow(
        children: [
          TableCell(
            child: Padding(padding: widget.style.childPadding, child: widget.child),
          ),
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
              child: widget.description,
            ),
        ],
      ),
      if (widget.label != null && widget.description != null)
        TableRow(
          children: [
            const TableCell(child: SizedBox()),
            _cell(
              padding: widget.style.descriptionPadding,
              textStyle: widget.style.descriptionTextStyle.resolve(widget.variants),
              child: widget.description,
            ),
          ],
        ),
      if (error != null)
        TableRow(
          children: [
            const TableCell(child: SizedBox()),
            TableCell(child: animatedError(context)),
          ],
        ),
    ],
  );

  Widget _cell({required EdgeInsetsGeometry padding, required TextStyle textStyle, Widget? child}) {
    if (child == null) {
      return const TableCell(child: SizedBox());
    }

    final motion = this.motion;
    return TableCell(
      child: Padding(
        padding: padding,
        child: AnimatedDefaultTextStyle(
          style: textStyle,
          duration: motion.textStyleTransitionDuration,
          curve: motion.textStyleTransitionCurve,
          child: child,
        ),
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
