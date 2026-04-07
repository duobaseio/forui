import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

const _fruits = [
  'Apple',
  'Banana',
  'Blueberry',
  'Grapes',
  'Lemon',
  'Mango',
  'Kiwi',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Plum',
  'Raspberry',
  'Strawberry',
  'Watermelon',
];

class Select extends StatelessWidget {
  const Select({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: SizedBox(
        width: 350,
        child: Column(
          spacing: 24,
          children: [
            FSelect<String>.search(
              label: const Text('Searchable'),
              hint: 'Select a fruit',
              clearable: true,
              items: {for (final fruit in _fruits) fruit: fruit},
            ),
            FSelect<String>.rich(
              label: const Text('Rich'),
              hint: 'Type',
              format: (s) => s,
              children: [
                .item(
                  prefix: const Icon(FIcons.bug),
                  title: const Text('Bug'),
                  subtitle: const Text('An unexpected problem'),
                  value: 'Bug',
                ),
                .item(
                  prefix: const Icon(FIcons.filePlusCorner),
                  title: const Text('Feature'),
                  subtitle: const Text('A new feature or enhancement'),
                  value: 'Feature',
                ),
                .item(
                  prefix: const Icon(FIcons.messageCircleQuestionMark),
                  title: const Text('Question'),
                  subtitle: const Text('A question or clarification'),
                  value: 'Question',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
