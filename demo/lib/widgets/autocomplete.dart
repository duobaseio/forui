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

class Autocomplete extends StatelessWidget {
  const Autocomplete({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(32),
    child: SizedBox(
      width: 350,
      child: FAutocomplete(
        label: const Text('Fruit'),
        hint: 'Type a fruit',
        items: _fruits,
      ),
    ),
  );
}
