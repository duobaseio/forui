import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/theme/variant.dart';

void main() {
  group('FPlatformVariant', () {
    group('touch', () {
      for (final (platform, expected) in [
        (FPlatformVariant.android, true),
        (FPlatformVariant.iOS, true),
        (FPlatformVariant.fuchsia, true),
        (FPlatformVariant.windows, false),
        (FPlatformVariant.macOS, false),
        (FPlatformVariant.linux, false),
        (FPlatformVariant.web, false),
      ]) {
        test('$platform', () => expect(platform.touch, expected));
      }
    });

    group('desktop', () {
      for (final (platform, expected) in [
        (FPlatformVariant.android, false),
        (FPlatformVariant.iOS, false),
        (FPlatformVariant.fuchsia, false),
        (FPlatformVariant.windows, true),
        (FPlatformVariant.macOS, true),
        (FPlatformVariant.linux, true),
        (FPlatformVariant.web, false),
      ]) {
        test('$platform', () => expect(platform.desktop, expected));
      }
    });

    group('satisfiedBy', () {
      for (final (constraint, active, expected) in [
        // touch category
        (const Touch(), FPlatformVariant.android, true),
        (const Touch(), FPlatformVariant.iOS, true),
        (const Touch(), FPlatformVariant.fuchsia, true),
        (const Touch(), FPlatformVariant.windows, false),
        (const Touch(), FPlatformVariant.macOS, false),
        (const Touch(), FPlatformVariant.linux, false),
        (const Touch(), FPlatformVariant.web, false),
        // desktop category
        (const Desktop(), FPlatformVariant.android, false),
        (const Desktop(), FPlatformVariant.iOS, false),
        (const Desktop(), FPlatformVariant.fuchsia, false),
        (const Desktop(), FPlatformVariant.windows, true),
        (const Desktop(), FPlatformVariant.macOS, true),
        (const Desktop(), FPlatformVariant.linux, true),
        (const Desktop(), FPlatformVariant.web, false),
        // specific platforms
        (FPlatformVariant.android, FPlatformVariant.android, true),
        (FPlatformVariant.android, FPlatformVariant.iOS, false),
        (FPlatformVariant.android, const Touch(), false),
        (FPlatformVariant.iOS, FPlatformVariant.iOS, true),
        (FPlatformVariant.iOS, FPlatformVariant.android, false),
        (FPlatformVariant.iOS, const Touch(), false),
        (FPlatformVariant.windows, FPlatformVariant.windows, true),
        (FPlatformVariant.windows, FPlatformVariant.macOS, false),
        (FPlatformVariant.windows, const Desktop(), false),
        (FPlatformVariant.web, FPlatformVariant.web, true),
        (FPlatformVariant.web, FPlatformVariant.android, false),
        (FPlatformVariant.web, const Touch(), false),
        (FPlatformVariant.web, const Desktop(), false),
      ]) {
        test('$constraint with $active', () => expect(constraint.satisfiedBy({active}), expected));
      }
    });
  });
}
