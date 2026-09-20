import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

@internal
extension MenuNavigation on FocusScopeNode {
  KeyEventResult navigate(KeyEvent event) {
    final items = ReadingOrderTraversalPolicy()
        .sortDescendants(
          traversalDescendants.where((node) => node is! FocusScopeNode && node.enclosingScope == this),
          this,
        )
        .toList();
    if (items.isEmpty) {
      return .ignored;
    }

    final current = items.indexWhere((node) => node.hasFocus);
    final index = switch (event.logicalKey) {
      .home => 0,
      .end => items.length - 1,
      .arrowUp => (max(current, 0) - 1) % items.length,
      .arrowDown => (current + 1) % items.length,
      _ => null,
    };
    if (index == null) {
      return .ignored;
    }

    FocusTraversalPolicy.defaultTraversalRequestFocusCallback(items[index]);
    return .handled;
  }
}
