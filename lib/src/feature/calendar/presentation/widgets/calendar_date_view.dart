import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../calendar_screen_controller.dart';
import 'calendar_table.dart';

class CalendarDateView extends ConsumerStatefulWidget {
  const CalendarDateView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CalendarDateViewState();
}

class _CalendarDateViewState extends ConsumerState<CalendarDateView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calendarControllerProvider);
    final tableCellState = ref.watch(addEventControllerProvider);
    int selectedYear =
        ref.read(calendarControllerProvider.notifier).currentYear;
    int selectedMonth =
        ref.read(calendarControllerProvider.notifier).currentMonth;
    return Container(
      color: Colors.teal,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
          top: MediaQuery.of(context).size.width * 0.03),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.01),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: (Colors.teal[400]),
                  side: const BorderSide(width: 2.0, color: Colors.white)),
              onPressed: () => {
                ref
                    .read(calendarControllerProvider.notifier)
                    .currentMonthClicked()
              },
              child: const Text('THIS MONTH'),
            ),
          ),
          if (state.isLoading) const CircularProgressIndicator(),
          if (state.hasValue)
            tableCellState.isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      _buildDayNames(),
                      buildCalendarTable(
                          selectedYear, selectedMonth, ref, context),
                    ],
                  ),
        ],
      ),
    );
  }
}

Widget _buildDayNames() {
  final List<String> dayName = <String>[
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT'
  ];
  return Table(
    children: [
      TableRow(
          children: List.generate(
              7,
              (col) => Center(
                      child: Text(
                    dayName[col],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ))))
    ],
  );
}
