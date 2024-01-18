import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../calendar_date_picker_controller.dart';
import '../calendar_screen_controller.dart';

class RadioButtonGrid extends ConsumerStatefulWidget {
  final int itemCount;
  final List<String> weekdayNames;

  const RadioButtonGrid({
    Key? key,
    required this.itemCount,
    required this.weekdayNames,
  }) : super(key: key);

  @override
  RadioButtonGridState createState() => RadioButtonGridState();
}

class RadioButtonGridState extends ConsumerState<RadioButtonGrid> {
  List<int> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    int columns = 2;
    int rows = (widget.itemCount / columns).ceil();

    return Column(
      children: List.generate(rows, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(columns, (column) {
            int index = row * columns + column;
            return index < widget.itemCount
                ? Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                          value: selectedValues.contains(index),
                          onChanged: (isChecked) {
                            setState(() {
                              if (isChecked!) {
                                selectedValues.add(index);
                                _getDaysForWeekday(
                                    widget.weekdayNames[index], true, ref);
                              } else {
                                selectedValues.remove(index);
                                _getDaysForWeekday(
                                    widget.weekdayNames[index], false, ref);
                              }
                            });
                          },
                        ),
                        Text(
                          widget.weekdayNames[index],
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  )
                : Container();
          }),
        );
      }),
    );
  }

  List<int> _getDaysForWeekday(String weekday, bool checked, WidgetRef ref) {
    final DateTime fromDate =
        ref.read(calendarTextFieldFromControllerProvider.notifier).fromDate;
    final DateTime toDate =
        ref.read(calendarTextFieldToControllerProvider.notifier).toDate;
    final DateTime fromDateWithoutTime =
        DateTime(fromDate.year, fromDate.month, fromDate.day);
    final DateTime toDateWithoutTime =
        DateTime(toDate.year, toDate.month, toDate.day);
    List<int> dayValues = [];

    for (DateTime date = fromDateWithoutTime;
        date.isBefore(toDateWithoutTime.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      if (getWeekdayName(date) == weekday) {
        if (checked == true) {
          ref
              .read(addEventControllerProvider.notifier)
              .pickDate(date.day, true);
          dayValues.add(date.day);
        } else {
          dayValues.remove(date.day);
          ref
              .read(addEventControllerProvider.notifier)
              .pickDate(date.day, false);
        }
      }
    }

    return dayValues;
  }

  String getWeekdayName(DateTime date) {
    List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return weekdays[date.weekday - 1];
  }
}
