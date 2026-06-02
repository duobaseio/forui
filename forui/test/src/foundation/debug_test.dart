import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/foundation/debug.dart';
import '../test_scaffold.dart';

void main() {
  group('FiniteConstraintsValidator', () {
    testWidgets('unbounded width and height', (tester) async {
      final original = FlutterError.onError;
      final errors = <FlutterErrorDetails>[];
      FlutterError.onError = errors.add;

      await tester.pumpWidget(
        TestScaffold(
          child: const UnconstrainedBox(
            child: FiniteConstraintsValidator(type: 'TestWidget', child: SizedBox()),
          ),
        ),
      );

      FlutterError.onError = original;

      expect(errors.first.toString(), contains('width and height'));
    });

    group('unbound height', () {
      testWidgets('Column', (tester) async {
        final original = FlutterError.onError;
        final errors = <FlutterErrorDetails>[];
        FlutterError.onError = errors.add;

        await tester.pumpWidget(
          TestScaffold(
            child: const Column(
              children: [FiniteConstraintsValidator(type: 'TestWidget', child: SizedBox())],
            ),
          ),
        );

        FlutterError.onError = original;

        expect(errors.first.toString(), contains('unbounded height'));
        expect(errors.first.toString(), contains('Column'));
      });

      testWidgets('non-Flex', (tester) async {
        final original = FlutterError.onError;
        final errors = <FlutterErrorDetails>[];
        FlutterError.onError = errors.add;

        await tester.pumpWidget(
          TestScaffold(
            child: const SingleChildScrollView(
              child: FiniteConstraintsValidator(type: 'TestWidget', child: SizedBox()),
            ),
          ),
        );

        FlutterError.onError = original;

        expect(errors.first.toString(), contains('unbounded height'));
        expect(errors.first.toString(), isNot(contains('Column')));
      });
    });

    group('unbound width', () {
      testWidgets('Row', (tester) async {
        final original = FlutterError.onError;
        final errors = <FlutterErrorDetails>[];
        FlutterError.onError = errors.add;

        await tester.pumpWidget(
          TestScaffold(
            child: const Row(
              children: [FiniteConstraintsValidator(type: 'TestWidget', child: SizedBox())],
            ),
          ),
        );

        FlutterError.onError = original;

        expect(errors.first.toString(), contains('unbounded width'));
        expect(errors.first.toString(), contains('Row'));
      });

      testWidgets('non-Flex', (tester) async {
        final original = FlutterError.onError;
        final errors = <FlutterErrorDetails>[];
        FlutterError.onError = errors.add;

        await tester.pumpWidget(
          TestScaffold(
            child: const SingleChildScrollView(
              scrollDirection: .horizontal,
              child: FiniteConstraintsValidator(type: 'TestWidget', child: SizedBox()),
            ),
          ),
        );

        FlutterError.onError = original;

        expect(errors.first.toString(), contains('unbounded width'));
        expect(errors.first.toString(), isNot(contains('Row')));
      });
    });

    testWidgets('bound', (tester) async {
      final original = FlutterError.onError;
      final errors = <FlutterErrorDetails>[];
      FlutterError.onError = errors.add;

      await tester.pumpWidget(
        TestScaffold(
          child: const FiniteConstraintsValidator(type: 'TestWidget', child: SizedBox()),
        ),
      );

      FlutterError.onError = original;

      expect(errors, isEmpty);
    });
  });

  group('debugCheckInclusiveDateRange', () {
    test('date within range', () {
      expect(debugCheckInclusiveDateRange(DateTime(2024), DateTime(2024, 6, 15), DateTime(2024, 12, 31)), true);
    });

    test('date equals start', () {
      expect(debugCheckInclusiveDateRange(DateTime(2024), DateTime(2024), DateTime(2024, 12, 31)), true);
    });

    test('date equals end', () {
      expect(
        debugCheckInclusiveDateRange(DateTime(2024), DateTime(2024, 12, 31), DateTime(2024, 12, 31)),
        true,
      );
    });

    test('date before start', () {
      expect(
        () => debugCheckInclusiveDateRange(DateTime(2024, 6), DateTime(2024), DateTime(2024, 12, 31)),
        throwsA(
          isA<FlutterError>().having((e) => e.toString(), 'message', contains('date is not within [start, end].')),
        ),
      );
    });

    test('date after end', () {
      expect(
        () => debugCheckInclusiveDateRange(DateTime(2024), DateTime(2025), DateTime(2024, 12, 31)),
        throwsA(
          isA<FlutterError>().having((e) => e.toString(), 'message', contains('date is not within [start, end].')),
        ),
      );
    });
  });
}
