import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Slider extends StatelessWidget {
  const Slider({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 360,
        child: Column(
          mainAxisAlignment: .center,
          spacing: 48,
          children: [
            // Continuous range: two thumbs slide smoothly to select a span.
            FSlider(
              control: .managedContinuousRange(initial: FSliderValue(min: 0.25, max: 0.75)),
              label: const Text('Price range'),
              // The 0–1 track value maps to $0–$100, matching the marks.
              tooltipBuilder: (_, value) => Text('\$${(value * 100).round()}'),
              marks: const [
                .mark(value: 0, label: Text(r'$0')),
                .mark(value: 0.5, label: Text(r'$50')),
                .mark(value: 1, label: Text(r'$100')),
              ],
            ),
            // Discrete single value: one thumb snaps to each step.
            FSlider(
              control: .managedDiscrete(initial: FSliderValue(max: 0.5)),
              label: const Text('Brightness'),
              marks: const [
                .mark(value: 0, label: Text('Low')),
                .mark(value: 0.25),
                .mark(value: 0.5, label: Text('Mid')),
                .mark(value: 0.75),
                .mark(value: 1, label: Text('High')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
