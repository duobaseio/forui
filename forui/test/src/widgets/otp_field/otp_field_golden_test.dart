import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FOtpField(
          style: TestScaffold.blueScreen.otpFieldStyle,
          control: const .managed(initial: TextEditingValue(text: '123456')),
        ),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('basic - ${theme.name}', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: FOtpField()));

      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('otp-field/${theme.name}/basic.png'));
    });

    testWidgets('single item - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FOtpField(control: const .managed(children: [FOtpItem()])),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('otp-field/${theme.name}/single-item.png'));
    });

    testWidgets('divider - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FOtpField(
            control: const .managed(
              children: [FOtpItem(), FOtpItem(), FOtpItem(), FOtpDivider(), FOtpItem(), FOtpItem(), FOtpItem()],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('otp-field/${theme.name}/divider.png'));
    });

    testWidgets('disabled divider - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FOtpField(
            control: const .managed(
              initial: TextEditingValue(text: '123456'),
              children: [FOtpItem(), FOtpItem(), FOtpItem(), FOtpDivider(), FOtpItem(), FOtpItem(), FOtpItem()],
            ),
            enabled: false,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('otp-field/${theme.name}/disabled-divider.png'));
    });

    testWidgets('single empty item focused - ${theme.name}', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: FOtpField(autofocus: true)));

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('otp-field/${theme.name}/single-empty-item-focused.png'),
      );
    });

    for (final (name, platform) in [('android', TargetPlatform.android), ('ios', TargetPlatform.iOS)]) {
      testWidgets('single filled item focused $name - ${theme.name}', (tester) async {
        debugDefaultTargetPlatformOverride = platform;

        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FOtpField(
              control: const .managed(initial: TextEditingValue(text: '123456')),
            ),
          ),
        );

        await tester.pumpAndSettle();

        await tester.tap(find.byType(FOtpField));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('otp-field/${theme.name}/single-filled-item-focused-$name.png'),
        );

        debugDefaultTargetPlatformOverride = null;
      });
    }

    testWidgets('many items focused - ${theme.name}', (tester) async {
      final controller = autoDispose(FOtpController());

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FOtpField(control: .managed(controller: controller)),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(FOtpField));
      await tester.pumpAndSettle();

      controller.value = const TextEditingValue(
        text: '123456',
        selection: TextSelection(baseOffset: 1, extentOffset: 4),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('otp-field/${theme.name}/many-items-focused.png'));
    });

    testWidgets('all items focused - ${theme.name}', (tester) async {
      final controller = autoDispose(FOtpController());

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FOtpField(control: .managed(controller: controller)),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(FOtpField));
      await tester.pumpAndSettle();

      controller.value = const TextEditingValue(
        text: '123456',
        selection: TextSelection(baseOffset: 0, extentOffset: 6),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('otp-field/${theme.name}/all-items-focused.png'));
    });

    testWidgets('all items focused divider - ${theme.name}', (tester) async {
      final controller = autoDispose(
        FOtpController(
          children: const [FOtpItem(), FOtpItem(), FOtpItem(), FOtpDivider(), FOtpItem(), FOtpItem(), FOtpItem()],
        ),
      );

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FOtpField(control: .managed(controller: controller)),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(FOtpField));
      await tester.pumpAndSettle();

      controller.value = const TextEditingValue(
        text: '123456',
        selection: TextSelection(baseOffset: 0, extentOffset: 6),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('otp-field/${theme.name}/all-items-focused-divider.png'),
      );
    });

    testWidgets('disabled - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FOtpField(
            control: const .managed(initial: TextEditingValue(text: '123456')),
            enabled: false,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('otp-field/${theme.name}/disabled.png'));
    });

    testWidgets('error - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FOtpField(
            control: const .managed(initial: TextEditingValue(text: '123456')),
            forceErrorText: 'An error has occurred.',
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('otp-field/${theme.name}/error.png'));
    });

    testWidgets('disabled error - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FOtpField(
            control: const .managed(initial: TextEditingValue(text: '123456')),
            enabled: false,
            forceErrorText: 'An error has occurred.',
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('otp-field/${theme.name}/disabled-error.png'));
    });

    testWidgets('with label and description - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FOtpField(label: const Text('My Label'), description: const Text('Some help text.')),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('otp-field/${theme.name}/with-label-and-description.png'),
      );
    });

    testWidgets('with label, description and error - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FOtpField(
            label: const Text('My Label'),
            description: const Text('Some help text.'),
            forceErrorText: 'An error has occurred.',
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('otp-field/${theme.name}/with-label-description-and-error.png'),
      );
    });

    testWidgets('RTL - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          textDirection: .rtl,
          child: FOtpField(
            control: const .managed(initial: TextEditingValue(text: '123456')),
            label: const Text('My Label'),
            description: const Text('Some help text.'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('otp-field/${theme.name}/rtl.png'));
    });
  }
}
