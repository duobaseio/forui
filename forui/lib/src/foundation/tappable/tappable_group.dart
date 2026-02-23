import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable/tappable_group_recognizer.dart';

/// A group of [FTappable]s that enables slide-across interaction.
///
/// When the user presses one tappable and slides their finger to another, the pressed state transfers to the new
/// tappable. This is the pattern used in action sheets, where you can slide between buttons and the highlight follows
/// your finger.
///
/// Only primary press and long-press gestures are group-managed. Other gestures like [FTappable.onDoubleTap],
/// [FTappable.onSecondaryPress], and [FTappable.onSecondaryLongPress] remain on individual tappables.
class FTappableGroup extends StatefulWidget {
  /// The child widget, typically containing multiple [FTappable]s.
  final Widget child;

  /// Creates an [FTappableGroup].
  const FTappableGroup({required this.child, super.key});

  @override
  State<FTappableGroup> createState() => _FTappableGroupState();
}

class _FTappableGroupState extends State<FTappableGroup> {
  final List<GroupEntry> _entries = [];

  @override
  Widget build(BuildContext context) => TappableGroupScope(
    entries: _entries,
    child: RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        TappableGroupGestureRecognizer: GestureRecognizerFactoryWithHandlers<TappableGroupGestureRecognizer>(
          () => TappableGroupGestureRecognizer(_entries),
          (instance) => instance.entries = _entries,
        ),
      },
      child: widget.child,
    ),
  );
}

@internal
class TappableGroupScope extends InheritedWidget {
  static List<GroupEntry>? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TappableGroupScope>()?.entries;

  final List<GroupEntry> entries;

  const TappableGroupScope({required this.entries, required super.child, super.key});

  // Comparing using identity is fine as it is tied to the lifecycle of the owning tappable group.
  @override
  bool updateShouldNotify(TappableGroupScope old) => entries != old.entries;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('entries', entries));
  }
}

@internal
class GroupEntry {
  final BuildContext context;
  final Future<void> Function(int) onPressStart;
  final Future<void> Function() onPressCancel;
  final Future<void> Function() onPressEnd;
  VoidCallback? onPress;
  VoidCallback? onLongPress;

  GroupEntry({
    required this.context,
    required this.onPressStart,
    required this.onPressCancel,
    required this.onPressEnd,
    required this.onPress,
    required this.onLongPress,
  });

  bool hitTest(Offset globalPosition) {
    final box = context.findRenderObject();
    return box is RenderBox && box.size.contains(box.globalToLocal(globalPosition));
  }
}
