import 'package:flutter_test/flutter_test.dart';
import 'package:forui_cli/forui_cli.dart';

import 'package:create/selection.dart';

void main() {
  test('copyWith replaces the given fields and preserves the rest', () {
    final base = Selection.decode();
    final copy = base.copyWith(base: BaseColor.values.last, radius: .large);

    expect(copy.base, BaseColor.values.last);
    expect(copy.radius, Radius.large);
    expect(copy.primary, base.primary);
    expect(copy.display, base.display);
    expect(copy.body, base.body);
    expect(copy.icon, base.icon);
  });

  test('copyWith(clearPrimary: true) resets primary to null', () {
    final selection = Selection.decode().copyWith(primary: .amber);

    expect(selection.primary, PrimaryColor.amber);
    expect(selection.copyWith(clearPrimary: true).primary, null);
  });

  test('copyWith preserves a set primary when unspecified', () {
    expect(Selection.decode().copyWith(primary: .amber).copyWith(radius: .none).primary, PrimaryColor.amber);
  });

  test('encode is the inverse of decode', () => expect(Selection.decode('cdefba').encode(), 'cdefba'));
}
