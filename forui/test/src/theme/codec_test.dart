import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/theme/codec.dart';

void main() {
  group('codec', () {
    const preset = Preset(
      base: .neutral,
      primary: .blue,
      display: .geist,
      body: .inter,
      icon: .lucide,
      radius: .medium,
    );

    test('encode produces codes in order', () => expect(preset.encode(), 'aaabbc'));

    test('decode produces the matching preset', () {
      final decoded = Preset.decode('aaabbc');

      expect(decoded.base, BaseColor.neutral);
      expect(decoded.primary, PrimaryColor.blue);
      expect(decoded.display, FontFamily.geist);
      expect(decoded.body, FontFamily.inter);
      expect(decoded.icon, IconLibrary.lucide);
      expect(decoded.radius, Radius.medium);
    });

    for (final code in ['aaabbc', 'ggzaed', 'gabrdc']) {
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
  });
}
