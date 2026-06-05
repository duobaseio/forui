import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/grid.dart';
import '../../test_scaffold.dart';

void main() {
  FCalendarDayPickerController controller({DateTime? initial, DateTime? focused}) => autoDispose(
    FCalendarDayPickerController(
      start: .utc(2024),
      end: .utc(2024, 12, 31),
      selectable: (_) => true,
      initial: initial ?? .utc(2024, 6, 15),
      focused: focused,
    ),
  );

  group('reattach', () {
    test('reseeds the current page to the given date', () {
      final c = controller();
      expect(c.current, DateTime.utc(2024, 6));

      c.reattach(DateTime.utc(2024, 9, 20));
      expect(c.current, DateTime.utc(2024, 9));
    });

    test('clears the focused date', () {
      final c = controller(focused: DateTime.utc(2024, 6, 15));
      expect(c.focused, DateTime.utc(2024, 6, 15));

      c.reattach(DateTime.utc(2024, 9));
      expect(c.focused, null);
    });

    test('throws when the date is out of range', () {
      final c = controller();
      expect(() => c.reattach(DateTime.utc(2025)), throwsAssertionError);
      expect(() => c.reattach(DateTime.utc(2023)), throwsAssertionError);
    });
  });
}
