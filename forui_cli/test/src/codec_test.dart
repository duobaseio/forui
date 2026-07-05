import 'package:test/test.dart';

import 'package:forui_cli/forui_cli.dart';

void main() {
  group('codec', () {
    test('decode produces the matching preset', () {
      final decoded = Preset.decode('ababbc');

      expect(decoded.base, BaseColor.neutral);
      expect(decoded.primary, PrimaryColor.amber);
      expect(decoded.display, FontFamily.geist);
      expect(decoded.body, FontFamily.inter);
      expect(decoded.icon, IconLibrary.lucide);
      expect(decoded.radius, Radius.medium);
    });

    test('encode produces codes in order', () => expect(Preset.decode('cdefba').encode(), 'cdefba'));

    for (final code in ['aaabbc', 'ggzaed', 'gabrdc', 'aaAAaa']) {
      test('round-trips $code', () => expect(Preset.decode(code).encode(), code));
    }

    for (final invalid in ['', 'aaa', 'aaabbca']) {
      test(
        'decode throws on wrong length: "$invalid"',
        () => expect(() => Preset.decode(invalid), throwsFormatException),
      );
    }

    for (final invalid in ['zaabbc', 'aaaaaz', 'aaab!c']) {
      test(
        'decode throws on unknown code: "$invalid"',
        () => expect(() => Preset.decode(invalid), throwsFormatException),
      );
    }

    test('decode error reports the offending code and index', () {
      expect(
        () => Preset.decode('zaabbc'),
        throwsA(isA<FormatException>().having((e) => e.message, 'message', "Invalid code 'z' at index 0.")),
      );
    });
  });
}
