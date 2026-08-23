// ignore_for_file: always_use_package_imports

import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import '../../customizing_themes/accordion_style.dart';

// {@snippet}
// {@highlight}
// {@endhighlight}

@override
Widget build(BuildContext context) => FAccordion(
  // Pass the modified style to the widget.
  // {@highlight}
  style: accordionStyle(
    colors: context.theme.colors,
    typography: context.theme.typography,
    style: context.theme.style,
    touch: true,
  ),
  // {@endhighlight}
  children: const [
    FAccordionItem(title: Text('Is it accessible?'), child: Text('Yes. It adheres to the WAI-ARIA design pattern.')),
  ],
);
// {@endsnippet}
