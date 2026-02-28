@TestOn('mac-os')
library;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  for (final (platform, sizes) in [
    (
      FPlatformVariant.macOS,
      [
        (FTextFieldSizeVariant.sm, 'sm', 32.0),
        (FTextFieldSizeVariant.md, 'md', 36.0),
        (FTextFieldSizeVariant.lg, 'lg', 40.0),
      ],
    ),
    (
      FPlatformVariant.iOS,
      [
        (FTextFieldSizeVariant.sm, 'sm', 40.0),
        (FTextFieldSizeVariant.md, 'md', 44.0),
        (FTextFieldSizeVariant.lg, 'lg', 48.0),
      ],
    ),
  ]) {
    final platformName = platform == FPlatformVariant.macOS ? 'macOS' : 'iOS';
    for (final (size, name, height) in sizes) {
      testWidgets('$platformName $name text field has consistent height ($height)', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            platform: platform,
            child: FTextField(size: size),
          ),
        );

        expect(tester.getSize(find.byType(FTextField)).height, closeTo(height, 0.001));
      });
    }
  }
}
