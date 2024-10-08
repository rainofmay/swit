import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swit/core/utils/record/time_formatter.dart';
import 'package:swit/features/record/domain/entities/record_info.dart';
import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/usecases/task/create_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/task/delete_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/task/get_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/task/update_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/time_record/create_record_use_case.dart';
import 'package:swit/features/record/domain/usecases/time_record/delete_record_use_case.dart';
import 'package:swit/features/record/domain/usecases/time_record/get_record_use_case.dart';
import 'package:swit/features/record/domain/usecases/time_record/update_record_use_case.dart';
import 'package:swit/shared/constant/theme_color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

class RecordViewModel extends GetxController {
  final GetTaskUseCase _getTaskUseCase;
  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final GetRecordUseCase _getRecordsUseCase;
  final CreateRecordUseCase _createRecordUseCase;
  final UpdateRecordUseCase _updateRecordUseCase;
  final DeleteRecordUseCase _deleteRecordUseCase;

  RecordViewModel({
    required GetTaskUseCase getTaskUseCase,
    required CreateTaskUseCase createTaskUseCase,
    required UpdateTaskUseCase updateTaskUseCase,
    required DeleteTaskUseCase deleteTaskUseCase,
    required GetRecordUseCase getRecordsUseCase,
    required CreateRecordUseCase createRecordUseCase,
    required UpdateRecordUseCase updateRecordUseCase,
    required DeleteRecordUseCase deleteRecordUseCase,

  })  : _getTaskUseCase = getTaskUseCase,
        _createTaskUseCase = createTaskUseCase,
        _updateTaskUseCase = updateTaskUseCase,
        _deleteTaskUseCase = deleteTaskUseCase,
        _getRecordsUseCase = getRecordsUseCase,
        _createRecordUseCase = createRecordUseCase,
        _updateRecordUseCase = updateRecordUseCase,
        _deleteRecordUseCase = deleteRecordUseCase;

  /* ------------------------------------------------------ */
  /* Calendar Fields -------------------------------------- */
  /* ------------------------------------------------------ */
  late final Rx<DateTime> _selectedDate;
  DateTime get selectedDate => _selectedDate.value;
  late final Rx<DateTime> _focusedDate;
  DateTime get focusedDate => _focusedDate.value;

  late final Rx<CalendarFormat> _calendarFormat = CalendarFormat.week.obs;
  CalendarFormat get calendarFormat => _calendarFormat.value;

  /* ------------------------------------------------------ */
  /* Task Fields ------------------------------------------ */
  /* ------------------------------------------------------ */
  late final RxList<Task> _tasks = <Task>[].obs;
  List<Task> get tasks => _tasks;

  late final Rx<Task> _editingTask = _createInitTask().obs;
  Task get editingTask => _editingTask.value;

  late final Rx<TextEditingController> _taskTitleController = TextEditingController().obs;
  TextEditingController get taskTitleController => _taskTitleController.value;

  late final RxBool _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  // 디폴트 task 삭제 여부 확인 위함.
  static const String _defaultTaskKey = 'default_task_deleted_';

  /* ------------------------------------------------------ */
  /* StopWatch Fields ------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isRunning = false.obs;
  bool get isRunning => _isRunning.value;

  late final RxString _result = "00:00:00".obs;
  String get result => _result.value;

  late final RxInt _sum = 0.obs;
  int get sum => _sum.value;

  Timer? _timer;

  /* ------------------------------------------------------ */
  /* Record Task Fields ----------------------------------- */
  /* ------------------------------------------------------ */
  late final RxInt _totalDailyStudyTime = 0.obs;
  int get totalDailyStudyTime => _totalDailyStudyTime.value;

  String get formattedTotalDailyStudyTime => TimeFormatter.formatTime(_totalDailyStudyTime.value);

  // 현재 측정 중인 과제
  late final Rx<Task?> _recordingTask = Rx<Task?>(null);
  Task? get recordingTask => _recordingTask.value;

