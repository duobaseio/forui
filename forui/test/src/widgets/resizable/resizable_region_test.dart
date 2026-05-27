import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

Widget stub(BuildContext context, FResizableRegionData data, Widget? child) => child!;

void main() {
  for (final (index, constructor) in [
    () => FResizableRegion.fixed(extent: 0, builder: stub),
    () => FResizableRegion.fixed(extent: 10, minExtent: 0, builder: stub),
    () => FResizableRegion.fixed(extent: 10, minExtent: 20, builder: stub),
  ].indexed) {
    test('[$index] constructor throws error', () => expect(constructor, throwsAssertionError));
  }
}
