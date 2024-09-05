import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/utils/schedule_service.dart';
import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:swit/features/study/schedule/domain/usecases/create_schedule_use_case.dart';
import 'package:swit/features/study/schedule/domain/usecases/get_schedule_use_case.dart';
import 'package:swit/shared/constant/schedule_color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleViewModel extends GetxController {
  final GetScheduleUseCase _getScheduleUseCase;
  final CreateScheduleUseCase _createScheduleUseCase;

  ScheduleViewModel({
    required GetScheduleUseCase getScheduleUseCase,
    required CreateScheduleUseCase createScheduleUseCase,
  })  : _getScheduleUseCase = getScheduleUseCase,
        _createScheduleUseCase = createScheduleUseCase;

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
  late final Rx<Schedule> _editingSchedule = createInitSchedule().obs;
  Schedule get editingSchedule => _editingSchedule.value;
  late final Schedule storedSchedule;

  late final Rx<TextEditingController> _titleController = TextEditingController().obs;
  TextEditingController get titleController => _titleController.value;
  late final Rx<TextEditingController> _descriptionController = TextEditingController().obs;
  TextEditingController get descriptionController => _descriptionController.value;

  late final RxBool _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  @override
  void onInit() {
    // 테스트 코드
    getSchedules();
    // schedules.addAll([
    //   Schedule(
    //       scheduleName: 'Meeting',
    //       from: DateTime.now(),
    //       description: 'memo',
    //       to: DateTime.now().add(Duration(hours: 9)),
    //       sectionColor: Colors.green,
    //       isTimeSet: false),
    //   Schedule(
    //       scheduleName: 'Test',
    //       from: DateTime.now(),
    //       to: DateTime.now().add(Duration(days: 1)),
    //       sectionColor: Colors.blue,
    //       isTimeSet: false),
    // ]);

    super.onInit();
  }

  @override
  void onClose() {
    _controller.value.dispose();
    _titleController.value.dispose();
    _descriptionController.value.dispose();
    super.onClose();
  }

  /* -- Init -- */
  Schedule createInitSchedule() {
    final now = DateTime.now();
    DateTime initialStartDate;
    DateTime initialEndDate;
    final selectedDate = _selectedDate.value ?? now;
    if (now.hour >= 22) {
      // 22시 이후라면 선택된 날짜의 00:00부터 02:00까지로 설정
      initialStartDate = DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, 22, 0);
      initialEndDate = DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, 23, 0);
    } else {
      // 그 외의 경우 현재 시간부터 2시간 후로 설정
      initialStartDate = DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, now.hour, 0);
      initialEndDate = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, now.hour + 2, 0);
    }

    return Schedule(
      // id: Uuid().v4(),
      // uid: Uuid().v4(),
      scheduleName: '',
      from: initialStartDate,
      to: initialEndDate,
      isTimeSet: false,
      description: '',
      sectionColor: ScheduleColor.colorList[0],
    );
  }

  /* -- Create -- */
  void onSavePressed() async {
    if (isFormValid) {
      storedSchedule = _editingSchedule.value;
      await _createScheduleUseCase.createSchedule(storedSchedule);
      // 저장 로직 구현
    }
  }

  /* -- Get -- */
  void getSchedules() async {
    _schedules.value = await _getScheduleUseCase.getSchedules();
  }


  /* -- Update -- */
  void updateScheduleName(String name) {
    _editingSchedule.update((val) {
      val?.scheduleName = name;
    });
  }

  void updateScheduleFrom(DateTime from) {
    _editingSchedule.update((val) {
      val?.from = from;
    });
  }

  void updateScheduleTo(DateTime to) {
    _editingSchedule.update((val) {
      val?.to = to;
    });
  }

  void updateScheduleIsTimeSet(bool isTimeSet) {
    _editingSchedule.update((val) {
      val?.isTimeSet = isTimeSet;
    });
  }

  void updateScheduleDescription(String description) {
    _editingSchedule.update((val) {
      val?.description = description;
    });
  }

  void updateScheduleColor(Color color) {
    _editingSchedule.update((val) {
      val?.sectionColor = color;
    });
  }

  /* -- Client Functions -- */
  void onTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      final tappedDate =
          DateTime(details.date!.year, details.date!.month, details.date!.day);

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
      final longPressedDate =
          DateTime(details.date!.year, details.date!.month, details.date!.day);

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

  /* -- TextForm Validity -- */
  void checkFormValidity() {
    bool validity = _titleController().text.isNotEmpty &&
        _titleController().text.length <= 60;
    _isFormValid.value = validity;
  }
}
