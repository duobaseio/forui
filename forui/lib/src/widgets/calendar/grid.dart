import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

@internal
class GridFocusableActionDetector extends StatefulWidget {
  final void Function(TraversalDirection, TextDirection) onFocusMove;
  final ValueChanged<bool> onFocusChange;
  final Widget child;

  const GridFocusableActionDetector({
    required this.onFocusMove,
    required this.onFocusChange,
    required this.child,
    super.key,
  });

  @override
  State<GridFocusableActionDetector> createState() => _GridFocusableActionDetectorState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('onFocusMove', onFocusMove))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

class _GridFocusableActionDetectorState extends State<GridFocusableActionDetector> {
  static const Map<ShortcutActivator, Intent> _shortcuts = {
    SingleActivator(.arrowLeft): DirectionalFocusIntent(.left),
    SingleActivator(.arrowRight): DirectionalFocusIntent(.right),
    SingleActivator(.arrowUp): DirectionalFocusIntent(.up),
    SingleActivator(.arrowDown): DirectionalFocusIntent(.down),
  };

  late FocusNode _node;
  late Map<Type, Action<Intent>> _actions;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _actions = {
      DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(
        onInvoke: (intent) => widget.onFocusMove(intent.direction, Directionality.of(context)),
      ),
      // Day cells skip traversal, so Tab/Shift-Tab escape the grid via its traversable node.
      NextFocusIntent: CallbackAction<NextFocusIntent>(
        onInvoke: (_) => _node
          ..requestFocus()
          ..nextFocus(),
      ),
      PreviousFocusIntent: CallbackAction<PreviousFocusIntent>(
        onInvoke: (_) => _node
          ..requestFocus()
          ..previousFocus(),
      ),
    };
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FocusableActionDetector(
    focusNode: _node,
    shortcuts: _shortcuts,
    actions: _actions,
    onFocusChange: widget.onFocusChange,
    child: widget.child,
  );
}

@internal
class GridDelegate extends SliverGridDelegate {
  final Size size;
  final int crossAxisCount;
  final double spacing;

  const GridDelegate(this.size, this.crossAxisCount, this.spacing);

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) => SliverGridRegularTileLayout(
    childCrossAxisExtent: size.width,
    childMainAxisExtent: size.height,
    crossAxisCount: crossAxisCount,
    crossAxisStride: size.width,
    mainAxisStride: size.height + spacing,
    reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
  );

  @override
  bool shouldRelayout(GridDelegate old) =>
      size != old.size || crossAxisCount != old.crossAxisCount || spacing != old.spacing;
}

@internal
abstract class GridController extends FChangeNotifier {
  @internal
  static bool debugCheckInclusiveMonthRange(DateTime start, DateTime date, DateTime end) {
    assert(() {
      final startMonth = DateTime.utc(start.year, start.month);
      final dateMonth = DateTime.utc(date.year, date.month);
      final endMonth = DateTime.utc(end.year, end.month);

      if (dateMonth.isBefore(startMonth) || dateMonth.isAfter(endMonth)) {
        throw FlutterError.fromParts([
          ErrorSummary("date's month is not within [start, end]."),
          DiagnosticsProperty('The offending date is', date, style: .errorProperty),
          DiagnosticsProperty("The offending date's month is", dateMonth, style: .errorProperty),
          DiagnosticsProperty('The start is', start, style: .errorProperty),
          DiagnosticsProperty('The end is', end, style: .errorProperty),
          ErrorHint("To fix this, ensure the date's month is within start's and end's months."),
        ]);
      }
      return true;
    }());

    return true;
  }

  /// The start date, inclusive.
  final DateTime start;

  /// The end date, inclusive.
  final DateTime end;

  final int _columns;
  final bool Function(DateTime) _selectable;
  final DateTime? Function(DateTime, DateTime) _focusable;
  final DateTime Function(DateTime, int) _step;
  final int Function(DateTime) _from;
  final DateTime Function(int) _to;
  PageController _controller;
  DateTime? _focused;
  DateTime _current;

