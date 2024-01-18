import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../calendar_screen_controller.dart';

Widget buildCalendarTable(
    int year, int month, WidgetRef ref, BuildContext context) {
  DateTime firstDay = DateTime(year, month, 1);

  int daysInMonth = DateTime(year, month + 1, 0).day;

  int daysFromPrevMonth = (firstDay.weekday - DateTime.sunday) % 7;
  if (daysFromPrevMonth < 0) {
    daysFromPrevMonth = 7 + daysFromPrevMonth;
  }
  int daysFromNextMonth =
      7 - ((firstDay.add(Duration(days: daysInMonth - 1))).weekday + 1) % 7;

  List<TableRow> tableRows = List.generate(7, (index) => generateTableRow());

  DateTime prevMonth = firstDay.subtract(Duration(days: daysFromPrevMonth));
  for (int i = 0; i < daysFromPrevMonth; i++) {
    int day = prevMonth.day;
    tableRows[0].children[i] = buildTableCell(day, ref, context);
    prevMonth = prevMonth.add(const Duration(days: 1));
  }

  for (int i = 1; i <= daysInMonth; i++) {
    int row = (i + daysFromPrevMonth - 1) ~/ 7;
    int col = (i + daysFromPrevMonth - 1) % 7;
    int day = i;
    tableRows[row].children[col] = buildTableCell(day, ref, context);
  }

  DateTime nextMonth = firstDay.add(Duration(days: daysInMonth));
  for (int i = 0; i < daysFromNextMonth; i++) {
    int row = (daysInMonth + daysFromPrevMonth + i) ~/ 7;
    int col = (daysInMonth + daysFromPrevMonth + i) % 7;
    int day = nextMonth.day;
    tableRows[row].children[col] = buildTableCell(day, ref, context);
    nextMonth = nextMonth.add(const Duration(days: 1));
  }

  return Table(
    children: tableRows,
  );
}

TableRow generateTableRow() {
  List<Widget> cells = List.generate(7, (index) => Container());
  return TableRow(children: cells);
}

TableCell buildTableCell(
  int day,
  WidgetRef ref,
  BuildContext context,
) {
  final String eventName =
      ref.read(addEventControllerProvider.notifier).eventTyped;
  final List<int> pickDates =
      ref.read(addEventControllerProvider.notifier).pickedDate;

  return TableCell(
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: const TextStyle(color: Colors.white),
            ),
            if (eventName != '')
              ...pickDates.map((int element) {
                if (element == day) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            foregroundDecoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          'Events',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        bottom: 15,
                                        top: 15),
                                    padding: const EdgeInsets.only(left: 10),
                                    color: Colors.grey[600],
                                    child: Table(children: [
                                      TableRow(children: [
                                        Text(
                                          '1. ${eventName}',
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ])
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          eventName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.teal[400],
                              fontWeight: FontWeight.bold),
                        )),
                  );
                }
                return const Text('');
              }).toList(),
          ],
        ),
      ),
    ),
  );
}
