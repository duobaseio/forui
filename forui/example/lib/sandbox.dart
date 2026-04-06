import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          FDateField(
            control: .managed(initial: DateTime(2025, 12, 31)),
            label: const Text('Start Date'),
            description: const Text('Select a start date'),
          ),
          FDateField(label: const Text('End Date'), description: const Text('Select an end date')),
          FSlider(
            control: .managedContinuous(initial: FSliderValue(max: 0.35)),
            marks: const [
              .mark(value: 0, label: Text('0%')),
              .mark(value: 0.25, tick: false),
              .mark(value: 0.5),
              .mark(value: 0.75, tick: false),
              .mark(value: 1, label: Text('100%')),
            ],
          ),
          FMultiSelect<String>(
            hint: const Text('Select fruits'),
            label: const Text('Fruits'),
            items: const {
              'Apple': 'Apple',
              'Banana': 'Banana',
              'Blueberry': 'Blueberry',
              'Grapes': 'Grapes',
              'Lemon': 'Lemon',
              'Mango': 'Mango',
              'Kiwi': 'Kiwi',
              'Orange': 'Orange',
              'Pear': 'Pear',
              'Strawberry': 'Strawberry',
            },
          ),
          FTextFormField(
            label: const Text('TextFormField'),
            maxLength: 6,
            keyboardType: .number,
            textInputAction: .send,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ],
      ),
    ),
  );
}
