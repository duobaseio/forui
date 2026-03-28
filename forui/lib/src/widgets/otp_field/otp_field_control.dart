import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

part 'otp_field_control.control.dart';

/// A [FOtpFieldControl] defines how a [FOtpField] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FOtpFieldControl with Diagnosticable, _$FOtpFieldControlMixin {
  /// Creates a [FOtpFieldControl].
  const factory FOtpFieldControl.managed({
    FOtpController? controller,
    List<Widget> children,
    TextEditingValue? initial,
    ValueChanged<TextEditingValue>? onChange,
  }) = FOtpFieldManagedControl;

  const FOtpFieldControl._();

  (FOtpController, bool) _update(FOtpFieldControl old, FOtpController controller, VoidCallback callback);
}

/// A [FOtpFieldManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FOtpFieldManagedControl extends FOtpFieldControl with _$FOtpFieldManagedControlMixin {
  /// The controller.
  @override
  final FOtpController? controller;

  /// The initial value. Defaults to null.
  ///
  /// Ignored if [controller] is provided. Pass the initial value to the controller instead.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final TextEditingValue? initial;

  /// The children, which should be [FOtpItemMixin]s or [FOtpDivider]s. Defaults to six [FOtpItem]s.
  ///
  /// Ignored if [controller] is provided. Pass children to the controller instead.
  @override
  final List<Widget> children;

  /// Called when the value changes.
  @override
  final ValueChanged<TextEditingValue>? onChange;

  /// Creates a [FOtpFieldControl].
  const FOtpFieldManagedControl({
    this.controller,
    this.children = const [FOtpItem(), FOtpItem(), FOtpItem(), FOtpItem(), FOtpItem(), FOtpItem()],
    this.initial,
    this.onChange,
  }) : assert(
         controller == null || initial == null,
         'Cannot provide both controller and initial value. Pass initial value to the controller instead.',
       ),
       super._();

  @override
  FOtpController createController() => controller ?? FOtpController(children: children, value: initial ?? .empty);
}

// TODO: Add support for lifted OTP field.
class _Lifted extends FOtpFieldControl with _$_LiftedMixin {
  const _Lifted() : super._();

  @override
  FOtpController createController() => throw UnimplementedError();

  @override
  void _updateController(FOtpController _) {}
}

@internal
extension InternalFOtpController on FOtpController {
  /// The currently focused item index.
  int get focused => _focused;
}

/// A controller that manages the state of an [FOtpField].
///
/// This controller does not handle formatting internally. Use [TextInputFormatter]s on [FOtpField] to restrict input.
class FOtpController extends TextEditingController {
  /// The children, which should be [FOtpItemMixin]s or [FOtpDivider]s. Defaults to six [FOtpItem]s.
  ///
  /// For example, to add a divider in the middle:
  /// ```dart
  /// FOtpField(
  ///   controller: FOtpController(
  ///     children: [FOtpItem(), FOtpItem(), FOtpItem(), FOtpDivider(), FOtpItem(), FOtpItem(), FOtpItem()],
  ///   ),
  /// )
  /// ```
  final List<Widget> children;
  final int _length;
  int _focused;

  /// Creates a [FOtpController].
  FOtpController({
    this.children = const [FOtpItem(), FOtpItem(), FOtpItem(), FOtpItem(), FOtpItem(), FOtpItem()],
    TextEditingValue value = .empty,
  }) : _length = children.whereType<FOtpItemMixin>().length,
       _focused = 0,
       super.fromValue(value);

  @override
  TextSpan buildTextSpan({required BuildContext context, required bool withComposing, TextStyle? style}) {
    // It is very unlikely that the OTP code will contain grapheme clusters but there's no harm being calamitous.
    final characters = text.characters;
    final variants = FOtpFieldScope.of(context).variants;

    final spans = <InlineSpan>[];
    int item = 0;
    for (final (i, child) in children.indexed) {
      if (child is FOtpItemMixin) {
        final character = characters.elementAtOrNull(item);
        spans.add(
          WidgetSpan(
            alignment: .middle,
            child: FOtpItemScope(
              character: character,
              focused: switch (selection) {
                _ when !variants.contains(FTextFieldVariant.focused) => false,
                final s when s.isCollapsed => _focused == item,
                final s => s.start <= item && item < s.end,
              },
              start: i == 0 || children[i - 1] is! FOtpItemMixin,
              end: i == children.length - 1 || children[i + 1] is! FOtpItemMixin,
              child: child,
            ),
          ),
        );
        item++;
        continue;
      }

      spans.add(WidgetSpan(alignment: .middle, child: child));
    }

    return TextSpan(children: Directionality.of(context) == .ltr ? spans : spans.reversed.toList());
  }

  /// Handles the traversal of the OTP items when the user presses the left or right arrow key.
  void traverse({required bool forward}) {
    /// The default traversal collapses to the start/end of the selection range. We instead move to the previous/next
    /// item outside it.
    if (selection.isCollapsed) {
      final adjustment = (forward ? 1 : -1);
      value = value.copyWith(selection: .collapsed(offset: (selection.baseOffset + adjustment).clamp(0, text.length)));
    } else {
      final offset = forward ? selection.end : max(selection.start - 1, 0);
      value = value.copyWith(selection: .collapsed(offset: offset));
    }
  }

  @override
  set value(TextEditingValue newValue) {
    if (newValue == value) {
      return;
    }

    /// Truncates the text to the maximum length.
    if (newValue.text.characters.take(_length).string case final truncated when truncated != newValue.text) {
      _focused = (truncated.length - 1).clamp(0, _length - 1);
      super.value = TextEditingValue(
        text: truncated,
        selection: .collapsed(offset: truncated.length),
      );
      return;
    }

    /// Calculates the focused index and caret position. Arrow key events are intercepted and routed via `traverse`
    /// to avoid conflicts.
    ///
    /// WidgetSpan offset/affinity calculations are fucked. See https://github.com/flutter/flutter/issues/107432.
    /// Tapping the right half of the first item produces <offset: 1, affinity: upstream> while other items produce
    /// <offset: N, affinity: downstream>.
    _focused = newValue.selection.baseOffset.clamp(0, _length - 1);
    if (newValue.selection.isCollapsed) {
      /// Corrects the focused index when tapping the right half of the first item.
      if (newValue.selection.baseOffset == 1 && newValue.selection.affinity == .upstream) {
        _focused = 0;
        super.value = newValue;
        return;
      }

      /// Handles replacement/deletion of middle items.
      if (newValue.text.length != newValue.selection.baseOffset) {
        /// Selects the previous item on deletion.
        if (newValue.text.length != text.length) {
          super.value = newValue.copyWith(
            selection: TextSelection(
              baseOffset: max(newValue.selection.baseOffset - 1, 0),
              extentOffset: newValue.selection.baseOffset,
            ),
          );
          return;
        }

        /// Selects the middle item at the caret so that backspace deletes it and typing replaces it.
        super.value = newValue.copyWith(
          selection: TextSelection(
            baseOffset: newValue.selection.baseOffset,
            extentOffset: newValue.selection.baseOffset + 1,
          ),
        );
        return;
      }
    }

    super.value = newValue;
  }
}