  // 각 과제별 누적 시간을 저장할 맵 추가 (String은 task_id, int는 시간)
  late final RxMap<String, int> _taskAccumulatedTimes = <String, int>{}.obs;

  // 현재 타이머 시간 저장
  late final RxString _currentTaskTime = "00:00:00".obs;
  String get currentTaskTime => _currentTaskTime.value;
  late final RxMap<String, Stopwatch> _taskStopwatches = <String, Stopwatch>{}.obs;
  Map<String, Stopwatch> get taskStopwatches => _taskStopwatches;

  // 기록 가져오기
  final RxList<RecordInfo> _records = <RecordInfo>[].obs;
  List<RecordInfo> get records => _records;

  final RxList<RecordInfo> _selectedDateRecords = <RecordInfo>[].obs;
  List<RecordInfo> get selectedDateRecords => _selectedDateRecords;

  /* ------------------------------------------------------ */
  /* Study log card Fields -------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isEditing = false.obs;
  bool get isEditing => _isEditing.value;
  late final Rx<TextEditingController> _contentsController = TextEditingController().obs;
  TextEditingController get contentsController => _contentsController.value;

  /* ------------------------------------------------------ */
  /* Init & Dispose --------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();
    _initializeTasks();
    _taskTitleController.value.addListener(() {
      checkFormValidity();
    });
    _selectedDate = DateTime.now().obs;
    _focusedDate = DateTime.now().obs;
    getRecords();
  }

  @override
  void onClose() {
    _taskTitleController.value.dispose();
    _timer?.cancel();
    super.onClose();

    // study log card
    _contentsController.value.dispose();
  }

  /* ------------------------------------------------------ */
  /* Calendar Functions ----------------------------------- */
  /* ------------------------------------------------------ */
  void updateSelectedDate(DateTime selectedDate) {
    _selectedDate.value = selectedDate;
    _filterRecordsByDate(selectedDate);
  }

  void updateFocusedDate(DateTime focusedDate) {
    _focusedDate.value = focusedDate;
  }

  // List<Event> getEvents(DateTime day) {
  //   return _schedules.where((schedule) {
  //     DateTime scheduleStart = DateTime(schedule.from.year, schedule.from.month, schedule.from.day);
  //     DateTime scheduleEnd = DateTime(schedule.to.year, schedule.to.month, schedule.to.day);
  //     DateTime dayStart = DateTime(day.year, day.month, day.day);
  //
  //     return !scheduleEnd.isBefore(dayStart) && !scheduleStart.isAfter(dayStart);
  //   }).map((schedule) => Event(schedule.id)).toList();
  // }
  //
  // Map<String, Color> getEventsColor(DateTime day) {
  //   Map<String, Color> idColorData = {};
  //   List data = initEvents(day);
  //
  //   for (int i = 0; i < data.length; i++) {
  //     idColorData.addAll({data[i][2]: data[i][3]});
  //   }
  //
  //   return idColorData;
  // }


  /* ------------------------------------------------------ */
  /* Task functions --------------------------------------- */
  /* ------------------------------------------------------ */

