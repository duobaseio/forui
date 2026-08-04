import 'package:flutter_test/flutter_test.dart';

import 'package:create/top_bar.dart';

void main() {
  group('abbreviate', () {
    for (final (stars, expected) in [
      (0, '0'),
      (999, '999'),
      (1000, '1k'),
      (1049, '1k'), // Rounds to a whole thousand, so the '.0' is dropped.
      (1140, '1.1k'),
      (9949, '9.9k'),
      (9950, '10k'), // Rounds up across the 100-tenths boundary.
      (25400, '25k'),
    ]) {
      test('$stars -> $expected', () => expect(abbreviate(stars), expected));
    }
  });
}
