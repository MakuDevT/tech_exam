import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CalendarController extends StateNotifier<AsyncValue> {
  CalendarController() : super(const AsyncValue<void>.data(null));
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  String textCurrentMonth = DateFormat.MMMM().format(DateTime.now());
  String eventTyped = '';
  List<int> pickedDate = [];

  nextMonthClicked() {
    state = const AsyncLoading();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (currentMonth == 0 || currentMonth == 12) {
        currentYear = currentYear + 1;
      }
      currentMonth = currentMonth + 1;
      if (currentMonth >= 12) {
        currentMonth = 1;
      }
      DateTime nextMonthDate = DateTime(currentYear, currentMonth);
      textCurrentMonth = DateFormat.MMMM().format(nextMonthDate);

      state = const AsyncData(null);
    });
  }

  previousMonthClicked() {
    state = const AsyncLoading();
    Future.delayed(const Duration(milliseconds: 500), () {
      currentMonth--;
      DateTime prevMonthDate = DateTime(currentYear, currentMonth);
      textCurrentMonth = DateFormat.MMMM().format(prevMonthDate);
      if (currentMonth == 0) {
        currentMonth = 12;
        currentYear = currentYear - 1;
      }
      state = const AsyncData(null);
    });
  }

  currentMonthClicked() {
    state = const AsyncLoading();
    Future.delayed(const Duration(milliseconds: 500), () {
      currentYear = DateTime.now().year;
      currentMonth = DateTime.now().month;
      state = const AsyncData(null);
    });
  }

  addEvent(String event) {
    state = const AsyncLoading();
    Future.delayed(Duration(milliseconds: 500), () {
      eventTyped = event;
      state = const AsyncData(null);
    });
  }

  pickDate(int pickDate, bool checked) {
    state = const AsyncLoading();
    if (checked == true) {
      pickedDate.add(pickDate);
    } else {
      pickedDate.remove(pickDate);
    }
    state = const AsyncData(null);
  }
}

final calendarControllerProvider =
    StateNotifierProvider<CalendarController, AsyncValue<void>>((ref) {
  return CalendarController();
});
final addEventControllerProvider =
    StateNotifierProvider<CalendarController, AsyncValue<void>>((ref) {
  return CalendarController();
});
