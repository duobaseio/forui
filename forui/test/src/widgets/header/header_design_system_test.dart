@TestOn('mac-os')
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('root header', () {
    testWidgets('consistent height with and without actions', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: FThemes.neutral.light.touch,
          child: Column(
            mainAxisSize: .min,
            children: [
              FHeader(
                key: const Key('with-actions'),
                title: const Text('Title'),
                suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
              ),
              const FHeader(key: Key('without-actions'), title: Text('Title')),
            ],
          ),
        ),
      );

      final withActions = tester.getSize(find.byKey(const Key('with-actions'))).height;
      final withoutActions = tester.getSize(find.byKey(const Key('without-actions'))).height;
      expect(withActions, withoutActions);
    });
  });

  group('nested header', () {
    testWidgets('consistent height with and without actions', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: FThemes.neutral.light.touch,
          child: Column(
            mainAxisSize: .min,
            children: [
              FHeader.nested(
                key: const Key('with-actions'),
                title: const Text('Title'),
                prefixes: [FHeaderAction.back(onPress: () {})],
                suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
              ),
              const FHeader.nested(key: Key('without-actions'), title: Text('Title')),
            ],
          ),
        ),
      );

      final withActions = tester.getSize(find.byKey(const Key('with-actions'))).height;
      final withoutActions = tester.getSize(find.byKey(const Key('without-actions'))).height;
      expect(withActions, withoutActions);
    });
  });
}
