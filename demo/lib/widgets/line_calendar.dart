import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class LineCalendar extends StatelessWidget {
  const LineCalendar({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: FLineCalendar(control: .managed()),
  );
}