  GridController({
    required this.start,
    required this.end,
    required this._columns,
    required this._selectable,
    required this._focusable,
    required this._step,
    required this._from,
    required this._to,
    required DateTime initial,
    this._focused,
  }) : assert(start.isUtc, 'start must be in UTC'),
       assert(end.isUtc, 'end must be in UTC'),
       assert(start.isBefore(end) || start.isAtSameMomentAs(end), 'start must be before or equal to end'),
       assert(debugCheckInclusiveMonthRange(start, initial, end)),
       _controller = PageController(initialPage: _from(initial)),
       _current = _to(_from(initial));

  /// Moves focus one date horizontally or one row vertically in [direction], honoring [textDirection]. Skips
  /// unselectable dates and pages across as needed. Does nothing if no selectable date exists in that direction within
  /// [start] and [end].
  Future<void> move(
    TraversalDirection direction,
    TextDirection textDirection, {
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.ease,
  }) async {
    final step = switch ((direction, textDirection)) {
      (.left, .ltr) || (.right, .rtl) => -1,
      (.right, .ltr) || (.left, .rtl) => 1,
      (.up, _) => -_columns,
      (.down, _) => _columns,
    };

    var next = _step(_focused ?? _current, step);
    while (!next.isBefore(start) && !next.isAfter(end)) {
      if (_selectable(next)) {
        await focus(next, duration: duration, curve: curve);
        return;
      }
      next = _step(next, step);
    }
  }

  /// Focuses on [date], animating to its page if necessary. Unfocuses if [date] is null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [date] is not within `[start, end]`.
  Future<void> focus(
    DateTime? date, {
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.ease,
  }) async {
    if (date == _focused) {
      return;
    }

    _focused = date;
    if (date != null && _from(date) != _from(_current)) {
      assert(debugCheckInclusiveDateRange(start, date, end));
      await _controller.animateToPage(_from(date), duration: duration, curve: curve);
    }

    notifyListeners();
  }

  /// Animates the current page to the next page. Does nothing if it is the last page.
  Future<void> next({Duration duration = const Duration(milliseconds: 200), Curve curve = Curves.ease}) async {
    if (_from(_current) case final page when page < _from(end)) {
      await _controller.animateToPage(page + 1, duration: duration, curve: curve);
    }
  }

  /// Animates the current page to the previous page. Does nothing if it is the first page.
  Future<void> previous({Duration duration = const Duration(milliseconds: 200), Curve curve = Curves.ease}) async {
    if (_from(_current) case final page when 0 < page) {
      await _controller.animateToPage(page - 1, duration: duration, curve: curve);
    }
  }

  /// Animates the current page to the given [date]'s page.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [date] is not within `[start, end]`.
  Future<void> animateTo(
    DateTime date, {
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.ease,
  }) {
    assert(debugCheckInclusiveDateRange(start, date, end));
    return _controller.animateToPage(_from(date), duration: duration, curve: curve);
  }

  /// Jumps the current page to the given [date]'s page.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [date] is not within `[start, end]`.
  void jumpTo(DateTime date) {
    assert(debugCheckInclusiveDateRange(start, date, end));
    _controller.jumpToPage(_from(date));
  }

  /// The currently focused date, or null if nothing is focused.
  DateTime? get focused => _focused;

  /// The number of pages between [start] and [end], inclusive.
  int get pages => _from(end) + 1;

  /// Whether the previous page can be displayed.
  bool get hasPrevious => 0 < _from(_current);

  /// Whether the next page can be displayed.
  bool get hasNext => _from(_current) < _from(end);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@internal
extension InternalPickerController on GridController {
  void reattach(DateTime date) {
    assert(GridController.debugCheckInclusiveMonthRange(start, date, end));
    assert(!_controller.hasClients, 'reattach() must be called while no grid is mounted with this controller.');
    _controller.dispose();
    _focused = null;
    _current = _to(_from(date));
    _controller = PageController(initialPage: _from(date));
  }

  void onPageChange(int page) {
    if (to(page) case final current when current != _current) {
      _current = current;
      if (_focused case final focused? when _from(focused) != _from(current)) {
        _focused = _focusable(current, focused); // Update keyboard focus into the new page.
      }

      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      notifyListeners();
    }
  }

  int from(DateTime date) => _from(date);

  DateTime to(int page) => _to(page);

  PageController get controller => _controller;

  bool Function(DateTime) get selectable => _selectable;

  DateTime? Function(DateTime, DateTime) get focusable => _focusable;

  DateTime get current => _current;
}
