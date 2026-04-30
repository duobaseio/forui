import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Accordion extends StatelessWidget {
  const Accordion({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: 400,
      child: FAccordion(
        control: .managed(max: 2),
        children: const [
          FAccordionItem(
            initiallyExpanded: true,
            title: Text('What is Forui?'),
            child: Text('A beautiful, minimalistic, platform-agnostic UI library for Flutter.'),
          ),
          FAccordionItem(
            title: Text('Touch or desktop?'),
            child: Text('Both. Forui ships touch and desktop interactions out of the box.'),
          ),
          FAccordionItem(
            title: Text('How many widgets?'),
            child: Text('Over 50, beautifully crafted and well-tested.'),
          ),
        ],
      ),
    ),
  );
}
