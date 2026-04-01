import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class OtpFieldPage extends Example {
  OtpFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FOtpField();
}

@RoutePage()
class DividerOtpFieldPage extends Example {
  DividerOtpFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FOtpField(
    // {@highlight}
    control: const .managed(
      children: [FOtpItem(), FOtpItem(), FOtpItem(), FOtpDivider(), FOtpItem(), FOtpItem(), FOtpItem()],
    ),
    // {@endhighlight}
  );
}

@RoutePage()
class NoFormatterOtpFieldPage extends Example {
  NoFormatterOtpFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FOtpField(
    // {@highlight}
    inputFormatters: const [],
    // {@endhighlight}
  );
}
