import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

@internal
class const LabelSemantics({required super.child, super.key}) extends SingleChildRenderObjectWidget {
  @override
  RenderLabelSemantics createRenderObject(BuildContext context) => RenderLabelSemantics(Directionality.of(context));

  @override
  void updateRenderObject(BuildContext context, RenderLabelSemantics renderObject) =>
      renderObject.textDirection = Directionality.of(context);
}

@internal
class RenderLabelSemantics(var TextDirection _textDirection) extends RenderProxyBox {
  static const descriptionTag = SemanticsTag('FLabel.description');

  static const errorTag = SemanticsTag('FLabel.error');

  static ChildSemanticsConfigurationsResult _delegate(List<SemanticsConfiguration> configs) {
    final builder = ChildSemanticsConfigurationsResultBuilder();
    for (final config in configs) {
      if (config.tagsChildrenWith(descriptionTag) || config.tagsChildrenWith(errorTag)) {
        builder.markAsMergeUp(
          SemanticsConfiguration()
            ..textDirection = config.textDirection
            ..attributedHint = config.attributedLabel
            ..validationResult = config.validationResult,
        );

        // Live region nodes must be duplicated as merged nodes are not announced.
        if (config.liveRegion) {
          builder.markAsSiblingMergeGroup([config]);
        }
      } else {
        builder.markAsMergeUp(config);
      }
    }

    return builder.build();
  }

  TextDirection get textDirection => _textDirection;

  set textDirection(TextDirection value) {
    if (_textDirection != value) {
      _textDirection = value;
      markNeedsSemanticsUpdate();
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..textDirection = _textDirection
      ..childConfigurationsDelegate = _delegate;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty('textDirection', textDirection));
  }
}
