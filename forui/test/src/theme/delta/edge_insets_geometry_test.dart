import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('EdgeInsetsGeometryDelta', () {
    test('scale(...) scales EdgeInsets', () {
      const delta = EdgeInsetsGeometryDelta.scale(0.5);
      final result = delta(const EdgeInsets.all(10));

      expect(result, const EdgeInsets.all(5));
    });

    test('scale(...) scales EdgeInsetsDirectional', () {
      const delta = EdgeInsetsGeometryDelta.scale(2);
      final result = delta(const EdgeInsetsDirectional.all(10));

      expect(result, const EdgeInsetsDirectional.all(20));
    });

    test('scale(...) with null defaults to zero', () {
      const delta = EdgeInsetsGeometryDelta.scale(2);
      final result = delta(null);

      expect(result, EdgeInsets.zero);
    });

    test('value(...) replaces', () {
      const delta = EdgeInsetsGeometryDelta.value(EdgeInsets.all(8));
      final result = delta(const EdgeInsets.all(10));

      expect(result, const EdgeInsets.all(8));
    });

    test('value(...) ignores null', () {
      const delta = EdgeInsetsGeometryDelta.value(EdgeInsets.all(8));
      final result = delta(null);

      expect(result, const EdgeInsets.all(8));
    });
  });

  group('EdgeInsetsDelta', () {
    group('delta(...)', () {
      test('no arguments preserves all edges', () {
        const delta = EdgeInsetsDelta.delta();
        final result = delta(const EdgeInsets.fromLTRB(10, 20, 30, 40));

        expect(result, const EdgeInsets.fromLTRB(10, 20, 30, 40));
      });

      test('replaces specified edges', () {
        const delta = EdgeInsetsDelta.delta(left: 0, bottom: 5);
        final result = delta(const EdgeInsets.fromLTRB(10, 20, 30, 40));

        expect(result, const EdgeInsets.fromLTRB(0, 20, 30, 5));
      });

      test('sets edge to zero', () {
        const delta = EdgeInsetsDelta.delta(left: 0);
        final result = delta(const EdgeInsets.all(10));

        expect(result, const EdgeInsets.fromLTRB(0, 10, 10, 10));
      });

      test('with null defaults to zero', () {
        const delta = EdgeInsetsDelta.delta(left: 5);
        final result = delta(null);

        expect(result, const EdgeInsets.only(left: 5));
      });
    });

    group('add(...)', () {
      test('no arguments preserves all edges', () {
        const delta = EdgeInsetsDelta.add();
        final result = delta(const EdgeInsets.fromLTRB(10, 20, 30, 40));

        expect(result, const EdgeInsets.fromLTRB(10, 20, 30, 40));
      });

      test('adds to specified edges', () {
        const delta = EdgeInsetsDelta.add(left: 5, top: -10);
        final result = delta(const EdgeInsets.fromLTRB(10, 20, 30, 40));

        expect(result, const EdgeInsets.fromLTRB(15, 10, 30, 40));
      });

      test('with null defaults to zero', () {
        const delta = EdgeInsetsDelta.add(left: 5);
        final result = delta(null);

        expect(result, const EdgeInsets.only(left: 5));
      });
    });

    group('scale(...)', () {
      test('scales all edges', () {
        const delta = EdgeInsetsDelta.scale(0.5);
        final result = delta(const EdgeInsets.fromLTRB(10, 20, 30, 40));

        expect(result, const EdgeInsets.fromLTRB(5, 10, 15, 20));
      });

      test('with null defaults to zero', () {
        const delta = EdgeInsetsDelta.scale(2);
        final result = delta(null);

        expect(result, EdgeInsets.zero);
      });
    });

    test('value(...) replaces', () {
      const delta = EdgeInsetsDelta.value(EdgeInsets.all(8));
      final result = delta(const EdgeInsets.fromLTRB(10, 20, 30, 40));

      expect(result, const EdgeInsets.all(8));
    });
  });

  group('EdgeInsetsDirectionalDelta', () {
    group('delta(...)', () {
      test('no arguments preserves all edges', () {
        const delta = EdgeInsetsDirectionalDelta.delta();
        final result = delta(const EdgeInsetsDirectional.fromSTEB(10, 20, 30, 40));

        expect(result, const EdgeInsetsDirectional.fromSTEB(10, 20, 30, 40));
      });

      test('replaces specified edges', () {
        const delta = EdgeInsetsDirectionalDelta.delta(start: 0, bottom: 5);
        final result = delta(const EdgeInsetsDirectional.fromSTEB(10, 20, 30, 40));

        expect(result, const EdgeInsetsDirectional.fromSTEB(0, 20, 30, 5));
      });

      test('sets edge to zero', () {
        const delta = EdgeInsetsDirectionalDelta.delta(start: 0);
        final result = delta(const EdgeInsetsDirectional.all(10));

        expect(result, const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 10));
      });

      test('with null defaults to zero', () {
        const delta = EdgeInsetsDirectionalDelta.delta(start: 5);
        final result = delta(null);

        expect(result, const EdgeInsetsDirectional.only(start: 5));
      });
    });

    group('add(...)', () {
      test('no arguments preserves all edges', () {
        const delta = EdgeInsetsDirectionalDelta.add();
        final result = delta(const EdgeInsetsDirectional.fromSTEB(10, 20, 30, 40));

        expect(result, const EdgeInsetsDirectional.fromSTEB(10, 20, 30, 40));
      });

      test('adds to specified edges', () {
        const delta = EdgeInsetsDirectionalDelta.add(start: 5, top: -10);
        final result = delta(const EdgeInsetsDirectional.fromSTEB(10, 20, 30, 40));

        expect(result, const EdgeInsetsDirectional.fromSTEB(15, 10, 30, 40));
      });

      test('with null defaults to zero', () {
        const delta = EdgeInsetsDirectionalDelta.add(start: 5);
        final result = delta(null);

        expect(result, const EdgeInsetsDirectional.only(start: 5));
      });
    });

    group('scale(...)', () {
      test('scales all edges', () {
        const delta = EdgeInsetsDirectionalDelta.scale(0.5);
        final result = delta(const EdgeInsetsDirectional.fromSTEB(10, 20, 30, 40));

        expect(result, const EdgeInsetsDirectional.fromSTEB(5, 10, 15, 20));
      });

      test('with null defaults to zero', () {
        const delta = EdgeInsetsDirectionalDelta.scale(2);
        final result = delta(null);

        expect(result, EdgeInsetsDirectional.zero);
      });
    });

    test('value(...) replaces', () {
      const delta = EdgeInsetsDirectionalDelta.value(EdgeInsetsDirectional.all(8));
      final result = delta(const EdgeInsetsDirectional.fromSTEB(10, 20, 30, 40));

      expect(result, const EdgeInsetsDirectional.all(8));
    });
  });
}
