import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_exam/src/feature/calendar/presentation/widgets/calendar_radio.dart';

import '../../../../../common/custom_input_field.dart';
import '../calendar_date_picker_controller.dart';
import '../calendar_screen_controller.dart';

class CalendarInputView extends ConsumerStatefulWidget {
  const CalendarInputView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CalendarInputViewState();
}

class _CalendarInputViewState extends ConsumerState<CalendarInputView> {
  final TextEditingController eventController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calendarControllerProvider);
    final fieldFromState = ref.watch(calendarTextFieldFromControllerProvider);
    final fieldToState = ref.watch(calendarTextFieldToControllerProvider);
    int selectedYear =
        ref.read(calendarControllerProvider.notifier).currentYear;
    String selectedMonth =
        ref.read(calendarControllerProvider.notifier).textCurrentMonth;
    String fromDate = ref
        .read(calendarTextFieldFromControllerProvider.notifier)
        .fromDate
        .toString()
        .split(' ')[0];
    String toDate = ref
        .read(calendarTextFieldToControllerProvider.notifier)
        .toDate
        .toString()
        .split(' ')[0];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          color: (Colors.teal[400])!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () => ref
                      .read(calendarControllerProvider.notifier)
                      .previousMonthClicked(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(left: 5),
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white, // <-- Button color
                  ),
                  child: const Icon(
                    size: 15,
                    Icons.arrow_back_ios,
                    color: Colors.teal,
                  ),
                ),
              ),
              if (state.isLoading)
                const CircularProgressIndicator()
              else
                Text(
                  '$selectedMonth $selectedYear',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () => ref
                      .read(calendarControllerProvider.notifier)
                      .nextMonthClicked(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(left: 1),
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white, // <-- Button color
                  ),
                  child: const Icon(
                    size: 15,
                    Icons.arrow_forward_ios,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
              top: MediaQuery.of(context).size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomInputField(
                titleText: 'Event',
                labelText: 'Enter event',
                controller: eventController,
                isDate: false,
              ),
              if (fieldFromState.isLoading)
                CustomInputField(
                  titleText: 'From',
                  labelText: fromDate,
                  isDate: true,
                )
              else
                CustomInputField(
                  titleText: 'From',
                  isEnabled: false,
                  labelText: fromDate,
                  isDate: true,
                  onTap: () => ref
                      .read(calendarTextFieldFromControllerProvider.notifier)
                      .selectDate(context, 'from'),
                ),
              if (fieldToState.isLoading)
                CustomInputField(
                  titleText: 'To',
                  isEnabled: false,
                  isDate: true,
                  labelText: 'Select a date',
                  onTap: () => ref
                      .read(calendarTextFieldToControllerProvider.notifier)
                      .selectDate(context, 'to'),
                )
              else
                CustomInputField(
                  titleText: 'To',
                  isEnabled: false,
                  isDate: true,
                  labelText: toDate,
                  onTap: () => {
                    ref
                        .read(calendarTextFieldToControllerProvider.notifier)
                        .selectDate(context, 'to'),
                  },
                ),
              // ignore: prefer_const_constructors
              RadioButtons(),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: (Colors.teal[400])),
                        onPressed: () {
                          final String event = eventController.text;
                          ref
                              .read(addEventControllerProvider.notifier)
                              .addEvent(event);
                        },
                        child: const Text('ADD'),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Expanded(
                        flex: 3,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: (Colors.black54)),
                            onPressed: () => {},
                            child: const Text('OVERRIDE')))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
