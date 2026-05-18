import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

const _alignments = <String, FToastAlignment?>{
  'default': null,
  'topStart': FToastAlignment.topStart,
  'topCenter': FToastAlignment.topCenter,
  'topEnd': FToastAlignment.topEnd,
  'topLeft': FToastAlignment.topLeft,
  'topRight': FToastAlignment.topRight,
  'bottomStart': FToastAlignment.bottomStart,
  'bottomCenter': FToastAlignment.bottomCenter,
  'bottomEnd': FToastAlignment.bottomEnd,
  'bottomLeft': FToastAlignment.bottomLeft,
  'bottomRight': FToastAlignment.bottomRight,
};

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
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (final MapEntry(:key, :value) in _alignments.entries)
                FButton(
                  mainAxisSize: .min,
                  onPress: () => showFToast(
                    context: context,
                    alignment: value,
                    title: Text(key),
                    description: const Text('Swipe or wait to dismiss.'),
                  ),
                  child: Text(key),
                ),
            ],
          ),
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
