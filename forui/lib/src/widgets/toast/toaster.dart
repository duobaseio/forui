import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/toast/toaster_stack.dart';

/// Displays a [FToast] in a toaster.
///
/// [alignment] defaults to [FToasterStyle.toastAlignment].
///
/// [swipeToDismiss] represents axes in which to swipe to dismiss a toast. Defaults to horizontally towards the closest
/// edge of the screen with a left bias. For example, if [alignment] is [FToastAlignment.bottomRight], the default swipe
/// direction is [AxisDirection.right].
///
/// Set [swipeToDismiss] to an empty list to disable swiping to dismiss.
///
/// [duration] controls the duration which the toast is shown. Defaults to 5 seconds. Set [duration] to null to disable
/// auto-dismissing.
///
/// ## Contract
/// Throws [FlutterError] if there is no ancestor [FToaster] in the given [context].
///
/// See:
/// * https://forui.dev/docs/overlay/toast for working examples.
/// * [showFToast] for displaying a toast in a toaster.
/// * [FToasterStyle] for customizing a toaster's appearance.
/// * [FToastStyle] for customizing a toast's appearance.
FToasterEntry showFToast({
  required BuildContext context,
  required Widget title,
  FToastStyleDelta style = const .inherit(),
  Widget? icon,
  Widget? description,
  Widget Function(BuildContext context, FToasterEntry entry)? suffixBuilder,
  FToastAlignment? alignment,
  List<AxisDirection>? swipeToDismiss,
  Duration? duration = const Duration(seconds: 5),
  VoidCallback? onDismiss,
}) {
  final state = context.findAncestorStateOfType<FToasterState>();
  if (state == null) {
    throw FlutterError.fromParts([
      ErrorSummary('showFToast(...) called with a context that does not contain a FToaster.'),
      ErrorDescription(
        'No FToaster ancestor could be found starting from the context that was passed to showFToast(...). '
        'This usually happens when the context provided is from the same StatefulWidget as that whose build function '
        'actually creates the FToaster widget being sought.',
      ),
      ErrorHint(
        'There are several ways to avoid this problem. The simplest is to use a Builder to get a '
        'context that is "under" the FToaster.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  return state.show(
    context: context,
    builder: (context, entry) => FToast(
      style: style,
      icon: icon,
      title: title,
      description: description,
      suffix: suffixBuilder?.call(context, entry),
    ),
    style: style,
    alignment: alignment,
    swipeToDismiss: swipeToDismiss,
    duration: duration,
    onDismiss: onDismiss,
  );
}

/// Displays a raw toast in a toaster.
///
/// [alignment] defaults to [FToasterStyle.toastAlignment].
///
/// [swipeToDismiss] represents axes in which to swipe to dismiss a toast. Defaults to horizontally towards the closest
/// edge of the screen with a left bias. For example, if [alignment] is [FToastAlignment.bottomRight], the default swipe
/// direction is [AxisDirection.right].
///
/// Set [swipeToDismiss] to an empty list to disable swiping to dismiss.
///
/// [duration] controls the duration which the toast is shown. Defaults to 5 seconds. Set [duration] to null to disable
/// auto-closing.
///
/// ## Contract
/// Throws [FlutterError] if there is no ancestor [FToaster] in the given [context].
///
/// See:
/// * https://forui.dev/docs/overlay/toast for working examples.
/// * [showFToast] for displaying a toast in a toaster.
/// * [FToasterStyle] for customizing a toaster's appearance.
/// * [FToastStyle] for customizing a toast's appearance.
FToasterEntry showRawFToast({
  required BuildContext context,
  required Widget Function(BuildContext context, FToasterEntry entry) builder,
  FToastStyleDelta style = const .inherit(),
  FToastAlignment? alignment,
  List<AxisDirection>? swipeToDismiss,
  Duration? duration = const Duration(seconds: 5),
  VoidCallback? onDismiss,
}) {
  final state = context.findAncestorStateOfType<FToasterState>();
  if (state == null) {
    throw FlutterError.fromParts([
      ErrorSummary('showRawFToast(...) called with a context that does not contain a FToaster.'),
      ErrorDescription(
        'No FToaster ancestor could be found starting from the context that was passed to showFToast(...). '
        'This usually happens when the context provided is from the same StatefulWidget as that whose build function '
        'actually creates the FToaster widget being sought.',
      ),
      ErrorHint(
        'There are several ways to avoid this problem. The simplest is to use a Builder to get a '
        'context that is "under" the FToaster.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  return state.show(
    context: context,
    builder: builder,
    style: style,
    alignment: alignment,
    swipeToDismiss: swipeToDismiss,
    duration: duration,
    onDismiss: onDismiss,
  );
}

/// The toast's alignment.
final class FToastAlignment {
  /// Aligns the toasts to the top start of the screen, depending on the locale's text direction.
  ///
  /// Top left in LTR locales, top right in RTL locales.
  static const topStart = FToastAlignment._(AlignmentDirectional.topStart, Alignment.bottomCenter);

  /// Aligns the toasts to the start of the screen, depending on the locale's text direction.
  ///
  /// Top right in LTR locales, top left in RTL locales.
  static const topEnd = FToastAlignment._(AlignmentDirectional.topEnd, Alignment.bottomCenter);

  /// Aligns the toasts to the top left of the screen.
  static const topLeft = FToastAlignment._(.topLeft, .bottomCenter);

  /// Aligns the toasts to the top right of the screen.
  static const topRight = FToastAlignment._(.topRight, .bottomCenter);

  /// Aligns the toasts to the top center of the screen.
  static const topCenter = FToastAlignment._(.topCenter, .bottomCenter);

  /// Aligns the toasts to the bottom start of the screen, depending on the locale's text direction.
  ///
  /// Bottom left in LTR locales, bottom right in RTL locales.
  static const bottomStart = FToastAlignment._(AlignmentDirectional.bottomStart, .topCenter);

  /// Aligns the toasts to the bottom end of the screen, depending on the locale's text direction.
  ///
  /// Bottom right in LTR locales, bottom right in RTL locales.
  static const bottomEnd = FToastAlignment._(AlignmentDirectional.bottomEnd, .topCenter);

  /// Aligns the toasts to the bottom left of the screen.
  static const bottomLeft = FToastAlignment._(.bottomLeft, .topCenter);

  /// Aligns the toasts to the bottom right of the screen.
  static const bottomRight = FToastAlignment._(.bottomRight, .topCenter);

  /// Aligns the toasts to the bottom center of the screen.
  static const bottomCenter = FToastAlignment._(.bottomCenter, .topCenter);

  final AlignmentGeometry _alignment;
  final Alignment _toastAlignment;

  const FToastAlignment._(this._alignment, this._toastAlignment);

  /// Creates a [FToastAlignment] with the given alignments.
  ///
  /// It is typically recommended to use one of the constants instead. Use this only if you need fine-grained control
  /// over the toast's positioning.
  ///
  /// [AlignmentGeometry] controls where the toast appears on the screen while [toastAlignment] controls how the toasts
  /// vertically stack.
  ///
  /// ```dart
  /// // Toasts appear between the top left and top center, and stack downward from the top.
  /// // Top left is (0, 0).
  /// FToastAlignment(Alignment(-0.5, -1), 1);
  ///
  /// // Toasts appear at bottom-left and stack upward from the bottom.
  /// FToastAlignment(Alignment.bottomLeft, 1);
  ///
  /// // Toasts appear at top-center and stack downward from the top.
  /// FToastAlignment(Alignment.topCenter, -1);
  /// ```
  ///
  /// ## Contract
  /// Throws [AssertionError] if [toastAlignment] is not between -1 and 1, inclusive.
  FToastAlignment(this._alignment, double toastAlignment)
    : assert(
        toastAlignment >= -1 && toastAlignment <= 1,
        'toastAlignment ($toastAlignment) must be between -1 and 1, inclusive.',
      ),
      _toastAlignment = Alignment(0, toastAlignment);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FToastAlignment &&
          runtimeType == other.runtimeType &&
          _alignment == other._alignment &&
          _toastAlignment == other._toastAlignment;

  @override
  int get hashCode => Object.hash(_alignment, _toastAlignment);

  @override
  String toString() => 'FToastAlignment(alignment: $_alignment, toastAlignment: $_toastAlignment)';
}

/// An opinionated toast widget.
///
/// This widget manages a stack of toasts that can be added to using [showRawFToast]. It should be placed near the root
/// of the widget tree, such as `WidgetsApp.builder(...)/MaterialApp.builder(...)/CupertinoApp.builder(...)`:
/// ```dart
/// MaterialApp(
///   builder: (context, child) => FAnimatedTheme(
///     data: FThemes.zinc.light,
///     child: FToaster(child: child!),
///   ),
///   home: HomePage(),
/// );
/// ```
///
/// See:
/// * https://forui.dev/docs/overlay/toaster for working examples.
/// * [showFToast] for displaying a toast in a toaster.
/// * [showRawFToast] for displaying a raw toast in a toaster.
/// * [FToasterStyle] for customizing a toaster's appearance.
class FToaster extends StatefulWidget {
  /// The state from the closest instance of this class that encloses the given
  /// context.
  static FToasterState of(BuildContext context) => context.findAncestorStateOfType<FToasterState>()!;

  /// The style.
  final FToasterStyleDelta style;

  /// The child.
  final Widget child;

  /// Creates a [FToaster] widget.
  const FToaster({required this.child, this.style = const .inherit(), super.key});

  @override
  State<FToaster> createState() => FToasterState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A [FToaster]'s state.
class FToasterState extends State<FToaster> {
  final Map<Alignment, (Alignment, List<ToasterEntry>)> _entries = {};

  /// Displays a toast in this toaster.
  ///
  /// It is generally recommend to use [showFToast] or [showRawFToast] instead.
  ///
  /// See [showRawFToast] for more information about the parameters.
  FToasterEntry show({
    required Widget Function(BuildContext context, FToasterEntry entry) builder,
    BuildContext? context,
    FToastStyleDelta style = const .inherit(),
    FToastAlignment? alignment,
    List<AxisDirection>? swipeToDismiss,
    Duration? duration = const Duration(seconds: 5),
    VoidCallback? onDismiss,
  }) {
    context ??= this.context;

    final direction = Directionality.maybeOf(context) ?? .ltr;
    final toasterStyle = widget.style(context.theme.toasterStyle);
    final resolved = (alignment ?? toasterStyle.toastAlignment)._alignment.resolve(direction);
    final directions = swipeToDismiss ?? [if (resolved.x < 1) .left else .right];

    final entry = ToasterEntry(
      style(toasterStyle.toastStyle),
      resolved,
      directions,
      duration,
      builder,
    );
    entry.onDismiss = () {
      entry.dismissing.value = true;
      _remove(entry);
      onDismiss?.call();
    };

    if (!mounted) {
      return entry;
    }

    setState(() {
      final (_, entries) = _entries[resolved] ??= ((alignment ?? toasterStyle.toastAlignment)._toastAlignment, []);
      entries.add(entry);
    });

    return entry;
  }

  void _remove(ToasterEntry entry) {
    if (!mounted) {
      return;
    }

    final direction = Directionality.maybeOf(context) ?? .ltr;
    if (_entries[entry.alignment.resolve(direction)]?.$2 case final entries?) {
      setState(() {
        entries.remove(entry);
        entry.dismissing.dispose();
      });
    }
  }

  @override
  void dispose() {
    for (final MapEntry(value: entries) in _entries.entries) {
      for (final entry in entries.$2) {
        entry.dismissing.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style.call(context.theme.toasterStyle);
    final children = [widget.child];

    for (final MapEntry(key: alignment, value: (toastAlignment, entries)) in _entries.entries) {
      children.add(
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: style.padding,
              child: Align(
                alignment: alignment,
                child: ToasterStack(
                  style: style,
                  expandedAlignTransform: Offset(alignment.x, alignment.y),
                  collapsedAlignTransform: Offset(toastAlignment.x, toastAlignment.y),
                  entries: entries,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Stack(clipBehavior: .none, fit: .passthrough, children: children);
  }
}

/// An entry in a toaster.
mixin FToasterEntry {
  /// Dismisses the toast. Does nothing if the toast is already being dismissed or dismissed.
  void dismiss();

  /// True if the toast is currently displayed and not being dismissed.
  bool get showing;
}

@internal
class ToasterEntry with FToasterEntry {
  final GlobalKey key = GlobalKey();
  final FToastStyle? style;
  final Alignment alignment;
  List<AxisDirection> swipeToDismiss;
  final Duration? duration;
  final ValueNotifier<bool> dismissing = ValueNotifier(false);
  final Widget Function(BuildContext context, FToasterEntry entry) builder;
  VoidCallback? onDismiss;

  ToasterEntry(this.style, this.alignment, this.swipeToDismiss, this.duration, this.builder);

  @override
  void dismiss() {
    if (onDismiss == null || dismissing.value) {
      return;
    }

    dismissing.value = true;
  }

  @override
  bool get showing => onDismiss != null && !dismissing.value;
}
