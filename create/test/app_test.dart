import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:create/main.dart';
import 'package:create/selection.dart';

import 'utils/fonts.dart';

/// Pumps a handful of frames
///
/// pumpAndSettle never returns because the preview's syncing card spins indefinitely.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1440, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(const Application());
  await _settle(tester);
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    return loadAppFonts();
  });

  testWidgets('renders the six preset controls and the default preset code', (tester) async {
    await _pumpApp(tester);

    for (final label in ['Base Color', 'Primary Color', 'Heading', 'Font', 'Icon Library', 'Radius']) {
      expect(find.text(label), findsOneWidget);
    }
    expect(find.text('--preset ${Selection.decode().encode()}'), findsOneWidget);
  });

  testWidgets('opens the nullable primary color dropdown without error', (tester) async {
    await _pumpApp(tester);

    await tester.tap(find.byKey(const ValueKey('preset-primary-color')));
    await _settle(tester);

    expect(tester.takeException(), null);
    expect(find.text('Violet'), findsOneWidget);
  });

  testWidgets('changing a control re-encodes the URL-backed selection', (tester) async {
    await _pumpApp(tester);

    await tester.tap(find.byKey(const ValueKey('preset-radius')));
    await _settle(tester);
    await tester.tap(find.text('Large'));
    await _settle(tester);

    expect(find.text('--preset ${Selection.decode().copyWith(radius: .large).encode()}'), findsOneWidget);
  });
}
