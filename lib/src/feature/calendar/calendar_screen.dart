import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'presentation/widgets/calendar_date_view.dart';
import 'presentation/widgets/calendar_input_view.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
             color: (Colors.teal[400])!,
              width: MediaQuery.of(context).size.width * 0.005,
            )),
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
          top: MediaQuery.of(context).size.height * 0.06,
          bottom: MediaQuery.of(context).size.height * 0.06,
        ),
        child: const Column(
          children: [
            CalendarInputView(),
            CalendarDateView(),
          ],
        ),
      ),
    );
  }
}
