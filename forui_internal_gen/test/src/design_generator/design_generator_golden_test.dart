import 'package:build_test/build_test.dart';
import 'package:forui_internal_gen/forui_internal_gen.dart';
import 'package:test/test.dart';

import 'golden.dart';
import 'source.dart';

void main() {
  test('design', () async {
    final readerWriter = TestReaderWriter(rootPackage: 'forui_internal_gen');
    await readerWriter.testing.loadIsolateSources();

    await testBuilder(
      designBuilder(.empty),
      {'forui_internal_gen|test/src/example.dart': source},
      outputs: {'forui_internal_gen|test/src/example.design.dart': golden},
      readerWriter: readerWriter,
    );
  }, timeout: const Timeout(Duration(minutes: 1)));
}
