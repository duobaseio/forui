// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class TabsPage extends Example {
  TabsPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => Column(
    mainAxisAlignment: .center,
    children: [
      Padding(
        padding: const .all(16),
        child: FTabs(
          children: [
            .entry(
              label: const Text('Account'),
              child: FCard(
                builder: (context, style, _) => Padding(
                  padding: style.padding,
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,
                    children: [
                      Text('Account', style: style.titleTextStyle),
                      const SizedBox(height: 2),
                      Text(
                        'Make changes to your account here. Click save when you are done.',
                        style: style.subtitleTextStyle,
                      ),
                      const SizedBox(height: 6),
                      const FTextField(label: Text('Name'), hint: 'John Renalo'),
                      const SizedBox(height: 10),
                      const FTextField(label: Text('Email'), hint: 'john@doe.com'),
                      const SizedBox(height: 16),
                      FButton(child: const Text('Save'), onPress: () {}),
                    ],
                  ),
                ),
              ),
            ),
            .entry(
              label: const Text('Password'),
              child: FCard(
                builder: (context, style, _) => Padding(
                  padding: style.padding,
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,
                    children: [
                      Text('Password', style: style.titleTextStyle),
                      const SizedBox(height: 2),
                      Text(
                        'Change your password here. After saving, you will be logged out.',
                        style: style.subtitleTextStyle,
                      ),
                      const SizedBox(height: 6),
                      const FTextField(label: Text('Current password')),
                      const SizedBox(height: 10),
                      const FTextField(label: Text('New password')),
                      const SizedBox(height: 16),
                      FButton(child: const Text('Save'), onPress: () {}),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

@RoutePage()
class SwipeableTabsPage extends Example {
  SwipeableTabsPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => Padding(
    padding: const .all(16),
    child: SizedBox(
      height: 350,
      child: FTabs(
        // {@highlight}
        // Swiping between tabs requires expands to be true and contentPhysics to not be NeverScrollableScrollPhysics.
        expands: true,
        contentPhysics: const BouncingScrollPhysics(),
        // {@endhighlight}
        children: [
          .entry(
            label: const Text('Account'),
            child: FCard(
              builder: (context, style, _) => Padding(
                padding: style.padding,
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    Text('Account', style: style.titleTextStyle),
                    const SizedBox(height: 2),
                    Text(
                      'Make changes to your account here. Click save when you are done.',
                      style: style.subtitleTextStyle,
                    ),
                    const SizedBox(height: 6),
                    const FTextField(label: Text('Name'), hint: 'John Renalo'),
                    const SizedBox(height: 10),
                    const FTextField(label: Text('Email'), hint: 'john@doe.com'),
                    const SizedBox(height: 16),
                    FButton(child: const Text('Save'), onPress: () {}),
                  ],
                ),
              ),
            ),
          ),
          .entry(
            label: const Text('Password'),
            child: FCard(
              builder: (context, style, _) => Padding(
                padding: style.padding,
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    Text('Password', style: style.titleTextStyle),
                    const SizedBox(height: 2),
                    Text(
                      'Change your password here. After saving, you will be logged out.',
                      style: style.subtitleTextStyle,
                    ),
                    const SizedBox(height: 6),
                    const FTextField(label: Text('Current password')),
                    const SizedBox(height: 10),
                    const FTextField(label: Text('New password')),
                    const SizedBox(height: 16),
                    FButton(child: const Text('Save'), onPress: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
