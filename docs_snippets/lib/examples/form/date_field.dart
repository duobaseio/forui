import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class DateFieldPage extends Example {
  DateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  Widget example(BuildContext _) =>
      FDateField(label: const Text('Appointment Date'), description: const Text('Select a date for your appointment'));
}

@RoutePage()
class SplitGridDateFieldPage extends Example {
  SplitGridDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  Widget example(BuildContext _) => FDateField(
    // {@highlight}
    calendar: const FDateFieldGridSplitCalendarProperties(),
    // {@endhighlight}
    label: const Text('Appointment Date'),
    description: const Text('Select a date for your appointment'),
  );
}

@RoutePage()
class WheelDateFieldPage extends Example {
  WheelDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  Widget example(BuildContext _) => FDateField(
    // {@highlight}
    calendar: const FDateFieldWheelCalendarProperties(),
    // {@endhighlight}
    label: const Text('Appointment Date'),
    description: const Text('Select a date for your appointment'),
  );
}

@RoutePage()
class CalendarDateFieldPage extends Example {
  CalendarDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  Widget example(BuildContext _) => FDateField.calendar(
    label: const Text('Appointment Date'),
    description: const Text('Select a date for your appointment'),
  );
}

@RoutePage()
class InputDateFieldPage extends Example {
  InputDateFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FDateField.input(
    label: const Text('Appointment Date'),
    description: const Text('Select a date for your appointment'),
  );
}

@RoutePage()
class ClearableDateFieldPage extends Example {
  ClearableDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  Widget example(BuildContext _) => FDateField(
    selectionControl: .managedSingle(initial: .now()),
    label: const Text('Appointment Date'),
    description: const Text('Select a date for your appointment'),
    // {@highlight}
    clearable: true,
    // {@endhighlight}
  );
}

@RoutePage()
class PopoverBuilderDateFieldPage extends Example {
  PopoverBuilderDateFieldPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 30);

  @override
  Widget example(BuildContext _) => FDateField.calendar(
    style: .delta(
      calendarStyle: .delta(
        decoration: .boxDelta(border: .fromLTRB()),
        padding: const .value(.only(left: 11, top: 11, right: 11)),
      ),
    ),
    label: const Text('Appointment Date'),
    description: const Text('Select a date for your appointment'),
    // {@highlight}
    calendar: FDateFieldGridCalendarProperties(
      popoverBuilder: (context, controller, popoverController, content) => Padding(
        padding: const .all(1.0),
        child: Column(
          mainAxisSize: .min,
          children: [
            content,
            Padding(
              padding: const .all(8.0),
              child: Row(
                mainAxisSize: .min,
                spacing: 6,
                children: [
                  for (final label in ['Today', 'Tomorrow', 'In a week'])
                    FButton(variant: .outline, size: .sm, child: Text(label), onPress: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    // {@endhighlight}
  );
}

@RoutePage()
class ValidatorDateFieldPage extends Example {
  ValidatorDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  Widget example(BuildContext _) => FDateField(
    // {@highlight}
    validator: (date) => date?.weekday == 6 || date?.weekday == 7 ? 'Date cannot be a weekend.' : null,
    // {@endhighlight}
    label: const Text('Appointment Date'),
    description: const Text('Select a date for your appointment'),
  );
}

@RoutePage()
class FormDateFieldPage extends StatefulExample {
  FormDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  State<FormDateFieldPage> createState() => _FormDateFieldPageState();
}

class _FormDateFieldPageState extends StatefulExampleState<FormDateFieldPage> {
  final _key = GlobalKey<FormState>();
  late final _startSelection = FDateSelectionController.single();

  @override
  void dispose() {
    _startSelection.dispose();
    super.dispose();
  }

  @override
  Widget example(BuildContext _) => Form(
    key: _key,
    child: Column(
      spacing: 16,
      children: [
        FDateField(
          validator: (date) => switch (date) {
            null => 'Please select a start date',
            final date when date.isBefore(.now()) => 'Start date must be in the future',
            _ => null,
          },
          selectionControl: .managedSingle(controller: _startSelection),
          label: const Text('Start Date'),
          description: const Text('Select a start date'),
          autovalidateMode: .disabled,
        ),
        const SizedBox(height: 20),
        FDateField(
          validator: (date) => switch (date) {
            null => 'Please select an end date',
            final date when _startSelection.value != null && date.isBefore(_startSelection.value!) =>
              'Start date must be in the future',
            _ => null,
          },
          label: const Text('End Date'),
          description: const Text('Select an end date'),
          autovalidateMode: .disabled,
        ),
        Row(
          mainAxisAlignment: .end,
          children: [
            FButton(
              size: .sm,
              mainAxisSize: .min,
              child: const Text('Submit'),
              onPress: () {
                if (_key.currentState!.validate()) {
                  // Form is valid, do something.
                }
              },
            ),
          ],
        ),
      ],
    ),
  );
}
