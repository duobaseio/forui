import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

/// Pages the grid by [direction] (-1 up / 1 down). [large] jump a year in the day grid, a decade/century in the
/// month/year grids.
class _PageIntent extends Intent {
  final int direction;
  final bool large;

  const _PageIntent(this.direction, {this.large = false});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('direction', direction))
      ..add(FlagProperty('large', value: large, ifTrue: 'large'));
  }
}

/// Moves focus to the first or last selectable cell of the focused cell's row.
class _RowEdgeIntent extends Intent {
  final bool end;

  const _RowEdgeIntent({required this.end});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('end', value: end, ifTrue: 'end'));
  }
}

@internal
class GridFocusableActionDetector extends StatefulWidget {
  final void Function(TraversalDirection, TextDirection) onFocusMove;
  final void Function(int direction, {bool large}) onFocusPage;
  final void Function({required bool end}) onFocusRowEdge;
  final ValueChanged<bool> onFocusChange;
  final Widget child;

  const GridFocusableActionDetector({
    required this.onFocusMove,
    required this.onFocusPage,
    required this.onFocusRowEdge,
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
      ..add(ObjectFlagProperty.has('onFocusPage', onFocusPage))
      ..add(ObjectFlagProperty.has('onFocusRowEdge', onFocusRowEdge))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

class _GridFocusableActionDetectorState extends State<GridFocusableActionDetector> {
  static const Map<ShortcutActivator, Intent> _shortcuts = {
    SingleActivator(.arrowLeft): DirectionalFocusIntent(.left),
    SingleActivator(.arrowRight): DirectionalFocusIntent(.right),
    SingleActivator(.arrowUp): DirectionalFocusIntent(.up),
    SingleActivator(.arrowDown): DirectionalFocusIntent(.down),
    SingleActivator(.pageUp): _PageIntent(-1),
    SingleActivator(.pageDown): _PageIntent(1),
    SingleActivator(.pageUp, shift: true): _PageIntent(-1, large: true),
    SingleActivator(.pageDown, shift: true): _PageIntent(1, large: true),
    SingleActivator(.home): _RowEdgeIntent(end: false),
    SingleActivator(.end): _RowEdgeIntent(end: true),
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
      _PageIntent: CallbackAction<_PageIntent>(
        onInvoke: (intent) => widget.onFocusPage(intent.direction, large: intent.large),
      ),
      _RowEdgeIntent: CallbackAction<_RowEdgeIntent>(onInvoke: (intent) => widget.onFocusRowEdge(end: intent.end)),
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
  bool _reduceMotion = false;
  DateTime? _focused;
  DateTime _current;
  (int, int)? _animation;

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
      await _animateTo(_from(date), duration, curve);
    }

    notifyListeners();
  }

  /// Animates the current page to the next page. Does nothing if it is the last page.
  Future<void> next({Duration duration = const Duration(milliseconds: 200), Curve curve = Curves.ease}) async {
    if (_from(_current) case final page when page < _from(end)) {
      await _animateTo(page + 1, duration, curve);
    }
  }

  /// Animates the current page to the previous page. Does nothing if it is the first page.
  Future<void> previous({Duration duration = const Duration(milliseconds: 200), Curve curve = Curves.ease}) async {
    if (_from(_current) case final page when 0 < page) {
      await _animateTo(page - 1, duration, curve);
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
    return _animateTo(_from(date), duration, curve);
  }

  Future<void> _animateTo(int page, Duration duration, Curve curve) async {
    if (_reduceMotion) {
      _controller.jumpToPage(page);
      return;
    }

    _animation = (_controller.hasClients ? (_controller.page?.round() ?? _from(_current)) : _from(_current), page);
    final animation = _animation;

    try {
      await _controller.animateToPage(page, duration: duration, curve: curve);
    } finally {
      if (_animation == animation) {
        _animation = null;
      }
    }
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

  /// Animates [delta] pages from the current page, clamped to the valid range. Does nothing at the first/last page.
  Future<void> page(
    int delta, {
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.ease,
  }) async {
    if ((_from(_current) + delta).clamp(0, _from(end)) case final target when target != _from(_current)) {
      await _animateTo(target, duration, curve);
    }
  }

  /// Focuses the first or last selectable date within `[low, high]`.
  Future<void> edge(DateTime low, DateTime high, {required bool end}) async {
    low = low.isBefore(start) ? start : low;
    high = high.isAfter(this.end) ? this.end : high;
    final (first, step) = end ? (high, -1) : (low, 1);

    for (var date = first; !date.isBefore(low) && !date.isAfter(high); date = _step(date, step)) {
      if (_selectable(date)) {
        await focus(date);
        return;
      }
    }
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

  set reduceMotion(bool value) => _reduceMotion = value;

  bool Function(DateTime) get selectable => _selectable;

  DateTime? Function(DateTime, DateTime) get focusable => _focusable;

  DateTime get current => _current;

  /// The start and end pages of the current programmatic animation, or null if none is running.
  (int, int)? get animation => _animation;
}
