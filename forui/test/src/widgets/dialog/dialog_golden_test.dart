@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  final theme = FThemes.neutral.light.touch;

  group('showFDialog', () {
    testWidgets('default', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme,
          alignment: .topCenter,
          child: Builder(
            builder: (context) => FButton(
              onPress: () => showFDialog(
                context: context,
                builder: (context, _, animation) => FDialog(
                  animation: animation,
                  title: const Text('Are you absolutely sure?'),
                  body: const Text(
                    'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                  ),
                  actions: [
                    FButton(onPress: () {}, child: const Text('Continue')),
                    FButton(variant: .outline, onPress: () {}, child: const Text('Cancel')),
                  ],
                ),
              ),
              child: const Text('button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('dialog/show/default.png'));
    });

    testWidgets('blurred barrier', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme,
          alignment: .topCenter,
          child: Builder(
            builder: (context) => FButton(
              onPress: () => showFDialog(
                routeStyle: .delta(
                  barrierFilter: () =>
                      (animation) => .blur(sigmaX: animation * 5, sigmaY: animation * 5),
                ),
                context: context,
                builder: (context, _, animation) => FDialog(
                  animation: animation,
                  title: const Text('Are you absolutely sure?'),
                  body: const Text(
                    'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                  ),
                  actions: [
                    FButton(onPress: () {}, child: const Text('Continue')),
                    FButton(variant: .outline, onPress: () {}, child: const Text('Cancel')),
                  ],
                ),
              ),
              child: const Text('button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('dialog/show/blurred.png'));
    });

    testWidgets('glassmorphic', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme,
          child: Builder(
            builder: (context) => FButton(
              onPress: () => showFDialog(
                style: .delta(
                  backgroundFilter: (v) => .blur(sigmaX: v * 5, sigmaY: v * 5),
                  decoration: .value(
                    BoxDecoration(
                      borderRadius: theme.style.borderRadius.md,
                      color: theme.colors.background.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                context: context,
                builder: (context, style, animation) => FDialog(
                  style: style,
                  animation: animation,
                  title: const Text('Are you absolutely sure?'),
                  body: const Text(
                    'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                  ),
                  actions: [
                    FButton(onPress: () {}, child: const Text('Continue')),
                    FButton(variant: .outline, onPress: () {}, child: const Text('Cancel')),
                  ],
                ),
              ),
              child: const Text('button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('dialog/show/glassmorphic.png'));
    });
  });

  group('FDialog', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FDialog(
            style: TestScaffold.blueScreen.dialogStyle,
            direction: .horizontal,
            title: const Text('Are you absolutely sure?'),
            body: const Text(
              'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
            ),
            actions: const [],
          ),
        ),
      );

      await expectBlueScreen();
    });

    testWidgets('raw content', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme,
          child: FDialog.raw(builder: (context, style) => const SizedBox(width: 50, height: 50)),
        ),
      );

      await expectLater(find.byType(FDialog), matchesGoldenFile('dialog/raw-content.png'));
    });

    testWidgets('adaptive on mobile device', (tester) async {
      tester.view.physicalSize = const Size(1290, 2796); // iPhone 15 Plus
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        TestScaffold(
          theme: theme,
          child: FDialog.adaptive(
            title: const Text('Are you absolutely sure?'),
            body: const Text(
              'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
            ),
            actions: [
              FButton(child: const Text('Continue'), onPress: () {}),
              FButton(variant: .outline, child: const Text('Cancel'), onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(find.byType(FDialog), matchesGoldenFile('dialog/adaptive-mobile.png'));
    });

    testWidgets('adaptive on tablet device', (tester) async {
      tester.view.physicalSize = const Size(2388, 1668); // iPad Pro 11"
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        TestScaffold(
          theme: theme,
          child: FDialog.adaptive(
            title: const Text('Are you absolutely sure?'),
            body: const Text(
              'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
            ),
            actions: [
              FButton(child: const Text('Continue'), onPress: () {}),
              FButton(variant: .outline, child: const Text('Cancel'), onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(find.byType(FDialog), matchesGoldenFile('dialog/adaptive-tablet.png'));
    });

    for (final theme in TestScaffold.themes) {
      group('${theme.name} touch', () {
        group('vertical', () {
          testWidgets('confirmation - 3 actions with body', (tester) async {
            tester.view.physicalSize = const Size(1206, 2622); // iPhone 17
            addTearDown(tester.view.resetPhysicalSize);

            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FDialog(
                  title: const Text('Allow "Forui" to use your location?'),
                  body: const Text('This action cannot be undone. This will permanently delete your account.'),
                  actions: [
                    FButton(variant: .secondary, onPress: () {}, child: const Text('Allow Once')),
                    FButton(variant: .secondary, onPress: () {}, child: const Text('Allow While using App')),
                    FButton(variant: .secondary, onPress: () {}, child: const Text("Don't Allow")),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/touch/${theme.name}/vertical-confirmation-3-actions-body.png'),
            );
          });

          testWidgets('confirmation - 3 actions with body and image', (tester) async {
            tester.view.physicalSize = const Size(1206, 2622); // iPhone 17
            addTearDown(tester.view.resetPhysicalSize);

            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FDialog(
                  image: const SizedBox(height: 100, child: Placeholder()),
                  title: const Text('Allow "Forui" to use your location?'),
                  body: const Text('This action cannot be undone. This will permanently delete your account.'),
                  actions: [
                    FButton(variant: .secondary, onPress: () {}, child: const Text('Allow Once')),
                    FButton(variant: .secondary, onPress: () {}, child: const Text('Allow While using App')),
                    FButton(variant: .secondary, onPress: () {}, child: const Text("Don't Allow")),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/touch/${theme.name}/vertical-confirmation-3-actions-body-image.png'),
            );
          });

          testWidgets('loading - 0 actions no body', (tester) async {
            tester.view.physicalSize = const Size(1206, 2622); // iPhone 17
            addTearDown(tester.view.resetPhysicalSize);

            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FDialog(title: const Text('Loading'), actions: const []),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/touch/${theme.name}/vertical-loading-0-actions-no-body.png'),
            );
          });
        });

        group('horizontal', () {
          testWidgets('confirmation - 2 actions with body', (tester) async {
            tester.view.physicalSize = const Size(1206, 2622); // iPhone 17
            addTearDown(tester.view.resetPhysicalSize);

            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FDialog(
                  direction: .horizontal,
                  title: const Text('Are you sure?'),
                  body: const Text('This action cannot be undone. This will permanently delete your account.'),
                  actions: [
                    FButton(onPress: () {}, child: const Text('Delete')),
                    FButton(variant: .outline, onPress: () {}, child: const Text('Cancel')),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/touch/${theme.name}/horizontal-confirmation-2-actions-body.png'),
            );
          });

          testWidgets('confirmation - 2 actions with body and image', (tester) async {
            tester.view.physicalSize = const Size(1206, 2622); // iPhone 17
            addTearDown(tester.view.resetPhysicalSize);

            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FDialog(
                  direction: .horizontal,
                  image: const SizedBox(height: 100, child: Placeholder()),
                  title: const Text('Are you sure?'),
                  body: const Text('This action cannot be undone. This will permanently delete your account.'),
                  actions: [
                    FButton(onPress: () {}, child: const Text('Delete')),
                    FButton(variant: .outline, onPress: () {}, child: const Text('Cancel')),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/touch/${theme.name}/horizontal-confirmation-2-actions-body-image.png'),
            );
          });

          testWidgets('confirmation - 2 actions no body', (tester) async {
            tester.view.physicalSize = const Size(1206, 2622); // iPhone 17
            addTearDown(tester.view.resetPhysicalSize);

            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FDialog(
                  direction: .horizontal,
                  title: const Text('Delete account?'),
                  actions: [
                    FButton(variant: .destructive, onPress: () {}, child: const Text('Delete')),
                    FButton(variant: .outline, onPress: () {}, child: const Text('Cancel')),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/touch/${theme.name}/horizontal-confirmation-2-actions-no-body.png'),
            );
          });

          testWidgets('alert - 1 action with body', (tester) async {
            tester.view.physicalSize = const Size(1206, 2622); // iPhone 17
            addTearDown(tester.view.resetPhysicalSize);

            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FDialog(
                  direction: .horizontal,
                  title: const Text('Session Expired'),
                  body: const Text('Your session has expired. Please log in again to continue.'),
                  actions: [FButton(onPress: () {}, child: const Text('OK'))],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/touch/${theme.name}/horizontal-alert-1-action-body.png'),
            );
          });

          testWidgets('alert - 1 action no body', (tester) async {
            tester.view.physicalSize = const Size(1206, 2622); // iPhone 17
            addTearDown(tester.view.resetPhysicalSize);

            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FDialog(
                  direction: .horizontal,
                  title: const Text('Session Expired'),
                  actions: [FButton(onPress: () {}, child: const Text('OK'))],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/touch/${theme.name}/horizontal-alert-1-action-no-body.png'),
            );
          });

          testWidgets('loading - 0 actions with body', (tester) async {
            tester.view.physicalSize = const Size(1206, 2622); // iPhone 17
            addTearDown(tester.view.resetPhysicalSize);

            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FDialog(
                  direction: .horizontal,
                  title: const Text('Loading'),
                  body: const Text('Please wait while we process your request...'),
                  actions: const [],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/touch/${theme.name}/horizontal-loading-0-actions-body.png'),
            );
          });
        });
      });
    }

    for (final theme in [
      (name: 'neutral-light', data: FThemes.neutral.light.desktop),
      (name: 'neutral-dark', data: FThemes.neutral.dark.desktop),
    ]) {
      group('${theme.name} desktop', () {
        group('vertical', () {
          testWidgets('confirmation - 3 actions with body', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                platform: FPlatformVariant.macOS,
                child: FDialog(
                  title: const Text('Allow "Forui" to use your location?'),
                  body: const Text('This action cannot be undone. This will permanently delete your account.'),
                  actions: [
                    FButton(size: .sm, variant: .secondary, onPress: () {}, child: const Text('Allow Once')),
                    FButton(size: .sm, variant: .secondary, onPress: () {}, child: const Text('Allow While using App')),
                    FButton(size: .sm, variant: .secondary, onPress: () {}, child: const Text("Don't Allow")),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/desktop/${theme.name}/vertical-confirmation-3-actions-body.png'),
            );
          });

          testWidgets('confirmation - 3 actions with body and image', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                platform: FPlatformVariant.macOS,
                child: FDialog(
                  image: const SizedBox(height: 100, child: Placeholder()),
                  title: const Text('Allow "Forui" to use your location?'),
                  body: const Text('This action cannot be undone. This will permanently delete your account.'),
                  actions: [
                    FButton(size: .sm, variant: .secondary, onPress: () {}, child: const Text('Allow Once')),
                    FButton(size: .sm, variant: .secondary, onPress: () {}, child: const Text('Allow While using App')),
                    FButton(size: .sm, variant: .secondary, onPress: () {}, child: const Text("Don't Allow")),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/desktop/${theme.name}/vertical-confirmation-3-actions-body-image.png'),
            );
          });

          testWidgets('loading - 0 actions no body', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                platform: FPlatformVariant.macOS,
                child: FDialog(title: const Text('Loading'), actions: const []),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/desktop/${theme.name}/vertical-loading-0-actions-no-body.png'),
            );
          });
        });

        group('horizontal', () {
          testWidgets('confirmation - 2 actions with body', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                platform: FPlatformVariant.macOS,
                child: FDialog(
                  direction: .horizontal,
                  title: const Text('Are you sure?'),
                  body: const Text('This action cannot be undone. This will permanently delete your account.'),
                  actions: [
                    FButton(size: .sm, onPress: () {}, child: const Text('Delete')),
                    FButton(size: .sm, variant: .outline, onPress: () {}, child: const Text('Cancel')),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/desktop/${theme.name}/horizontal-confirmation-2-actions-body.png'),
            );
          });

          testWidgets('confirmation - 2 actions with body and image', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                platform: FPlatformVariant.macOS,
                child: FDialog(
                  direction: .horizontal,
                  image: const SizedBox(height: 100, child: Placeholder()),
                  title: const Text('Are you sure?'),
                  body: const Text('This action cannot be undone. This will permanently delete your account.'),
                  actions: [
                    FButton(size: .sm, onPress: () {}, child: const Text('Delete')),
                    FButton(size: .sm, variant: .outline, onPress: () {}, child: const Text('Cancel')),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/desktop/${theme.name}/horizontal-confirmation-2-actions-body-image.png'),
            );
          });

          testWidgets('confirmation - 2 actions no body', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                platform: FPlatformVariant.macOS,
                child: FDialog(
                  direction: .horizontal,
                  title: const Text('Delete account?'),
                  actions: [
                    FButton(size: .sm, variant: .destructive, onPress: () {}, child: const Text('Delete')),
                    FButton(size: .sm, variant: .outline, onPress: () {}, child: const Text('Cancel')),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/desktop/${theme.name}/horizontal-confirmation-2-actions-no-body.png'),
            );
          });

          testWidgets('alert - 1 action with body', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                platform: FPlatformVariant.macOS,
                child: FDialog(
                  direction: .horizontal,
                  title: const Text('Session Expired'),
                  body: const Text('Your session has expired. Please log in again to continue.'),
                  actions: [FButton(size: .sm, onPress: () {}, child: const Text('OK'))],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/desktop/${theme.name}/horizontal-alert-1-action-body.png'),
            );
          });

          testWidgets('alert - 1 action no body', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                platform: FPlatformVariant.macOS,
                child: FDialog(
                  direction: .horizontal,
                  title: const Text('Session Expired'),
                  actions: [FButton(size: .sm, onPress: () {}, child: const Text('OK'))],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/desktop/${theme.name}/horizontal-alert-1-action-no-body.png'),
            );
          });

          testWidgets('loading - 0 actions with body', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                platform: FPlatformVariant.macOS,
                child: FDialog(
                  direction: .horizontal,
                  title: const Text('Loading'),
                  body: const Text('Please wait while we process your request...'),
                  actions: const [],
                ),
              ),
            );

            await expectLater(
              find.byType(FDialog),
              matchesGoldenFile('dialog/desktop/${theme.name}/horizontal-loading-0-actions-body.png'),
            );
          });
        });
      });
    }
  });
}
