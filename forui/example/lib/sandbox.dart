import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

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
          // Drag the dividers, then resize the window: the fixed sidebar keeps its pixel width and the flex
          // regions scale to fill the rest, without resetting to their initial sizes.
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: context.theme.colors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FResizable(
              axis: .horizontal,
              crossAxisExtent: 200,
              children: [
                .fixed(
                  extent: 160,
                  minExtent: 100,
                  builder: (context, data, _) => _Region(label: 'Sidebar (fixed)', data: data),
                ),
                .flex(builder: (context, data, _) => _Region(label: 'Content (flex 1)', data: data)),
                .flex(flex: 2, builder: (context, data, _) => _Region(label: 'Preview (flex 2)', data: data)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _Region extends StatelessWidget {
  final String label;
  final FResizableRegionData data;

  const _Region({required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    final FThemeData(:colors, :typography) = context.theme;
    return Align(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: typography.body.sm.copyWith(color: colors.foreground)),
          const SizedBox(height: 4),
          Text('${data.extent.current.round()} px', style: typography.body.xs.copyWith(color: colors.mutedForeground)),
        ],
      ),
    );
  }
}
