import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../calendar_date_picker_controller.dart';
import 'calendar_radio_grid.dart';

class RadioButtons extends ConsumerWidget {
  const RadioButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Set<String> weekdays = {};
    final DateTime fromDate =
        ref.read(calendarTextFieldFromControllerProvider.notifier).fromDate;
    final DateTime toDate =
        ref.read(calendarTextFieldToControllerProvider.notifier).toDate;
    final DateTime fromDateWithoutTime =
        DateTime(fromDate.year, fromDate.month, fromDate.day);
    final DateTime toDateWithoutTime =
        DateTime(toDate.year, toDate.month, toDate.day);

    for (DateTime date = fromDateWithoutTime;
        date.isBefore(toDateWithoutTime.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      String weekday = getWeekdayName(date);
      if (!weekdays.contains(weekday)) {
        weekdays.add(weekday);
      }
    }

   
    List<String> weekdayList = weekdays.toList();
    return RadioButtonGrid(
      itemCount: weekdays.length,
      weekdayNames: weekdayList,
    );
  }
}

String getWeekdayName(DateTime date) {
  return DateFormat('EEEE').format(date);
}
