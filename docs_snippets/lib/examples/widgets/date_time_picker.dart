import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class DateTimePickerPage extends Example {
  DateTimePickerPage({@queryParam super.theme}) : super(maxWidth: 300);

  @override
  Widget example(BuildContext context) => FDateTimePicker(control: .managed(initial: .now()));
}

@RoutePage()
class Hour24DateTimePickerPage extends Example {
  Hour24DateTimePickerPage({@queryParam super.theme}) : super(maxWidth: 300);

  @override
  Widget example(BuildContext context) => FDateTimePicker(
    control: .managed(initial: .now()),
    // {@highlight}
    hour24: true,
    // {@endhighlight}
  );
}

@RoutePage()
class IntervalDateTimePickerPage extends Example {
  IntervalDateTimePickerPage({@queryParam super.theme}) : super(maxWidth: 300);

  @override
  Widget example(BuildContext context) => FDateTimePicker(
    control: .managed(initial: .now()),
    // {@highlight}
    dayInterval: 2,
    hourInterval: 2,
    minuteInterval: 5,
    // {@endhighlight}
  );
}