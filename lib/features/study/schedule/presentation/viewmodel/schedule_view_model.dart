import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/utils/schedule_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleViewModel extends GetxController {
  final ScheduleService _scheduleService;
  ScheduleViewModel({required ScheduleService scheduleService}) : _scheduleService = scheduleService;

  late final Rx<CalendarController> _controller = CalendarController().obs;
  CalendarController get controller => _controller.value;

  final RxList<Schedule> _schedules = <Schedule>[].obs;
  List<Schedule> get schedules => _schedules;
  ScheduleService get scheduleService => ScheduleService(schedules);

  final RxList<DateTime> _selectedDates = <DateTime>[].obs;
  List<DateTime> get selectedDates => _selectedDates;

  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxList<DateTime> selectedDateRange = <DateTime>[].obs;

  @override
  void onInit() {
    // 테스트 코드
    schedules.addAll([
      Schedule('Meeting 1', DateTime.now(), DateTime.now().add(Duration(hours: 2)), Colors.blue, false),
      Schedule('All-day Event', DateTime.now(), DateTime.now().add(Duration(days: 1)), Colors.green, true),
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    _controller.value.dispose();
    super.onClose();
  }


/* get */
  List<Schedule> getDataSource() {
    final List<Schedule> meetings = <Schedule>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Schedule(
        'Test', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }


  void onTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      final tappedDate = DateTime(details.date!.year, details.date!.month, details.date!.day);

      if (selectedDateRange.length > 1) {
        // 범위 선택 상태에서 탭한 경우
        if (selectedDateRange.contains(tappedDate)) {
          // 탭한 날짜가 선택된 범위 내에 있으면 해당 날짜만 선택
          selectedDate.value = tappedDate;
          selectedDateRange.clear();
          selectedDateRange.add(tappedDate);
        } else {
          // 범위 밖의 날짜를 탭하면 새로운 단일 선택
          selectedDate.value = tappedDate;
          selectedDateRange.clear();
          selectedDateRange.add(tappedDate);
        }
      } else if (selectedDate.value == tappedDate) {
        // 이미 선택된 단일 날짜를 다시 탭하면 선택 해제
        selectedDate.value = null;
        selectedDateRange.clear();
      } else {
        // 새로운 날짜 선택
        selectedDate.value = tappedDate;
        selectedDateRange.clear();
        selectedDateRange.add(tappedDate);
      }
    }
  }

  void onLongPress(CalendarLongPressDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      final longPressedDate = DateTime(details.date!.year, details.date!.month, details.date!.day);

      if (selectedDate.value != null) {
        // 범위 선택
        final startDate = selectedDate.value!;
        final endDate = longPressedDate;

        selectedDateRange.clear();
        for (var date = startDate;
        date.isBefore(endDate.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
          selectedDateRange.add(date);
        }
      } else {
        // 단일 날짜 선택 (길게 누르기)
        selectedDate.value = longPressedDate;
        selectedDateRange.clear();
        selectedDateRange.add(longPressedDate);
      }
    }
  }

}

