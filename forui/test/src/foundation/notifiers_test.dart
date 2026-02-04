import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/foundation/notifiers.dart';

class _Notifier<T> extends FMultiValueNotifier<T> {
  int listeners = 0;

  _Notifier({super.value = const {}});

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    listeners++;
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    listeners--;
  }
}

void main() {
  late int count;

  setUp(() {
    count = 0;
  });

  group('FChangeNotifier', () {
    late FChangeNotifier notifier;

    setUp(() => notifier = FChangeNotifier());

    test('dispose() updates disposed field', () {
      expect(notifier.disposed, false);

      notifier.dispose();

      expect(notifier.disposed, true);
    });
  });

  group('FMultiValueNotifier - multi', () {
    test('contains(...)', () {
      final notifier = FMultiValueNotifier(value: {1});

      expect(notifier.contains(1), true);
      expect(notifier.contains(2), false);

      notifier.update(2, add: true);

      expect(notifier.contains(1), true);
      expect(notifier.contains(2), true);

      notifier.update(1, add: false);

      expect(notifier.contains(1), false);
      expect(notifier.contains(2), true);
    });

    test('should initialize with given values', () {
      final notifier = FMultiValueNotifier(value: {1, 2, 3})..addListener(() => count++);

      expect(notifier.value, equals({1, 2, 3}));
      expect(count, 0);
    });

    test('should notify when added', () {
      final notifier = FMultiValueNotifier<int>()..addListener(() => count++);

      final old = notifier.value;

      notifier.update(1, add: true);

      expect(notifier.value, {1});
      expect(notifier.value, isNot(old));
      expect(count, 1);
    });

    test('should remove a value when removed', () {
      final notifier = FMultiValueNotifier(value: {1, 2})..addListener(() => count++);

      final old = notifier.value;

      notifier.update(1, add: false);

      expect(notifier.value, equals({2}));
      expect(notifier.value, isNot(old));
      expect(count, 1);
    });

    test('should not selected a value when max limit is reached', () {
      final notifier = FMultiValueNotifier(max: 2, value: {1, 2})
        ..addListener(() => count++)
        ..update(3, add: true);

      expect(notifier.value, equals({1, 2}));
      expect(count, 0);
    });

    test('should not remove a value when min limit is reached', () {
      final notifier = FMultiValueNotifier(min: 2, value: {1, 2})
        ..addListener(() => count++)
        ..update(1, add: false);

      expect(notifier.value, equals({1, 2}));
      expect(count, 0);
    });

    group('set value', () {
      test('should throw an error when more than 2 value is provided', () {
        final notifier = FMultiValueNotifier<int>(max: 2);

        expect(() => notifier.value = {1, 2, 3}, throwsArgumentError);
      });

      test('should throw an error when less than 2 value is provided', () {
        final notifier = FMultiValueNotifier<int>(min: 2);

        expect(() => notifier.value = {1}, throwsArgumentError);
      });

      test('should set the value', () {
        final notifier = FMultiValueNotifier<int>(min: 2, max: 2)..addListener(() => count++);

        final old = notifier.value;
        notifier.value = {1, 2};

        expect(notifier.value, equals({1, 2}));
        expect(notifier.value, isNot(old));
        expect(count, 1);
      });
    });
  });

  group('FMultiValueNotifier - radio', () {
    test('contains(...)', () {
      final notifier = FMultiValueNotifier.radio(1);

      expect(notifier.contains(1), true);
      expect(notifier.contains(2), false);

      notifier.update(2, add: true);

      expect(notifier.contains(1), false);
      expect(notifier.contains(2), true);
    });

    test('should initialize with a single value', () {
      final notifier = FMultiValueNotifier.radio(1)..addListener(() => count++);

      expect(notifier.value, {1});
      expect(count, 0);
    });

    test('should initialize with an empty set when no value is provided', () {
      final notifier = FMultiValueNotifier<int>.radio()..addListener(() => count++);

      expect(notifier.value, isEmpty);
      expect(count, 0);
    });

    test('should change value when a new value is added', () {
      final notifier = FMultiValueNotifier<int>.radio()..addListener(() => count++);

      final old = notifier.value;
      notifier.update(1, add: true);

      expect(notifier.value, {1});
      expect(notifier.value, isNot(old));
      expect(count, 1);
    });

    test('should not change value when the same value is added', () {
      final notifier = FMultiValueNotifier.radio(1)
        ..addListener(() => count++)
        ..update(1, add: true);

      expect(notifier.value, equals({1}));
      expect(count, 0);
    });

    test('should not change value when trying to remove', () {
      final notifier = FMultiValueNotifier.radio(1)
        ..addListener(() => count++)
        ..update(1, add: false);

      expect(notifier.value, equals({1}));
      expect(count, 0);
    });

    group('set value', () {
      test('should throw an error when more than one value is provided', () {
        final notifier = FMultiValueNotifier.radio();

        expect(() => notifier.value = {1, 2}, throwsArgumentError);
      });

      test('should set the value when only one value is provided', () {
        final notifier = FMultiValueNotifier.radio()..addListener(() => count++);

        final old = notifier.value;
        notifier.value = {1};

        expect(notifier.value, equals({1}));
        expect(notifier.value, isNot(old));
        expect(count, 1);
      });
    });
  });

  group('FMultiValueControl - transitions', () {
    void callback() {}

    test('managed -> managedRadio', () {
      const managed = FMultiValueControl<int>.managed(initial: {1, 2});
      const managedRadio = FMultiValueControl<int>.managedRadio(initial: 1);

      final controller = managed.create(callback);
      expect(controller.value, {1, 2});

      final (newController, updated) = managedRadio.update(managed, controller, callback);

      expect(updated, true);
      expect(newController, isNot(controller));
      expect(newController.value, {1});
      expect(controller.disposed, true);
    });

    test('managedRadio -> managed', () {
      const managedRadio = FMultiValueControl<int>.managedRadio(initial: 1);
      const managed = FMultiValueControl<int>.managed(initial: {1, 2});

      final controller = managedRadio.create(callback);
      expect(controller.value, {1});

      final (newController, updated) = managed.update(managedRadio, controller, callback);

      expect(updated, true);
      expect(newController, isNot(controller));
      expect(newController.value, {1, 2});
      expect(controller.disposed, true);
    });

    test('external A -> external B', () {
      final first = _Notifier<int>(value: {1});
      final second = _Notifier<int>(value: {2});
      final controlA = FMultiValueControl<int>.managed(controller: first);
      final controlB = FMultiValueControl<int>.managed(controller: second);

      final controller = controlA.create(callback);
      expect(first.listeners, 1);
      expect(second.listeners, 0);

      final (newController, updated) = controlB.update(controlA, controller, callback);

      expect(updated, true);
      expect(newController, second);
      expect(first.listeners, 0);
      expect(first.disposed, false);
      expect(second.listeners, 1);
      expect(second.disposed, false);
    });

    test('external A -> external A', () {
      final external = _Notifier<int>(value: {1});
      final controlA = FMultiValueControl<int>.managed(controller: external);
      final controlB = FMultiValueControl<int>.managed(controller: external);

      final controller = controlA.create(callback);
      expect(external.listeners, 1);

      final (newController, updated) = controlB.update(controlA, controller, callback);

      expect(updated, false);
      expect(newController, controller);
      expect(external.listeners, 1);
      expect(external.disposed, false);
    });

    test('internal -> external', () {
      final external = _Notifier<int>(value: {2});
      const internal = FMultiValueControl<int>.managed(initial: {1});
      final externalControl = FMultiValueControl<int>.managed(controller: external);

      final controller = internal.create(callback);
      expect(controller.value, {1});
      expect(external.listeners, 0);

      final (newController, updated) = externalControl.update(internal, controller, callback);

      expect(updated, true);
      expect(newController, external);
      expect(controller.disposed, true);
      expect(external.listeners, 1);
    });

    test('external -> internal', () {
      final external = _Notifier<int>(value: {1});
      final externalControl = FMultiValueControl<int>.managed(controller: external);
      const internal = FMultiValueControl<int>.managed(initial: {2});

      final controller = externalControl.create(callback);
      expect(external.listeners, 1);

      final (newController, updated) = internal.update(externalControl, controller, callback);

      expect(updated, true);
      expect(newController, isNot(external));
      expect(newController.value, {2});
      expect(external.listeners, 0);
      expect(external.disposed, false);
    });

    test('managed -> lifted', () {
      const managed = FMultiValueControl<int>.managed(initial: {1});
      final lifted = FMultiValueControl<int>.lifted(value: {2}, onChange: (_) {});

      final controller = managed.create(callback);
      expect(controller.value, {1});

      final (newController, updated) = lifted.update(managed, controller, callback);

      expect(updated, true);
      expect(newController, isNot(controller));
      expect(newController.value, {2});
      expect(controller.disposed, true);
    });

    test('lifted -> managed', () {
      final lifted = FMultiValueControl<int>.lifted(value: {1}, onChange: (_) {});
      const managed = FMultiValueControl<int>.managed(initial: {2});

      final controller = lifted.create(callback);
      expect(controller.value, {1});

      final (newController, updated) = managed.update(lifted, controller, callback);

      expect(updated, true);
      expect(newController, isNot(controller));
      expect(newController.value, {2});
      expect(controller.disposed, true);
    });
  });
}
