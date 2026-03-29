import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/otp_field/caret.dart';
import '../../test_scaffold.dart';

void main() {
  for (final (name, cursorOpacityAnimates) in [('caret-opacity-animates', true), ('caret-discrete-blink', false)]) {
    testWidgets(name, (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(200, 100)));

      await tester.pumpFrames(
        sheet.record(
          TestScaffold.app(
            child: Caret(color: Colors.black, width: 2, height: 20, cursorOpacityAnimates: cursorOpacityAnimates),
          ),
        ),
        const Duration(milliseconds: 1000),
      );

      await expectLater(sheet.collate(10), matchesGoldenFile('otp-field/$name.png'));
    });
  }
}
