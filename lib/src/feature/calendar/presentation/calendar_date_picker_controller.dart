import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CalendarFormController extends StateNotifier<AsyncValue> {
  CalendarFormController() : super(const AsyncValue<void>.data(null));
  DateTime selectedDate = DateTime.now();
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  String textCurrentMonth = DateFormat.MMMM().format(DateTime.now());
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  Future<void> selectDate(BuildContext context, String nameField) async {
    state = const AsyncLoading();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      if (nameField == 'from') {
        fromDate = picked;
      }
      if (nameField == 'to') {
        toDate = picked;
      }
    }
    state = const AsyncData(null);
  }
}

final calendarFormControllerProvider =
    StateNotifierProvider<CalendarFormController, AsyncValue<void>>((ref) {
  return CalendarFormController();
});
final calendarTextFieldFromControllerProvider =
    StateNotifierProvider<CalendarFormController, AsyncValue<void>>((ref) {
  return CalendarFormController();
});
final calendarTextFieldToControllerProvider =
    StateNotifierProvider<CalendarFormController, AsyncValue<void>>((ref) {
  return CalendarFormController();
});
