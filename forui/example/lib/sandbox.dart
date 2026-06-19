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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          FSelect<String>(
            hint: 'Select a fruit',
            label: const Text('Fruit'),
            description: const Text('Select a fruit'),
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
          FMultiSelect<String>(
            hint: const Text('Select fruits'),
            label: const Text('Fruits'),
            description: const Text('Select your favorite fruits'),
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
        ],
      ),
    ),
  );
}
