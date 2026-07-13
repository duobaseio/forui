import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Switch extends StatefulWidget {
  const Switch({super.key});

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: SizedBox(
        width: 400,
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              Text(
                'Email Notifications',
                style: theme.typography.display.xl2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colors.foreground,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 15),
              FCard.raw(
                child: Padding(
                  padding: const .fromLTRB(16, 12, 16, 16),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              'Marketing Emails',
                              style: theme.typography.body.md.copyWith(
                                fontWeight: .w500,
                                color: theme.colors.foreground,
                                height: 1.5,
                              ),
                            ),
                            Text(
                              'Receive emails about new products, features, and more.',
                              style: theme.typography.body.sm.copyWith(color: theme.colors.mutedForeground),
                            ),
                          ],
                        ),
                      ),
                      FormField(
                        initialValue: false,
                        onSaved: (value) {
                          // Save values somewhere.
                        },
                        validator: (value) => null, // No validation required.
                        builder: (state) =>
                            FSwitch(value: state.value ?? false, onChange: (value) => state.didChange(value)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FCard.raw(
                child: Padding(
                  padding: const .fromLTRB(16, 12, 16, 16),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              'Security emails',
                              style: theme.typography.body.md.copyWith(
                                fontWeight: .w500,
                                color: theme.colors.foreground,
                                height: 1.5,
                              ),
                            ),
                            Text(
                              'Receive emails about your account security.',
                              style: theme.typography.body.sm.copyWith(color: theme.colors.mutedForeground),
                            ),
                          ],
                        ),
                      ),
                      FormField(
                        initialValue: true,
                        onSaved: (value) {
                          // Save values somewhere.
                        },
                        validator: (value) => null, // No validation required.
                        builder: (state) =>
                            FSwitch(value: state.value ?? false, onChange: (value) => state.didChange(value)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FButton(
                child: const Text('Submit'),
                onPress: () {
                  if (!_key.currentState!.validate()) {
                    // Handle errors here.
                    return;
                  }

                  _key.currentState!.save();
                  // Do something.
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
