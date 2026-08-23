import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

final accordion =
    // {@snippet constructor}
    FAccordion(
      style: .delta(
        // {@highlight}
        titleTextStyle: FVariants.from(
          const TextStyle(fontSize: 18, fontWeight: .bold),
          variants: {
            [.hovered, .pressed]: .delta(decoration: () => TextDecoration.underline),
            [.disabled]: const .delta(color: Colors.grey),
          },
        ),
        // {@endhighlight}
      ),
      children: const [],
    );
// {@endsnippet}
