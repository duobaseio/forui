import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

@internal
class const HintSemantics({required super.child, super.key}) extends SingleChildRenderObjectWidget {
  @override
  RenderHintSemantics createRenderObject(BuildContext context) => RenderHintSemantics();
}

@internal
class RenderHintSemantics extends RenderProxyBox {
  static const hintTag = SemanticsTag('FMultiSelect.hint');

  static ChildSemanticsConfigurationsResult _delegate(List<SemanticsConfiguration> configs) {
    final builder = ChildSemanticsConfigurationsResultBuilder();
    for (final config in configs) {
      if (config.tagsChildrenWith(hintTag)) {
        builder.markAsMergeUp(
          SemanticsConfiguration()
            ..textDirection = config.textDirection
            ..attributedHint = config.attributedLabel,
        );
      } else {
        builder.markAsMergeUp(config);
      }
    }

    return builder.build();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.childConfigurationsDelegate = _delegate;
  }
}
