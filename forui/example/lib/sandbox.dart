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
  final _scroll = FLineCalendarScrollController(
    start: DateTime.utc(2024),
    end: DateTime.utc(2026),
    today: DateTime.utc(2025, 6, 15),
  );
  static const _target = (year: 2025, month: 6, day: 15);
  double _offset = 0;
  double _viewportWidth = 400;
  AlignmentDirectional _alignment = AlignmentDirectional.center;

  @override
  void dispose() {
    _scroll.dispose();
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
          SizedBox(
            width: _viewportWidth,
            child: FLineCalendar(
              scrollControl: .managed(controller: _scroll, onChange: (offset) => setState(() => _offset = offset)),
            ),
          ),
          Text('offset: ${_offset.toStringAsFixed(1)}    viewport: ${_viewportWidth.toStringAsFixed(0)}'),
          SizedBox(
            width: 320,
            child: Material(
              child: Slider(
                value: _viewportWidth,
                min: 120,
                max: 600,
                onChanged: (v) => setState(() => _viewportWidth = v),
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (final (label, value) in const [
                ('start', AlignmentDirectional.centerStart),
                ('center', AlignmentDirectional.center),
                ('end', AlignmentDirectional.centerEnd),
              ])
                FButton(
                  mainAxisSize: .min,
                  variant: _alignment == value ? .primary : .outline,
                  onPress: () => setState(() => _alignment = value),
                  child: Text(label),
                ),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              FButton(
                mainAxisSize: .min,
                onPress: () => _scroll.animateToDate(
                  DateTime.utc(_target.year, _target.month, _target.day),
                  alignment: _alignment,
                ),
                child: const Text('Animate to today'),
              ),
              FButton(
                mainAxisSize: .min,
                onPress: () =>
                    _scroll.jumpToDate(DateTime.utc(_target.year, _target.month, _target.day), alignment: _alignment),
                child: const Text('Jump to today'),
              ),
              FButton(
                mainAxisSize: .min,
                onPress: () => _scroll.animateToDate(DateTime.utc(2024), alignment: _alignment),
                child: const Text('Jump to start'),
              ),
              FButton(
                mainAxisSize: .min,
                onPress: () => _scroll.animateToDate(DateTime.utc(2025, 12, 31), alignment: _alignment),
                child: const Text('NYE'),
              ),
            ],
          ),
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
