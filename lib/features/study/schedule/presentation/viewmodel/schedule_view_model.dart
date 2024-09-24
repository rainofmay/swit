import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/core/utils/schedule/schedule_service.dart';
import 'package:swit/features/study/schedule/domain/entities/event.dart';
import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:swit/features/study/schedule/domain/usecases/create_schedule_use_case.dart';
import 'package:swit/features/study/schedule/domain/usecases/delete_schedule_use_case.dart';
import 'package:swit/features/study/schedule/domain/usecases/get_schedule_use_case.dart';
import 'package:swit/features/study/schedule/domain/usecases/update_schedule_use_case.dart';
import 'package:swit/shared/constant/schedule_color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

class ScheduleViewModel extends GetxController {
  final GetScheduleUseCase _getScheduleUseCase;
  final CreateScheduleUseCase _createScheduleUseCase;
  final UpdateScheduleUseCase _updateScheduleUseCase;
  final DeleteScheduleUseCase _deleteScheduleUseCase;
  ScheduleViewModel({
    required GetScheduleUseCase getScheduleUseCase,
    required CreateScheduleUseCase createScheduleUseCase,
    required UpdateScheduleUseCase updateScheduleUseCase,
    required DeleteScheduleUseCase deleteScheduleUseCase,
  })  : _getScheduleUseCase = getScheduleUseCase,
        _createScheduleUseCase = createScheduleUseCase,
        _updateScheduleUseCase = updateScheduleUseCase,
        _deleteScheduleUseCase = deleteScheduleUseCase;

  /* ------------------------------------------------------ */
  /* Calendar --------------------------------------------- */
  /* ------------------------------------------------------ */

  late final Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  late final Rx<DateTime> _focusedDate = DateTime.now().obs;
  DateTime get focusedDate => _focusedDate.value;

  final Rx<CalendarFormat> _calendarFormat = CalendarFormat.month.obs;
  CalendarFormat get calendarFormat => _calendarFormat.value;
  final RxList<DateTime> _selectedDateRange = <DateTime>[].obs;
  List<DateTime> get selectedDateRange => _selectedDateRange;

  late final RxList<Schedule> _schedules = <Schedule>[].obs;
  List<Schedule> get schedules => _schedules;
  final RxList<Schedule> _selectedDateSchedules = <Schedule>[].obs;
  List get selectedDateSchedules => _selectedDateSchedules;


  /* ------------------------------------------------------ */
  /* Schedule --------------------------------------------- */
  /* ------------------------------------------------------ */

  late final RxBool _isSchedulesLoaded = false.obs;
  bool get isSchedulesLoaded => _isSchedulesLoaded.value;

  late final Rx<Schedule> _editingSchedule = createInitSchedule().obs;
  Schedule get editingSchedule => _editingSchedule.value;
  late Schedule storedSchedule;

  late final Rx<TextEditingController> _titleController = TextEditingController().obs;
  TextEditingController get titleController => _titleController.value;
  late final Rx<TextEditingController> _descriptionController = TextEditingController().obs;
  TextEditingController get descriptionController => _descriptionController.value;

  late final RxBool _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  @override
  void onInit() {
    super.onInit();
    getSchedules().then((onValue) => updateSelectedDate(_selectedDate.value));

    print('schedules $schedules');

  }

  @override
  void onClose() {
    _titleController.value.dispose();
    _descriptionController.value.dispose();
    super.onClose();
  }


  /* ------------------------------------------------------ */
  /* Init ------------------------------------------------- */
  /* ------------------------------------------------------ */


