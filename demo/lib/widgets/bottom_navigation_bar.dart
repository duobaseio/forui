import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: FBottomNavigationBar(
          index: _index,
          onChange: (index) => setState(() => _index = index),
          children: const [
            FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home')),
            FBottomNavigationBarItem(icon: Icon(FIcons.layoutGrid), label: Text('Browse')),
            FBottomNavigationBarItem(icon: Icon(FIcons.libraryBig), label: Text('Library')),
            FBottomNavigationBarItem(icon: Icon(FIcons.settings), label: Text('Settings')),
          ],
        ),
      ),
    );
  }
}
