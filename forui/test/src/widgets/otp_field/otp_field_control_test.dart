import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/otp_field/otp_field_control.dart';

void main() {
  late FOtpController controller;

  setUp(() {
    controller = FOtpController();
  });

  tearDown(() {
    controller.dispose();
  });

  group('FOtpController()', () {
    test('defaults', () {
      expect(controller.children.length, 6);
      expect(controller.text, '');
      expect(controller.focused, 0);
    });

    test('children with dividers', () {
      controller.dispose();
      controller = FOtpController(children: const [FOtpItem(), FOtpDivider(), FOtpItem(), FOtpItem()]);

      expect(controller.children.length, 4);
      expect(controller.focused, 0);
    });
  });

  group('traverse empty', () {
    test('forward does nothing', () {
      controller.traverse(forward: true);

      expect(controller.selection, const TextSelection.collapsed(offset: 0));
      expect(controller.focused, 0);
    });

    test('backward does nothing', () {
      controller.traverse(forward: false);

      expect(controller.selection, const TextSelection.collapsed(offset: 0));
      expect(controller.focused, 0);
    });
  });

  group('traverse', () {
    setUp(() {
      controller.value = const TextEditingValue(text: '123', selection: .collapsed(offset: 3));
    });

    test('forward from collapsed', () {
      // At offset 1 (middle), value setter expands to [1, 2].
      controller
        ..value = controller.value.copyWith(selection: const .collapsed(offset: 1))
        ..traverse(forward: true);

      // Traverse moves to offset 2, value setter expands middle selection to [2, 3].
      expect(controller.selection, const TextSelection(baseOffset: 2, extentOffset: 3));
      expect(controller.focused, 2);
    });

    test('backward from collapsed', () {
      controller
        ..value = controller.value.copyWith(selection: const .collapsed(offset: 1))
        ..traverse(forward: false);

      // Traverse moves to offset 0, value setter expands middle selection to [0, 1].
      expect(controller.selection, const TextSelection(baseOffset: 0, extentOffset: 1));
      expect(controller.focused, 0);
    });

    test('forward clamped at text.length', () {
      controller.traverse(forward: true);

      // At text.length, value setter passes through as collapsed.
      expect(controller.selection, const TextSelection.collapsed(offset: 3));
      expect(controller.focused, 3);
    });

    test('backward clamped at 0', () {
      controller
        ..value = controller.value.copyWith(selection: const .collapsed(offset: 0))
        ..traverse(forward: false);

      // At offset 0, value setter expands middle selection to [0, 1].
      expect(controller.selection, const TextSelection(baseOffset: 0, extentOffset: 1));
      expect(controller.focused, 0);
    });

    test('forward from expanded selection', () {
      controller
        ..value = controller.value.copyWith(selection: const TextSelection(baseOffset: 0, extentOffset: 2))
        ..traverse(forward: true);

      // Collapses to end (2), value setter expands middle selection to [2, 3].
      expect(controller.selection, const TextSelection(baseOffset: 2, extentOffset: 3));
      expect(controller.focused, 2);
    });

    test('backward from expanded selection', () {
      controller
        ..value = controller.value.copyWith(selection: const TextSelection(baseOffset: 1, extentOffset: 3))
        ..traverse(forward: false);

      // Collapses to max(start - 1, 0) = 0, value setter expands to [0, 1].
      expect(controller.selection, const TextSelection(baseOffset: 0, extentOffset: 1));
      expect(controller.focused, 0);
    });

    test('backward from expanded selection at start', () {
      controller
        ..value = controller.value.copyWith(selection: const TextSelection(baseOffset: 0, extentOffset: 2))
        ..traverse(forward: false);

      // Collapses to max(0 - 1, 0) = 0, value setter expands to [0, 1].
      expect(controller.selection, const TextSelection(baseOffset: 0, extentOffset: 1));
      expect(controller.focused, 0);
    });
  });

  group('value', () {
    test('no-op when setting same value', () {
      int count = 0;
      controller
        ..addListener(() => count++)
        ..value = controller.value;

      expect(count, 0);
    });

    test('truncates text longer than length', () {
      controller.value = const TextEditingValue(text: '12345678', selection: .collapsed(offset: 8));

      expect(controller.text, '123456');
      expect(controller.selection, const TextSelection.collapsed(offset: 6));
      expect(controller.focused, 5);
    });

    test('truncates text longer than length when partially filled', () {
      controller
        ..value = const TextEditingValue(text: '123', selection: .collapsed(offset: 3))
        ..value = const TextEditingValue(text: '45678910', selection: .collapsed(offset: 8));

      expect(controller.text, '456789');
      expect(controller.selection, const TextSelection.collapsed(offset: 6));
      expect(controller.focused, 5);
    });

    test('does not truncate text at length', () {
      controller.value = const TextEditingValue(text: '123456', selection: .collapsed(offset: 6));

      expect(controller.text, '123456');
      expect(controller.focused, 5);
    });

    test('truncates grapheme clusters', () {
      // Each flag emoji is a single grapheme cluster but multiple code units.
      controller.dispose();
      controller = FOtpController(children: [const FOtpItem(), const FOtpItem()])
        ..value = const TextEditingValue(
          text: '🇺🇸🇬🇧🇫🇷',
          selection: .collapsed(offset: '🇺🇸🇬🇧🇫🇷'.length),
        );

      expect(controller.text, '🇺🇸🇬🇧');
      expect(controller.focused, 1);
    });

    test('focused clamped to length - 1', () {
      controller.value = const TextEditingValue(text: '123456', selection: .collapsed(offset: 6));

      expect(controller.focused, 5);
    });

    test('first-item affinity workaround', () {
      controller.value = const TextEditingValue(
        text: '12',
        selection: .collapsed(offset: 1, affinity: .upstream),
      );

      expect(controller.focused, 0);
    });

    test('middle item deletion selects previous item', () {
      controller
        // Tap item at index 2 — value setter expands selection to [2, 3].
        ..value = const TextEditingValue(text: '123456', selection: TextSelection(baseOffset: 2, extentOffset: 3))
        // Backspace deletes '3', framework sends cursor at offset 2.
        ..value = const TextEditingValue(text: '12456', selection: .collapsed(offset: 2));

      expect(controller.text, '12456');
      expect(controller.selection, const TextSelection(baseOffset: 1, extentOffset: 2));
    });

    test('middle item deletion at offset 0 clamps base to 0', () {
      controller
        // Select first item — value setter expands selection to [0, 1].
        ..value = const TextEditingValue(text: '123456', selection: TextSelection(baseOffset: 0, extentOffset: 1))
        // Backspace deletes '1', framework sends cursor at offset 0.
        ..value = const TextEditingValue(text: '23456', selection: .collapsed(offset: 0));

      expect(controller.text, '23456');
      expect(controller.selection, const TextSelection.collapsed(offset: 0));
      expect(controller.focused, 0);
    });

    test('middle item selects current item for replacement', () {
      controller
        ..value = const TextEditingValue(text: '123456', selection: .collapsed(offset: 6))
        // Same text length, cursor in middle — should select item at cursor for replacement.
        ..value = const TextEditingValue(text: '123456', selection: .collapsed(offset: 2));

      expect(controller.selection, const TextSelection(baseOffset: 2, extentOffset: 3));
      expect(controller.focused, 2);
    });

    test('focuses next empty item after last inserted character', () {
      controller.value = const TextEditingValue(text: '123', selection: .collapsed(offset: 3));

      expect(controller.text, '123');
      expect(controller.selection, const TextSelection.collapsed(offset: 3));
      expect(controller.focused, 3);
    });

    test('tapping middle item selects it for replacement', () {
      controller
        ..value = const TextEditingValue(text: '123456', selection: .collapsed(offset: 6))
        // Tap item at index 3.
        ..value = const TextEditingValue(text: '123456', selection: .collapsed(offset: 3));

      expect(controller.selection, const TextSelection(baseOffset: 3, extentOffset: 4));
      expect(controller.focused, 3);
    });

    test('replacing middle item then typing again advances focus', () {
      controller
        // Tap item 2 → selection [2, 3].
        ..value = const TextEditingValue(text: '123456', selection: TextSelection(baseOffset: 2, extentOffset: 3))
        // Type 'X' replaces '3', framework sends cursor at offset 3.
        ..value = const TextEditingValue(text: '12X456', selection: .collapsed(offset: 3));

      // Selection expands to [3, 4] for next replacement.
      expect(controller.selection, const TextSelection(baseOffset: 3, extentOffset: 4));
      expect(controller.focused, 3);

      // Type 'Y' replaces '4', framework sends cursor at offset 4.
      controller.value = const TextEditingValue(text: '12XY56', selection: .collapsed(offset: 4));

      expect(controller.selection, const TextSelection(baseOffset: 4, extentOffset: 5));
      expect(controller.focused, 4);
    });

    test('clamps selection when offsets exceed text length', () {
      controller
        ..value = const TextEditingValue(text: '12', selection: .collapsed(offset: 2))
        // Simulate dragging selection handle beyond text length (WidgetSpan offset > text.length).
        ..value = const TextEditingValue(
          text: '12',
          selection: TextSelection(baseOffset: 3, extentOffset: 4),
        );

      expect(controller.text, '12');
      expect(controller.selection, const TextSelection(baseOffset: 2, extentOffset: 2));
      expect(controller.focused, 2);
    });

    test('deleting last filled item retains focus on now-empty item', () {
      controller
        // Field has '123', tap last filled item → selection [2, 3].
        ..value = const TextEditingValue(text: '123', selection: TextSelection(baseOffset: 2, extentOffset: 3))
        // Backspace deletes '3', framework sends cursor at offset 2.
        ..value = const TextEditingValue(text: '12', selection: .collapsed(offset: 2));

      // Offset == text.length, so passes through as collapsed. Focus on the now-empty item.
      expect(controller.text, '12');
      expect(controller.selection, const TextSelection.collapsed(offset: 2));
      expect(controller.focused, 2);
    });
  });
}
