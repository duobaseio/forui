import 'package:flutter/cupertino.dart';

import 'package:forui/forui.dart';

late BuildContext context;

final accordion =
    // {@snippet constructor}
    FAccordion(
      style: .delta(focusedOutlineStyle: .delta(color: context.theme.colors.background)),
      children: const [],
    );
// {@endsnippet}
