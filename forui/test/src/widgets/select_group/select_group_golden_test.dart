import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

Widget _checkbox({required bool enabled, required bool error}) => FSelectGroup(
  label: const Text('Label'),
  forceErrorText: error ? 'Error' : null,
  enabled: enabled,
  control: const .managed(initial: {1}),
  children: [
    .checkbox(value: 1, label: const Text('Checkbox 1')),
    .checkbox(value: 2, label: const Text('Checkbox 2')),
  ],
);

Widget _radio({required bool enabled, required bool error}) => FSelectGroup(
  label: const Text('Label'),
  forceErrorText: error ? 'Error' : null,
  enabled: enabled,
  control: const .managedRadio(initial: 1),
  children: [
    .radio(value: 1, label: const Text('Radio 1')),
    .radio(value: 2, label: const Text('Radio 2')),
  ],
);

void main() {
  group('checkbox', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelectGroup(
            style: TestScaffold.blueScreen.selectGroupStyle,
            label: const Text('Select Group'),
            description: const Text('Select Group Description'),
            control: const .managed(initial: {1}),
            children: [
              .checkbox(value: 1, label: const Text('Checkbox 1'), semanticsLabel: 'Checkbox 1'),
              .radio(value: 2, label: const Text('Checkbox 2'), semanticsLabel: 'Checkbox 2'),
            ],
          ),
        ),
      );

      await expectBlueScreen();
    });

    for (final theme in TestScaffold.themes) {
      for (final (name, enabled, error) in [
        ('checkbox', true, false),
        ('checkbox-disabled', false, false),
        ('checkbox-error', true, true),
        ('checkbox-disabled-error', false, true),
      ]) {
        testWidgets('${theme.name} $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FSelectGroup(
                label: const Text('Select Group'),
                description: const Text('Select Group Description'),
                forceErrorText: error ? 'Some error message.' : null,
                enabled: enabled,
                control: const .managed(initial: {1}),
                children: [
                  .checkbox(value: 1, label: const Text('Checkbox 1'), semanticsLabel: 'Checkbox 1'),
                  .checkbox(value: 2, label: const Text('Checkbox 2'), semanticsLabel: 'Checkbox 2'),
                  .checkbox(value: 3, label: const Text('Checkbox 3'), semanticsLabel: 'Checkbox 3'),
                ],
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-group/${theme.name}/$name.png'));
        });
      }

      for (final (name, fromEnabled, fromError, toEnabled, toError) in [
        ('checkbox-enabled-to-disabled', true, false, false, false),
        ('checkbox-disabled-to-enabled', false, false, true, false),
        ('checkbox-enabled-to-error', true, false, true, true),
        ('checkbox-error-to-enabled', true, true, true, false),
      ]) {
        testWidgets('${theme.name} $name transition', (tester) async {
          final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(200, 150)));

          await tester.pumpWidget(
            sheet.record(
              TestScaffold.app(theme: theme.data, child: _checkbox(enabled: fromEnabled, error: fromError)),
              recording: false,
            ),
          );
          await tester.pumpAndSettle();

          await tester.pumpFrames(
            sheet.record(TestScaffold.app(theme: theme.data, child: _checkbox(enabled: toEnabled, error: toError))),
            const Duration(milliseconds: 150),
          );

          await expectLater(sheet.collate(5), matchesGoldenFile('select-group/${theme.name}/$name.png'));
        });
      }
    }
  });

  group('radio', () {
    for (final theme in TestScaffold.themes) {
      for (final (name, enabled, error) in [
        ('radio', true, false),
        ('radio-disabled', false, false),
        ('radio-error', true, true),
        ('radio-disabled-error', false, true),
      ]) {
        testWidgets('${theme.name} $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FSelectGroup(
                label: const Text('Select Group'),
                description: const Text('Select Group Description'),
                forceErrorText: error ? 'Some error message.' : null,
                enabled: enabled,
                control: const .managedRadio(initial: 1),
                children: [
                  .radio(value: 1, label: const Text('Radio 1'), semanticsLabel: 'Radio 1'),
                  .radio(value: 2, label: const Text('Radio 2'), semanticsLabel: 'Radio 2'),
                  .radio(value: 3, label: const Text('Radio 3'), semanticsLabel: 'Radio 3'),
                ],
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-group/${theme.name}/$name.png'));
        });
      }

      for (final (name, fromEnabled, fromError, toEnabled, toError) in [
        ('radio-enabled-to-disabled', true, false, false, false),
        ('radio-disabled-to-enabled', false, false, true, false),
        ('radio-enabled-to-error', true, false, true, true),
        ('radio-error-to-enabled', true, true, true, false),
      ]) {
        testWidgets('${theme.name} $name transition', (tester) async {
          final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(200, 150)));

          await tester.pumpWidget(
            sheet.record(
              TestScaffold.app(theme: theme.data, child: _radio(enabled: fromEnabled, error: fromError)),
              recording: false,
            ),
          );
          await tester.pumpAndSettle();

          await tester.pumpFrames(
            sheet.record(TestScaffold.app(theme: theme.data, child: _radio(enabled: toEnabled, error: toError))),
            const Duration(milliseconds: 150),
          );

          await expectLater(sheet.collate(5), matchesGoldenFile('select-group/${theme.name}/$name.png'));
        });
      }
    }
  });
}
