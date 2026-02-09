import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

const fruits = ['Apple', 'Banana', 'Orange', 'Grape', 'Strawberry', 'Pineapple'];

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  Widget build(BuildContext context) =>
      Center(child: FSelect<String>.search(items: {for (final fruit in fruits) fruit: fruit}));
}
