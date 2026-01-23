import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
  group('FPlatformVariant', () {
    group('touch', () {
      for (final (platform, expected) in [
        (FPlatformVariant.touch, true),
        (FPlatformVariant.android, true),
        (FPlatformVariant.iOS, true),
        (FPlatformVariant.fuchsia, true),
        (FPlatformVariant.desktop, false),
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
        (FPlatformVariant.touch, false),
        (FPlatformVariant.android, false),
        (FPlatformVariant.iOS, false),
        (FPlatformVariant.fuchsia, false),
        (FPlatformVariant.desktop, true),
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
        (FPlatformVariant.touch, FPlatformVariant.android, true),
        (FPlatformVariant.touch, FPlatformVariant.iOS, true),
        (FPlatformVariant.touch, FPlatformVariant.fuchsia, true),
        (FPlatformVariant.touch, FPlatformVariant.windows, false),
        (FPlatformVariant.touch, FPlatformVariant.macOS, false),
        (FPlatformVariant.touch, FPlatformVariant.linux, false),
        (FPlatformVariant.touch, FPlatformVariant.web, false),
        // desktop category
        (FPlatformVariant.desktop, FPlatformVariant.android, false),
        (FPlatformVariant.desktop, FPlatformVariant.iOS, false),
        (FPlatformVariant.desktop, FPlatformVariant.fuchsia, false),
        (FPlatformVariant.desktop, FPlatformVariant.windows, true),
        (FPlatformVariant.desktop, FPlatformVariant.macOS, true),
        (FPlatformVariant.desktop, FPlatformVariant.linux, true),
        (FPlatformVariant.desktop, FPlatformVariant.web, false),
        // specific platforms
        (FPlatformVariant.android, FPlatformVariant.android, true),
        (FPlatformVariant.android, FPlatformVariant.iOS, false),
        (FPlatformVariant.android, FPlatformVariant.touch, false),
        (FPlatformVariant.iOS, FPlatformVariant.iOS, true),
        (FPlatformVariant.iOS, FPlatformVariant.android, false),
        (FPlatformVariant.iOS, FPlatformVariant.touch, false),
        (FPlatformVariant.windows, FPlatformVariant.windows, true),
        (FPlatformVariant.windows, FPlatformVariant.macOS, false),
        (FPlatformVariant.windows, FPlatformVariant.desktop, false),
        (FPlatformVariant.web, FPlatformVariant.web, true),
        (FPlatformVariant.web, FPlatformVariant.android, false),
        (FPlatformVariant.web, FPlatformVariant.touch, false),
        (FPlatformVariant.web, FPlatformVariant.desktop, false),
      ]) {
        test('$constraint with $active', () => expect(constraint.satisfiedBy({active}), expected));
      }
    });
  });
}
