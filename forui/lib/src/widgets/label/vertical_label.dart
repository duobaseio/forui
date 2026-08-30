import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/src/widgets/label/label.dart';
import 'package:forui/src/widgets/label/semantics.dart';

@internal
class VerticalLabel extends Label {
  final bool expands;

  const new({
    required super.style,
    required super.label,
    required super.description,
    required super.error,
    required super.variants,
    required super.child,
    required this.expands,
    super.key,
  });

  @override
  State<VerticalLabel> createState() => _VerticalLabelState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('expands', value: expands, ifTrue: 'expands'));
  }
}

class _VerticalLabelState extends LabelState<VerticalLabel> {
  @override
  Widget build(BuildContext context) {
    final motion = this.motion;
    return LabelSemantics(
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          if (widget.label != null)
            Padding(
              padding: widget.style.labelPadding,
              child: AnimatedDefaultTextStyle(
                style: widget.style.labelTextStyle.resolve(widget.variants),
                duration: motion.textStyleTransitionDuration,
                curve: motion.textStyleTransitionCurve,
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                child: widget.label!,
              ),
            ),
          if (widget.expands)
            Expanded(
              child: Padding(padding: widget.style.childPadding, child: widget.child),
            )
          else
            Padding(padding: widget.style.childPadding, child: widget.child),
          if (widget.description != null)
            Padding(
              padding: widget.style.descriptionPadding,
              child: AnimatedDefaultTextStyle(
                style: widget.style.descriptionTextStyle.resolve(widget.variants),
                duration: motion.textStyleTransitionDuration,
                curve: motion.textStyleTransitionCurve,
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                child: Semantics(tagForChildren: RenderLabelSemantics.descriptionTag, child: widget.description!),
              ),
            ),
          if (error != null) animatedError(context, const TextHeightBehavior(applyHeightToFirstAscent: false)),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('style', widget.style.toString()))
      ..add(FlagProperty('expands', value: widget.expands, ifTrue: 'expands'))
      ..add(IterableProperty('variants', widget.variants));
  }
}
