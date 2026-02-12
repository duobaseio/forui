import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:forui_hooks/forui_hooks.dart';

// {@highlight}
// {@endhighlight}

// {@highlight}
class Example extends HookWidget {
  // {@endhighlight}
  @override
  Widget build(BuildContext _) {
    // {@highlight}
    final controller = useFAccordionController();
    // {@endhighlight}
    return FAccordion(
      // {@highlight}
      control: .managed(controller: controller),
      // {@endhighlight}
      children: const [
        FAccordionItem(
          title: Text('Production Information'),
          child: Text(
            'Our flagship product combines cutting-edge technology with sleek design. '
            'Built with premium materials, it offers unparalleled performance and '
            'reliability.\n'
            'Key features include advanced processing capabilities, and an intuitive '
            'user interface designed for both beginners and experts.',
          ),
        ),
        FAccordionItem(
          initiallyExpanded: true,
          title: Text('Shipping Details'),
          child: Text(
            'We offer worldwide shipping through trusted courier partners. '
            'Standard delivery takes 3-5 business days, while express shipping '
            'ensures delivery within 1-2 business days.\n'
            'All orders are carefully packaged and fully insured. Track your'
            ' shipment in real-time through our dedicated tracking portal.',
          ),
        ),
        FAccordionItem(
          title: Text('Return Policy'),
          child: Text(
            'We stand behind our products with a comprehensive 30-day return policy. '
            "If you're not completely satisfied, simply return the item in its "
            'original condition.\n'
            'Our hassle-free return process includes free return shipping and full '
            'refunds processed within 48 hours of receiving the returned item.',
          ),
        ),
      ],
    );
  }
}
