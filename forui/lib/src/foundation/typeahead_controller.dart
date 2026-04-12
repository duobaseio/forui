import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A function type that provides text styles for the typeahead controller.
typedef FTypeaheadControllerTextStyles =
    (TextStyle textStyle, TextStyle composingStyle, TextStyle? completionStyle) Function(BuildContext context);

/// A suggestion used by [FTypeaheadController].
class FTypeaheadSuggestion<T> {
  /// The text shown in the field and used for matching.
  final String text;

  /// The suggestion's underlying data.
  final T data;

  /// Creates a [FTypeaheadSuggestion].
  const FTypeaheadSuggestion({required this.text, required this.data});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTypeaheadSuggestion && runtimeType == other.runtimeType && text == other.text && data == other.data);

  @override
  int get hashCode => text.hashCode ^ data.hashCode;
}

/// A [TextEditingController] with typeahead support.
///
/// A typeahead controller manages suggestions and provides inline completions as the user types. When the current text
/// matches the beginning of a suggestion, the remaining text is shown as a completion that can be accepted.
class FTypeaheadController<T> extends TextEditingController {
  /// The default converter used to derive display text from a suggestion.
  static String defaultDisplayStringForOption(Object? option) => option.toString();

  final FTypeaheadControllerTextStyles _textStyles;
  List<FTypeaheadSuggestion<T>> _suggestions;
  ({String completion, String replacement})? _current;
  T? _currentData;

  /// Converts a suggestion into the display text used for matching and completion.
  String Function(T option) displayStringForOption;

  /// A monotonic counter to ensure that only latest suggestions are processed. This prevents stale data from being
  /// processed when the suggestions are provided async.
  int _monotonic = 0;
  bool _disposed = false;

  /// Creates a [FTypeaheadController] with an optional initial text and completion.
  FTypeaheadController({
    required FTypeaheadControllerTextStyles textStyles,
    String Function(T option)? displayStringForOption,
    List<T> suggestions = const [],
    super.text,
  }) : _textStyles = textStyles,
       displayStringForOption = displayStringForOption ?? _defaultDisplayStringForOption,
       _suggestions = [] {
    _suggestions = _normalizeSuggestions(suggestions);
    findCompletion();
  }

  /// Creates a [FTypeaheadController] from a [TextEditingValue].
  FTypeaheadController.fromValue(
    super.value, {
    required FTypeaheadControllerTextStyles textStyles,
    String Function(T option)? displayStringForOption,
    List<T> suggestions = const [],
  }) : _textStyles = textStyles,
       displayStringForOption = displayStringForOption ?? _defaultDisplayStringForOption,
       _suggestions = [],
       super.fromValue() {
    _suggestions = _normalizeSuggestions(suggestions);
    findCompletion();
  }

  @override
  TextSpan buildTextSpan({required BuildContext context, required bool withComposing, TextStyle? style}) {
    assert(!value.composing.isValid || !withComposing || value.isComposingRangeValid);
    // If the composing range is out of range for the current text, ignore it to preserve the tree integrity, otherwise
    // in release mode a RangeError will be thrown and this EditableText will be built with a broken subtree.
    final bool composingRegionOutOfRange = !value.isComposingRangeValid || !withComposing;
    final (textStyle, composingStyle, completionStyle) = _textStyles(context);

    return TextSpan(
      children: [
        if (composingRegionOutOfRange)
          TextSpan(text: text, style: style)
        else ...[
          TextSpan(text: value.composing.textBefore(value.text), style: style),
          TextSpan(text: value.composing.textInside(value.text), style: composingStyle),
          TextSpan(text: value.composing.textAfter(value.text), style: style),
        ],
        if (current case (:final completion, replacement: final _) when completionStyle != null)
          TextSpan(text: completion, style: completionStyle),
      ],
    );
  }

