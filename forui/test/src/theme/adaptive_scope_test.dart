import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
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
