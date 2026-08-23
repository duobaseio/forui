import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// The sheet's gesture detector. We use a [RawGestureDetector] instead of a [GestureDetector] because the latter
/// doesn't allow [DragGestureRecognizer.onlyAcceptDragOnThreshold] to be configured.
///
/// This is based on Material's _BottomSheetGestureDetector.
@internal
class const SheetGestureDetector({
  required final FLayout layout,
  required final GestureDragStartCallback? onStart,
  required final GestureDragUpdateCallback? onUpdate,
  required final GestureDragEndCallback? onEnd,
  required final Widget child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext _) {
    void initialize(DragGestureRecognizer recognizer) {
      recognizer
        ..onStart = onStart
        ..onUpdate = onUpdate
        ..onEnd = onEnd
        ..onlyAcceptDragOnThreshold = true;
    }

    return RawGestureDetector(
      excludeFromSemantics: true,
      gestures: {
        if (layout.vertical)
          VerticalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer(debugOwner: this),
            initialize,
          )
        else
          HorizontalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
            () => HorizontalDragGestureRecognizer(debugOwner: this),
            initialize,
          ),
      },
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('layout', layout))
      ..add(ObjectFlagProperty.has('onStart', onStart))
      ..add(ObjectFlagProperty.has('onUpdate', onUpdate))
      ..add(ObjectFlagProperty.has('onEnd', onEnd));
  }
}
