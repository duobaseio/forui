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
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              FBadge(child: Text('Primary')),
              FBadge(variant: .secondary, child: Text('Secondary')),
              FBadge(variant: .outline, child: Text('Outline')),
              FBadge(variant: .destructive, child: Text('Destructive')),
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
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              FButton(onPress: () {}, child: Text('Primary')),
              FButton(variant: .secondary, onPress: () {}, child: Text('Secondary')),
              FButton(variant: .outline, onPress: () {}, child: Text('Outline')),
              FButton(variant: .destructive, onPress: () {}, child: Text('Destructive')),
            ],
          ),
        ],
      ),
    ),
  );
}
