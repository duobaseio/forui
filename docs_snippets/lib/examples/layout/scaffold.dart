import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class ScaffoldPage extends StatefulExample {
  ScaffoldPage({@queryParam super.theme});

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends StatefulExampleState<ScaffoldPage> {
  final _headers = [
    const FHeader(title: Text('Home')),
    const FHeader(title: Text('Categories')),
    const FHeader(title: Text('Search')),
    FHeader(
      title: const Text('Settings'),
      suffixes: [FHeaderAction(icon: const Icon(FLucideIcons.ellipsis), onPress: () {})],
    ),
  ];

  final _contents = [
    const Column(mainAxisAlignment: .center, children: [Text('Home Placeholder')]),
    const Column(mainAxisAlignment: .center, children: [Text('Categories Placeholder')]),
    const Column(mainAxisAlignment: .center, children: [Text('Search Placeholder')]),
    Column(
      children: [
        const SizedBox(height: 5),
        FCard(
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
      ],
    ),
  ];

  int _index = 3;

  @override
  Widget example(BuildContext _) => SizedBox(
    height: 500,
    child: FScaffold(
      header: _headers[_index],
      footer: FBottomNavigationBar(
        index: _index,
        onChange: (index) => setState(() => _index = index),
        children: const [
          FBottomNavigationBarItem(icon: Icon(FLucideIcons.house), label: Text('Home')),
          FBottomNavigationBarItem(icon: Icon(FLucideIcons.layoutGrid), label: Text('Categories')),
          FBottomNavigationBarItem(icon: Icon(FLucideIcons.search), label: Text('Search')),
          FBottomNavigationBarItem(icon: Icon(FLucideIcons.settings), label: Text('Settings')),
        ],
      ),
      child: _contents[_index],
    ),
  );
}
