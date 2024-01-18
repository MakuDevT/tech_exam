import 'package:flutter/material.dart';

class CalendarDayButton extends StatelessWidget {
  const CalendarDayButton({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () => {}, child: Text(title));
  }
}