  // 과제를 가져오는데, 없으면 디폴트 과제 생성
  Future<void> _initializeTasks() async {
    await getTasks();
    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool(_defaultTaskKey) ?? false) && _tasks.isEmpty) {
      await _createDefaultTaskForFirstTime();
    }
  }

  Future<void> _createDefaultTaskForFirstTime() async {
    final defaultTask = Task(
      id: const Uuid().v4(),
      title: '스터디',
      color: ThemeColor.colorList[0],
      isDefault: true,
    );
    await _createTaskUseCase.execute(defaultTask);
    await getTasks();
  }

  Task _createInitTask({Task? existingTask}) {
    return Task(
      id: existingTask?.id ?? const Uuid().v4(),
      title: existingTask?.title ?? '',
      color: existingTask?.color ?? ThemeColor.colorList[0],
      isDefault: existingTask?.isDefault ?? false,
      dailyStudyTime: existingTask?.dailyStudyTime ?? 0,
    );
  }

  // Task 새로 생성하는 함수
  Future<void> onSavePressed() async {
    if (isFormValid) {
      final taskToSave = Task(
        id: _editingTask.value.id,
        title: _taskTitleController.value.text,
        color: _editingTask.value.color,
        isDefault: _editingTask.value.isDefault,
        dailyStudyTime: _editingTask.value.dailyStudyTime,
      );
      await _createTaskUseCase.execute(taskToSave);
      await getTasks();  // 저장 후 목록 새로고침

      // text controller 초기화하기
      _taskTitleController.value.text = '';
      update();
    }
  }

  Future<void> getTasks() async {
    try {
      final List<Task> data = await _getTaskUseCase.execute();
      _tasks.assignAll(data);
      _updateTotalDailyStudyTime();

      update();
    } catch(e) {
      print('Record ViewModel get task Error $e');
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _deleteTaskUseCase.execute(task);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_defaultTaskKey, true);

      await getTasks();
      update();
    } catch (e) {
      print('Record ViewModel delete task Error $e');
    }
  }

  void updateTaskTitle(String title) {
    _editingTask.update((val) {
      if (val != null) {
        val = val.copyWith(title: title);
        _isFormValid.value = val.isTitleValid();
      }
    });
  }

  void updateTaskColor(Color color) {
    _editingTask.update((val) {
      if (val != null) {
        val = val.copyWith(color: color);
      }
    });
  }

  // 수정 페이지로 진입할 때, 수정할 task 인식
  void updateEditingTask(Task? task) {
    _editingTask.value = _createInitTask(existingTask: task);
    _taskTitleController.value.text = _editingTask.value.title;
  }

  Future<void> updateTask() async {
    if (isFormValid) {
      try {
        await _updateTaskUseCase.execute(_editingTask.value);
        await getTasks();
      } catch (e) {
        print('ViewModel failed to update task: $e');
      }
    } else {
      print('ViewModel task Form is not valid');
    }
  }

  void checkFormValidity() {
    _isFormValid.value = _editingTask.value.isTitleValid();
  }

  /* ------------------------------------------------------ */
  /* Record functions ------------------------------------- */
  /* ------------------------------------------------------ */

  void updateRecordingTask(Task? task) {
    _recordingTask.value = task;
    if (task != null) {
      _currentTaskTime.value = getFormattedTaskTime(task.id);
    } else {
      _currentTaskTime.value = "00:00:00";
    }
  }

  void _updateTotalDailyStudyTime() {
    // fold : 컬렉션의 모든 요소를 순회하면서 합산함.
    _totalDailyStudyTime.value = _tasks.fold(0, (sum, task) => sum + task.dailyStudyTime);
    update();
  }

  void startTaskStopWatch(String taskId) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    _recordingTask.value = task;

    if (!_taskStopwatches.containsKey(taskId)) {
      _taskStopwatches[taskId] = Stopwatch();
    }

    // 이전에 누적된 시간 가져오기 (새로운 맵 사용)
    final previousAccumulatedTime = _taskAccumulatedTimes[taskId] ?? 0;

    // Stopwatch 시작
    _taskStopwatches[taskId]!.start();
    _isRunning.value = true;

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final elapsedMilliseconds = _taskStopwatches[taskId]!.elapsedMilliseconds;
      final totalTime = previousAccumulatedTime + elapsedMilliseconds;

      // currentTaskTime 업데이트
      _currentTaskTime.value = TimeFormatter.formatTime(totalTime);

      // recordingTask 업데이트 (UI 반영을 위해)
      _recordingTask.update((val) {
        if (val != null) {
          val = val.copyWith(dailyStudyTime: totalTime);
        }
      });

      // 전체 일일 학습 시간 업데이트
      _updateTotalDailyStudyTime();

      update();
    });

    print('Task started. Previous accumulated time: ${TimeFormatter.formatTime(previousAccumulatedTime)}');
  }

  Future<void> pauseTaskStopWatch() async {
    if (_recordingTask.value != null) {
      final taskId = _recordingTask.value!.id;
      if (_taskStopwatches.containsKey(taskId)) {
        // 스톱워치 정지
        _taskStopwatches[taskId]!.stop();
        _isRunning.value = false;
        _timer?.cancel();

        // 경과 시간 계산
        final elapsedMilliseconds = _taskStopwatches[taskId]!.elapsedMilliseconds;

        // 누적 시간 업데이트 (새로운 맵 사용)
        final previousAccumulatedTime = _taskAccumulatedTimes[taskId] ?? 0;
        final updatedAccumulatedTime = previousAccumulatedTime + elapsedMilliseconds;
        _taskAccumulatedTimes[taskId] = updatedAccumulatedTime;

        // Task 객체 업데이트
        updateTaskTime(taskId, updatedAccumulatedTime);

        // currentTaskTime(00:00:00 형태의 String값) 업데이트
        _currentTaskTime.value = TimeFormatter.formatTime(updatedAccumulatedTime);

        // 스톱워치 리셋
        _taskStopwatches[taskId]!.reset();

        await createRecord();

        // recordingTask 초기화
        _recordingTask.value = null;

        print('Task paused. Total time: ${TimeFormatter.formatTime(updatedAccumulatedTime)}');
      }
    }
  }

  // 공부 기록들 가져오기
  Future<void> getRecords() async {
    try {
      final fetchedRecords = await _getRecordsUseCase.execute();
      _records.assignAll(fetchedRecords);
      _filterRecordsByDate(_selectedDate.value);
    } catch (e) {
      print('ViewModel Failed to get records: $e');
    }
  }

  // 측정한 기록을 db와 공부 일지에 생성
  Future<void> createRecord() async {
    if (_recordingTask.value != null && _taskAccumulatedTimes[_recordingTask.value!.id] != null) {
      final recordTime = RecordInfo(
        id: const Uuid().v4(),  // 새로운 고유 ID 생성
        title: _recordingTask.value!.title,
        taskId: _recordingTask.value!.id,
        recordTime: _taskAccumulatedTimes[_recordingTask.value!.id]!,
        contents: '',
        date: DateTime.now().toUtc().toString().substring(0, 10),
      );

      try {
        await _createRecordUseCase.execute(recordTime);
        await getRecords();
        // UI 업데이트
        update();
        print('View model Record created successfully');
      } catch (e) {
        print('View model Failed to create record: $e');
      }
    } else {
      print('View model Recording task or accumulated time is null');
    }
  }

  void toggleEditing() {
    _isEditing.toggle();
  }

  void updateContent(String newContent) {
    _contentsController.value.text = newContent;
  }


  Future<void> updateRecord(String id, String newContents) async {
    try {
      await _updateRecordUseCase.execute(id, newContents);

      // 저장 후 편집 모드 종료
      _isEditing.value = false;

      // 기록 목록 새로고침
      await getRecords();
    } catch (e) {
      print('Failed to save record: $e');
    }
  }

  Future<void> deleteRecord(String id) async {
    try {
      await _deleteRecordUseCase.execute(id);
      await getRecords();  // 삭제 후 목록 새로고침
      update();
    } catch (e) {
      print('ViewModel Failed to delete record: $e');
    }
  }

  String getFormattedTaskTime(String taskId) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    return task.getFormattedTaskTime();
  }

  void updateTaskTime(String taskId, int totalMilliseconds) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);

    // 찾은 인덱스가 유효할 경우, 해당 과제 업데이트
    if (taskIndex != -1) {
      _tasks[taskIndex] = _tasks[taskIndex].copyWith(dailyStudyTime: totalMilliseconds);
      _updateTotalDailyStudyTime();
      _updateTaskUseCase.execute(_tasks[taskIndex]);
      update();
    }
  }

  void _filterRecordsByDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    _selectedDateRecords.value = _records.where((record) => record.date == formattedDate).toList();
    update();
  }
}