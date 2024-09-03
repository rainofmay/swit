import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/utils/schedule_service.dart';
import 'package:swit/shared/constant/schedule_color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleViewModel extends GetxController {
  /* -- Calendar -- */
  late final Rx<CalendarController> _controller = CalendarController().obs;
  CalendarController get controller => _controller.value;

  final RxList<Schedule> _schedules = <Schedule>[].obs;
  List<Schedule> get schedules => _schedules;
  ScheduleService get scheduleService => ScheduleService(schedules);

  final RxList<DateTime> _selectedDates = <DateTime>[].obs;
  List<DateTime> get selectedDates => _selectedDates;

  late final Rx<DateTime?> _selectedDate = Rx<DateTime?>(null);
  DateTime? get selectedDate => _selectedDate.value;
  final RxList<DateTime> _selectedDateRange = <DateTime>[].obs;
  List<DateTime> get selectedDateRange => _selectedDateRange;

  /* -- Schedule -- */
  late final Rx<TextEditingController> _titleController;
  TextEditingController get titleController => _titleController.value;

  late final Rx<Color> _editingColor = ScheduleColor.colorList[0].obs;
  Color get editingColor => _editingColor.value;


  @override
  void onInit() {
    // 테스트 코드
    schedules.addAll([
      Schedule('Meeting 1', DateTime.now(), DateTime.now().add(Duration(hours: 2)), Colors.blue, false),
      Schedule('All-day Event', DateTime.now(), DateTime.now().add(Duration(days: 1)), Colors.green, true),
      Schedule('Meeting 1', DateTime.now(), DateTime.now().add(Duration(hours: 2)), Colors.blue, false),
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    _controller.value.dispose();
    _titleController.value.dispose();
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

      if (_selectedDateRange.length > 1) {
        // 범위 선택 상태에서 탭한 경우
        if (_selectedDateRange.contains(tappedDate)) {
          // 탭한 날짜가 선택된 범위 내에 있으면 해당 날짜만 선택
          _selectedDate.value = tappedDate;
          _selectedDateRange.clear();
          _selectedDateRange.add(tappedDate);
        } else {
          // 범위 밖의 날짜를 탭하면 새로운 단일 선택
          _selectedDate.value = tappedDate;
          _selectedDateRange.clear();
          _selectedDateRange.add(tappedDate);
        }
      } else if (_selectedDate.value == tappedDate) {
        // 이미 선택된 단일 날짜를 다시 탭하면 선택 해제
        _selectedDate.value = tappedDate;
        _selectedDateRange.clear();
      } else {
        // 새로운 날짜 선택
        _selectedDate.value = tappedDate;
        _selectedDateRange.clear();
        _selectedDateRange.add(tappedDate);
      }
    }
  }

  void onLongPress(CalendarLongPressDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      final longPressedDate = DateTime(details.date!.year, details.date!.month, details.date!.day);

      if (_selectedDate.value != null) {
        // 범위 선택
        final startDate = _selectedDate.value!;
        final endDate = longPressedDate;

        _selectedDateRange.clear();
        for (var date = startDate;
        date.isBefore(endDate.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
          _selectedDateRange.add(date);
        }
      } else {
        // 단일 날짜 선택 (길게 누르기)
        _selectedDate.value = longPressedDate;
        _selectedDateRange.clear();
        _selectedDateRange.add(longPressedDate);
      }
    }
  }

}