  /// Completes the current typeahead suggestion by replacing the text with the replacement.
  void complete() {
    if (current case (completion: final _, :final replacement)) {
      current = null;
      currentData = null;
      rawValue = TextEditingValue(
        text: replacement,
        selection: .collapsed(offset: replacement.length),
      );
    }
  }

  /// Finds and sets the current completion based on the current text and available suggestions.
  ///
  /// This method should be overridden to customize the completion logic. It should never call [notifyListeners].
  ///
  /// The default implementation performs a case-insensitive prefix match against the suggestions.
  /// If a match is found, [current] is set with the completion text and full replacement.
  /// If no match is found or text is empty, [current] is set to null to disable typeahead.
  @visibleForOverriding
  @visibleForTesting
  void findCompletion([String? text]) {
    text ??= this.text;
    if (text.isEmpty) {
      current = null;
      currentData = null;
      return;
    }

    for (final suggestion in _suggestions) {
      if (suggestion.text.toLowerCase().startsWith(text.toLowerCase())) {
        current = (completion: suggestion.text.substring(text.length), replacement: suggestion.text);
        currentData = suggestion.data;
        return;
      }
    }

    current = null;
    currentData = null;
  }

  /// Loads suggestions from a [Future] or an [Iterable].
  Future<void> loadSuggestions(FutureOr<Iterable<T>> suggestions) async {
    final monotonic = ++_monotonic;
    switch (suggestions) {
      case final Future<Iterable<T>> future:
        final iterable = await future;
        if (!_disposed && monotonic == _monotonic) {
          _loadSuggestions(iterable);
        }

      case final Iterable<T> iterable:
        _loadSuggestions(iterable);
    }
  }

  void _loadSuggestions(Iterable<T> iterable) {
    final suggestions = _normalizeSuggestions(iterable);
    if (!listEquals(_suggestions, suggestions)) {
      _suggestions = suggestions;
      findCompletion();
      notifyListeners();
    }
  }

  /// The suggestions from which a completion is derived.
  ///
  /// For example, if the user types "appl", the suggestions might include "apple", "application", etc.
  List<T> get suggestions => [for (final suggestion in _suggestions) suggestion.data];

  /// Updates the current [text] to the given `newText`, and removes existing selection and composing range held by the
  /// controller.
  ///
  /// Unlike [TextEditingController.text], [FTypeaheadController.text] sets the selection to the end of the new text
  /// rather than selecting the entire text.
  @override
  set text(String newText) {
    if (text != newText) {
      value = value.copyWith(
        text: newText,
        selection: .collapsed(offset: newText.length),
        composing: .empty,
      );
    }
  }

  @override
  set value(TextEditingValue newValue) {
    // notifyListeners will always be called if text changes.
    if (text != newValue.text) {
      // We have to call [findCompletion] before setting the value to ensure listeners will see the correct completion.
      // We have to pass in the new text since value is not updated yet.
      findCompletion(newValue.text);
    }
    rawValue = newValue;
  }

  /// The raw value of the controller without triggering completion logic.
  @protected
  TextEditingValue get rawValue => super.value;

  @protected
  set rawValue(TextEditingValue newValue) => super.value = newValue;

  /// The current completion and corresponding replacement text, or null if no completion is available.
  ({String completion, String replacement})? get current => _current;

  /// The underlying data of the current completion, or null if no completion is available.
  T? get currentData => _currentData;

  @protected
  @nonVirtual
  set current(({String completion, String replacement})? value) => _current = value;

  @protected
  @nonVirtual
  set currentData(T? value) => _currentData = value;

  @override
  @mustCallSuper
  void dispose() {
    try {
      super.dispose();
    } finally {
      _disposed = true;
    }
  }

  List<FTypeaheadSuggestion<T>> _normalizeSuggestions(Iterable<T> suggestions) => [
    for (final suggestion in suggestions)
      FTypeaheadSuggestion(text: displayStringForOption(suggestion), data: suggestion),
  ];

  static String _defaultDisplayStringForOption<T>(T option) => defaultDisplayStringForOption(option);
}
