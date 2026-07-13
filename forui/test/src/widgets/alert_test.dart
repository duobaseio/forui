import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('accessibility', () {
    SemanticsNode? liveRegion(WidgetTester tester) {
      SemanticsNode? node = tester.getSemantics(find.text('Alert Title'));
      while (node != null && !node.getSemanticsData().flagsCollection.isLiveRegion) {
        node = node.parent;
      }
      return node;
    }

    testWidgets('announces the alert by default', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold(
          child: const FAlert(title: Text('Alert Title'), subtitle: Text('Alert description')),
        ),
      );

      expect(liveRegion(tester)?.getSemanticsData().flagsCollection.isLiveRegion, true);

      semantics.dispose();
    });

    testWidgets('liveRegion: false does not announce the alert', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold(
          child: const FAlert(
            liveRegion: false,
            title: Text('Alert Title'),
            subtitle: Text('Alert description'),
          ),
        ),
      );

      expect(liveRegion(tester), null);

      semantics.dispose();
    });
  });
}
