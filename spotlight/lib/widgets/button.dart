import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100),
      child: Center(
        child: FTappableGroup(
        child: Wrap(
          alignment: .center,
          spacing: 16,
          runSpacing: 16,
          children: [
            FButton(
              mainAxisSize: .min,
              onPress: () {},
              child: const Text('Primary'),
            ),
            FButton(
              mainAxisSize: .min,
              variant: .secondary,
              onPress: () {},
              child: const Text('Secondary'),
            ),
            FButton(
              mainAxisSize: .min,
              variant: .destructive,
              onPress: () {},
              child: const Text('Destructive'),
            ),
            FButton(
              mainAxisSize: .min,
              variant: .outline,
              onPress: () {},
              child: const Text('Outline'),
            ),
            FButton(
              mainAxisSize: .min,
              variant: .ghost,
              onPress: () {},
              child: const Text('Ghost'),
            ),
            FButton(
              mainAxisSize: .min,
              prefix: const FCircularProgress(),
              onPress: null,
              child: const Text('Loading'),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
