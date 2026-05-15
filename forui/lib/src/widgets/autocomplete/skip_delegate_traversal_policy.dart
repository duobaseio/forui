import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A [FocusTraversalPolicy] that skips:
/// * the popover's [FocusScopeNode] when the current focus is outside of it.
/// * any [FocusScopeNode] with no traversal descendants.
///
/// This shifts the focus from the autocomplete to the next focusable widget when the user presses tab, instead of
/// stepping into the popover.
///
/// It also allows the focus to move between suggestions when the focus is already inside of the popover and the user
/// presses tab.
@internal
class SkipDelegateTraversalPolicy with Diagnosticable implements FocusTraversalPolicy {
  final FocusTraversalPolicy _delegate;
  final FocusScopeNode _popover;

  SkipDelegateTraversalPolicy(this._delegate, this._popover);

  @override
  TraversalRequestFocusCallback get requestFocusCallback => _delegate.requestFocusCallback;

  @override
  FocusNode? findFirstFocus(FocusNode currentNode, {bool ignoreCurrentFocus = false}) =>
      _delegate.findFirstFocus(currentNode, ignoreCurrentFocus: ignoreCurrentFocus);

  @override
  FocusNode findLastFocus(FocusNode currentNode, {bool ignoreCurrentFocus = false}) =>
      _delegate.findLastFocus(currentNode, ignoreCurrentFocus: ignoreCurrentFocus);

  @override
  FocusNode? findFirstFocusInDirection(FocusNode currentNode, TraversalDirection direction) =>
      _delegate.findFirstFocusInDirection(currentNode, direction);

  @override
  void invalidateScopeData(FocusScopeNode node) => _delegate.invalidateScopeData(node);

  @override
  void changedScope({FocusNode? node, FocusScopeNode? oldScope}) =>
      _delegate.changedScope(node: node, oldScope: oldScope);

  @override
  bool next(FocusNode currentNode) => _delegate.next(currentNode);

  @override
  bool previous(FocusNode currentNode) => _delegate.previous(currentNode);

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) =>
      _delegate.inDirection(currentNode, direction);

  @override
  Iterable<FocusNode> sortDescendants(Iterable<FocusNode> descendants, FocusNode currentNode) {
    final inside = currentNode == _popover || currentNode.ancestors.contains(_popover);
    return _delegate.sortDescendants(
      descendants.where(
        (d) =>
            (inside || (d != _popover && !d.ancestors.contains(_popover))) &&
            (d is! FocusScopeNode || d.traversalDescendants.isNotEmpty),
      ),
      currentNode,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    return _delegate.debugFillProperties(properties);
  }
}
