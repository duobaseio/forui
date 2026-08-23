import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

// {@snippet}
@override
Widget build(BuildContext context) {
  final typography = context.theme.typography;

  return Text(
    'Hello World!',
    // {@highlight}
    style: typography.body.xs.copyWith(color: context.theme.colors.primaryForeground, fontWeight: .bold),
    // {@endhighlight}
  );
}

// {@endsnippet}
