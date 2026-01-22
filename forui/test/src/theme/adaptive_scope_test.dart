import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
  group('FPlatformVariant', () {
    for (final (platform, expected) in [
      (FPlatformVariant.android, true),
      (FPlatformVariant.iOS, true),
      (FPlatformVariant.fuchsia, true),
      (FPlatformVariant.windows, false),
      (FPlatformVariant.macOS, false),
      (FPlatformVariant.linux, false),
      (FPlatformVariant.web, false),
    ]) {
      test('touch - $platform', () => expect(platform.touch, expected));
    }

    for (final (platform, expected) in [
      (FPlatformVariant.android, false),
      (FPlatformVariant.iOS, false),
      (FPlatformVariant.fuchsia, false),
      (FPlatformVariant.windows, true),
      (FPlatformVariant.macOS, true),
      (FPlatformVariant.linux, true),
      (FPlatformVariant.web, false),
    ]) {
      test('desktop - $platform', () => expect(platform.desktop, expected));
    }
  });

  group('FAdaptiveScope', () {
    testWidgets('overridden platform', (tester) async {
      late FPlatformVariant captured;

      await tester.pumpWidget(
        FAdaptiveScope(
          platform: .fuchsia,
          child: Builder(
            builder: (context) {
              captured = context.platformVariant;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(captured, FPlatformVariant.fuchsia);
    });

    testWidgets('platform', (tester) async {
      late FPlatformVariant captured;

      await tester.pumpWidget(
        FAdaptiveScope(
          child: Builder(
            builder: (context) {
              captured = context.platformVariant;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(captured, FPlatformVariant.android);
    });
  });
}