  Schedule createInitSchedule({Schedule? existingSchedule}) {
    final now = DateTime.now();
    DateTime initialStartDate;
    DateTime initialEndDate;
    final selectedDate = existingSchedule?.from ?? _selectedDate.value ?? now;

    if (now.hour >= 22) {
      initialStartDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 22, 0);
      initialEndDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 0);
    } else {
      initialStartDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, now.hour, 0);
      initialEndDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, now.hour + 2, 0);
    }

    return Schedule(
      // 새 일정이면 빈 데이터, 기존 일정이면 해당 데이터
      id : existingSchedule?.id ?? const Uuid().v4(),
      scheduleName: existingSchedule?.scheduleName ?? '',
      from: existingSchedule?.from ?? initialStartDate,
      to: existingSchedule?.to ?? initialEndDate,
      isAllDay: existingSchedule?.isAllDay ?? false,
      description: existingSchedule?.description ?? '',
      sectionColor: existingSchedule?.sectionColor ?? ScheduleColor.colorList[0],
    );
  }

  void initNewSchedule() {
    _editingSchedule.value = createInitSchedule();
    _titleController.value.text = '';
    _descriptionController.value.text = '';
    // 다른 필드들도 초기화
  }

  /* ------------------------------------------------------ */
  /* Create ----------------------------------------------- */
  /* ------------------------------------------------------ */
  Future<void> onSavePressed() async {
    if (isFormValid) {
      storedSchedule = _editingSchedule.value;
      await _createScheduleUseCase.execute(storedSchedule);
      await getSchedules();
      initNewSchedule();
      updateSelectedDateSchedules();
      update();
    }
  }

  /* ------------------------------------------------------ */
  /* Get -------------------------------------------------- */
  /* ------------------------------------------------------ */

  /* -- Schedule -- */
  Future<void> getSchedules() async {
    try {
      _isSchedulesLoaded.value = false;
      final List<Schedule> data = await _getScheduleUseCase.execute();
      _schedules.assignAll(data);
      _isSchedulesLoaded.value = true;
      update();
      print('Schedules after mapping: ${_schedules}');
    } catch(e) {
      _isSchedulesLoaded.value = false;
    }
  }

  /* -- Events -- */
  List<dynamic> initEvents(DateTime day) {
    return _schedules.where((schedule) {
      DateTime scheduleStart = DateTime(schedule.from.year, schedule.from.month, schedule.from.day);
      DateTime scheduleEnd = DateTime(schedule.to.year, schedule.to.month, schedule.to.day);
      DateTime dayStart = DateTime(day.year, day.month, day.day);

      return !scheduleEnd.isBefore(dayStart) && !scheduleStart.isAfter(dayStart);
    }).map((schedule) => [
      schedule.from,
      schedule.to,
      schedule.id,
      schedule.sectionColor,
    ]).toList();
  }

  List<Event> getEvents(DateTime day) {
    return _schedules.where((schedule) {
      DateTime scheduleStart = DateTime(schedule.from.year, schedule.from.month, schedule.from.day);
      DateTime scheduleEnd = DateTime(schedule.to.year, schedule.to.month, schedule.to.day);
      DateTime dayStart = DateTime(day.year, day.month, day.day);

      return !scheduleEnd.isBefore(dayStart) && !scheduleStart.isAfter(dayStart);
    }).map((schedule) => Event(schedule.id)).toList();
  }

  Map<String, Color> getEventsColor(DateTime day) {
    Map<String, Color> idColorData = {};
    List data = initEvents(day);

    for (int i = 0; i < data.length; i++) {
      idColorData.addAll({data[i][2]: data[i][3]});
    }
    print('idColorData $idColorData');
    return idColorData;
  }


  /* ------------------------------------------------------ */
  /* Update ----------------------------------------------- */
  /* ------------------------------------------------------ */

  /* -- Calendar -- */
  void updateSelectedDate(DateTime selectedDate) {
    _selectedDate.value = selectedDate;

    initNewSchedule(); // 일정 생성 시, 선택된 날짜를 초기값으로 하기 위함
    updateSelectedDateSchedules(); // 선택된 날짜 일정을 불러옴
  }

  void updateFocusedDate(DateTime focusedDate) {
    _focusedDate.value = focusedDate;
  }

  /* -- Schedule -- */
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

  void updateScheduleIsAllDay(bool isAllDay) {
    _editingSchedule.update((val) {
      val?.isAllDay = isAllDay;
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

  void updateEditingSchedule(Schedule? schedule) {
    _editingSchedule.value = createInitSchedule(existingSchedule: schedule);
    _titleController.value.text = _editingSchedule.value.scheduleName;
    _descriptionController.value.text = _editingSchedule.value.description;
    // 필요한 다른 필드들도 여기서 설정
  }

  Future<void> onUpdatePressed() async {
    if (isFormValid) {
      try {
        _editingSchedule.update((val) {
          val?.scheduleName = _titleController.value.text;
          val?.description = _descriptionController.value.text;
        });
        storedSchedule = _editingSchedule.value;
        await _updateScheduleUseCase.execute(storedSchedule);
        await getSchedules();
        initNewSchedule();
        updateSelectedDateSchedules();
      } catch (e) {
        print('ViewModel failed to update schedule: $e');
      }
    } else {
      print('Form is not valid');
    }
  }

  void updateSelectedDateSchedules() {
    // 선택된 날짜에 해당하는 일정들을 필터링
    _selectedDateSchedules.value = _schedules
        .where((schedule) =>
    (schedule.from.year <= _selectedDate.value.year &&
        schedule.from.month <= _selectedDate.value.month &&
        schedule.from.day <= _selectedDate.value.day) &&
        (schedule.to.year >= _selectedDate.value.year &&
            schedule.to.month >= _selectedDate.value.month &&
            schedule.to.day >= _selectedDate.value.day))
        .toList();
    update();
  }

  /* ------------------------------------------------------ */
  /* Delete ----------------------------------------------- */
  /* ------------------------------------------------------ */

  Future<void> deleteSchedule() async {
    try {
      storedSchedule = _editingSchedule.value;
      _deleteScheduleUseCase.execute(storedSchedule);
      await getSchedules();
      updateSelectedDateSchedules();
    } catch (e) {
      print('Failed to delete schedule: $e');
    }
  }

  /* ------------------------------------------------------ */
  /* TextForm Validity ------------------------------------ */
  /* ------------------------------------------------------ */
  void checkFormValidity() {
    bool validity = _titleController().text.isNotEmpty &&
        _titleController().text.length <= 60;
    _isFormValid.value = validity;
  }
}
