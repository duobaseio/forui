import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  for (final theme in TestScaffold.themes) {
    for (final (name, variant) in [('primary', FToastVariant.primary), ('destructive', FToastVariant.destructive)]) {
      testWidgets('${theme.name} $name everything', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FToast(
              variant: variant,
              icon: const Icon(FIcons.triangleAlert),
              title: const Text('Event has been created'),
              description: const Text(
                'This is a more detailed description that provides comprehensive context and additional information '
                'about the notification, explaining what happened and what the user might expect next.',
              ),
              // This is unintentionally unstyled since suffix is typically a button.
              suffix: const Text('Suffix'),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/${theme.name}/$name-everything.png'));
      });

      testWidgets('${theme.name} $name title & description', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FToast(
              variant: variant,
              title: const Text('Event has been created'),
              description: const Text(
                'This is a more detailed description that provides comprehensive context and additional information '
                'about the notification, explaining what happened and what the user might expect next.',
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('toast/${theme.name}/$name-title-description.png'),
        );
      });
    }
  }

  testWidgets('glassmorphic', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: Stack(
          children: [
            const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
            FToast(
              style: .delta(
                backgroundFilter: .blur(sigmaX: 5, sigmaY: 5),
                decoration: .value(
                  BoxDecoration(
                    color: FThemes.neutral.light.touch.colors.background.withValues(alpha: 0.5),
                    borderRadius: FThemes.neutral.light.touch.style.borderRadius.md,
                    border: .all(
                      width: FThemes.neutral.light.touch.style.borderWidth,
                      color: FThemes.neutral.light.touch.colors.border,
                    ),
                  ),
                ),
              ),
              title: const Text('Event has been created'),
              description: const Text(
                'This is a more detailed description that provides comprehensive context and additional information '
                'about the notification, explaining what happened and what the user might expect next.',
              ),
            ),
          ],
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/glassmorphic.png'));
  });
}
