import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

// {@snippet}
@override
Widget build(BuildContext context) {
  final colors = context.theme.colors;
  return ColoredBox(
    color: colors.primary,
    child: Text('Hello World!', style: TextStyle(color: colors.primaryForeground)),
  );
}

// {@endsnippet}
