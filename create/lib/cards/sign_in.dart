import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';

/// A sign-in form with email and password fields.
class SignInCard extends StatelessWidget {
  /// Creates a [SignInCard].
  const SignInCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;

    return PreviewCard(
      title: 'Welcome back',
      subtitle: 'Sign in to your account.',
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          const FTextField.email(label: Text('Email'), hint: 'you@example.com'),
          const SizedBox(height: 12),
          FTextField.password(label: const Text('Password'), hint: '••••••••'),
          const SizedBox(height: 12),
          Row(
            children: [
              const Flexible(child: _RememberMe()),
              const SizedBox(width: 12),
              Text('Forgot password?', style: typography.body.sm.copyWith(color: colors.mutedForeground)),
            ],
          ),
          const SizedBox(height: 16),
          FButton(onPress: () {}, child: const Text('Sign in')),
          const SizedBox(height: 16),
          const _OrSeparator(),
          const SizedBox(height: 16),
          FButton(variant: .outline, onPress: () {}, child: const Text('Continue with Forui')),
        ],
      ),
    );
  }
}

class _RememberMe extends StatefulWidget {
  const _RememberMe();

  @override
  State<_RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<_RememberMe> {
  bool _value = true;

  @override
  Widget build(BuildContext context) =>
      FCheckbox(label: const Text('Remember me'), value: _value, onChange: (value) => setState(() => _value = value));
}

class _OrSeparator extends StatelessWidget {
  const _OrSeparator();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return Row(
      children: [
        Expanded(
          child: SizedBox(height: 1, child: ColoredBox(color: colors.border)),
        ),
        Padding(
          padding: const .symmetric(horizontal: 12),
          child: Text('or continue with', style: theme.typography.body.xs.copyWith(color: colors.mutedForeground)),
        ),
        Expanded(
          child: SizedBox(height: 1, child: ColoredBox(color: colors.border)),
        ),
      ],
    );
  }
}
