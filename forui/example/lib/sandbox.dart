import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) => FButton(
    mainAxisSize: .min,
    prefix: const Icon(FIcons.mail),
    onPress: () {},
    style: .delta(
      decoration: .delta([
        .base(const .delta(color: Colors.blue)),
        .exact({.hovered}, const .delta(color: Colors.blueAccent)),
        .match({.pressed}, const .delta(color: Colors.black)),
      ]),
      contentStyle: .delta(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        spacing: 10,
        textStyle: .delta([
          // .all(const .delta(decoration: .underline))
          .exact({.hovered}, const .delta(decoration: .underline, color: Colors.red)),
          .exact({.hovered.and(.pressed)}, const .delta(decoration: .underline)),
        ]),
      ),
    ),
    child: const Text('Login with Email'),
  );
}
