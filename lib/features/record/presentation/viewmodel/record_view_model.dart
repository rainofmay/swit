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
import 'package:swit/shared/constant/color_box.dart';
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
  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  final Rx<DateTime> _focusedDate = DateTime.now().obs;
  DateTime get focusedDate => _focusedDate.value;

  final Rx<CalendarFormat> _calendarFormat = CalendarFormat.week.obs;
  CalendarFormat get calendarFormat => _calendarFormat.value;

  final RxMap<String, int> _heatmapData = <String, int>{}.obs;
  Map<String, int> get heatmapData => _heatmapData;

  /* ------------------------------------------------------ */
  /* Task Fields ------------------------------------------ */
  /* ------------------------------------------------------ */
  late final RxList<Task> _tasks = <Task>[].obs;
  List<Task> get tasks => _tasks;

  late final Rx<Task> _editingTask = createInitTask().obs;
  Task get editingTask => _editingTask.value;

  late final Rx<TextEditingController> _taskTitleController = TextEditingController().obs;
  TextEditingController get taskTitleController => _taskTitleController.value;

  final RxBool _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  // 디폴트 task 삭제 여부 확인 위함.
  static const String _defaultTaskKey = 'default_task_deleted_';

  /* ------------------------------------------------------ */
  /* StopWatch Fields ------------------------------------- */
  /* ------------------------------------------------------ */
  final RxBool _isRunning = false.obs;
  bool get isRunning => _isRunning.value;

  Timer? _timer;

  /* ------------------------------------------------------ */
  /* Record Task Fields ----------------------------------- */
  /* ------------------------------------------------------ */

  // 오늘, 선택된 과제별 공부 시간(누적)
  final RxMap<String, int> _todayStudyTimes = <String, int>{}.obs;
  Map<String, int> get todayStudyTimes => _todayStudyTimes;

  // 오늘 총 공부시간
  int get totalDailyStudyTime => _todayStudyTimes.values.fold(0, (sum, time) => sum + time);
  String get formattedTotalDailyStudyTime => TimeFormatter.formatTime(totalDailyStudyTime);

  // 현재 측정 중인 과제
  late final Rx<Task?> _recordingTask = Rx<Task?>(null);
  Task? get recordingTask => _recordingTask.value;

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
  /* Life cycle field ------------------------------------- */
  /* ------------------------------------------------------ */
  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    _taskTitleController.value.addListener(() {
      checkFormValidity();
    });

    _initializeData();
  }

  Future<void> _initializeData() async {
    _isLoading.value = true;
    await _initializeTasks();
    await getRecords();
    updateHeatmapData();
    _isLoading.value = false;
  }

  @override
  void onClose() {
    _taskTitleController.value.dispose();
    _timer?.cancel();
    super.onClose();

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

  void updateHeatmapData() {
    _heatmapData.clear();
    for (var record in _records) {
      final date = DateTime.parse(record.date);
      final formattedDateString = DateFormat('yyyy-MM-dd').format(date);

      final existingTime = _heatmapData[formattedDateString] ?? 0;
      _heatmapData[formattedDateString] = existingTime + record.recordTime;
    }
  }

  Color getHeatmapColor(int studyTimeInMilliseconds) {
    if (studyTimeInMilliseconds == 0) return ColorBox.white;

    // 밀리초 단위의 공부 시간을 분 단위로 변환
    final studyTimeInMinutes = studyTimeInMilliseconds ~/ 60000;
    if (studyTimeInMinutes < 15) return ColorBox.green.withOpacity(0.25);
    if (studyTimeInMinutes < 30) return ColorBox.green.withOpacity(0.5);
    if (studyTimeInMinutes < 60) return ColorBox.green.withOpacity(0.75);
    return ColorBox.green;
  }

  void updateCalendarFormatToWeek() {
    _calendarFormat.value = CalendarFormat.week;
  }

  void updateCalendarFormatToMonth() {
    _calendarFormat.value = CalendarFormat.month;
  }

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

  Task createInitTask({Task? existingTask}) {
    return Task(
      id: existingTask?.id ?? const Uuid().v4(),
      title: existingTask?.title ?? '',
      color: existingTask?.color ?? ThemeColor.colorList[0],
      isDefault: existingTask?.isDefault ?? false,
      dailyStudyTime: existingTask?.dailyStudyTime ?? 0,
    );
  }

  void resetTaskForm() {
    _taskTitleController.value.text = '';
    _editingTask.value = createInitTask();
    checkFormValidity();
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
    final updatedTask = _editingTask.value.copyWith(color: color);
    _editingTask.value = updatedTask;
  }

  // 수정 페이지로 진입할 때, 수정할 task 인식
  void updateEditingTask(Task? task) {
    _editingTask.value = createInitTask(existingTask: task);
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

  void startTaskStopWatch(String taskId) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    _recordingTask.value = task;

    if (!_taskStopwatches.containsKey(taskId)) {
      _taskStopwatches[taskId] = Stopwatch();
    }

    final previousAccumulatedTime = _todayStudyTimes[taskId] ?? 0;

    _taskStopwatches[taskId]!.start();
    _isRunning.value = true;

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final elapsedMilliseconds = _taskStopwatches[taskId]!.elapsedMilliseconds;
      final totalTime = previousAccumulatedTime + elapsedMilliseconds;

      _currentTaskTime.value = TimeFormatter.formatTime(totalTime);

      // 여기서는 _todayStudyTimes를 업데이트하지 않음

      update();
    });
  }

  Future<void> pauseTaskStopWatch() async {
    if (_recordingTask.value != null) {
      final taskId = _recordingTask.value!.id;
      if (_taskStopwatches.containsKey(taskId)) {
        _taskStopwatches[taskId]!.stop();
        _isRunning.value = false;
        _timer?.cancel();

        final elapsedMilliseconds = _taskStopwatches[taskId]!.elapsedMilliseconds;
        final previousAccumulatedTime = _todayStudyTimes[taskId] ?? 0;
        final updatedAccumulatedTime = previousAccumulatedTime + elapsedMilliseconds;

        _todayStudyTimes[taskId] = updatedAccumulatedTime;
        _currentTaskTime.value = TimeFormatter.formatTime(updatedAccumulatedTime);

        _taskStopwatches[taskId]!.reset();

        await createRecord();
        await getRecords();  // 데이터 새로고침
        _filterRecordsByDate(DateTime.now());  // 오늘 날짜로 필터링
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
      updateHeatmapData();  // 히트맵 데이터 업데이트
    } catch (e) {
      print('ViewModel Failed to get records: $e');
    }
  }

  // 날짜별로 누적 공부 시간을 가져오도록 필터링
  void _filterRecordsByDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    _selectedDateRecords.value = _records.where((record) => record.date == formattedDate).toList();

    _todayStudyTimes.clear();
    for (var record in _selectedDateRecords) {
      _todayStudyTimes[record.taskId] = (_todayStudyTimes[record.taskId] ?? 0) + record.recordTime;
    }

    update();
  }

  // 측정한 기록을 db와 공부 일지에 생성
  Future<void> createRecord() async {
    if (_recordingTask.value != null) {
      final taskId = _recordingTask.value!.id;
      final studyTime = _todayStudyTimes[taskId] ?? 0;

      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final recordTime = RecordInfo(
        id: const Uuid().v4(),
        taskId: taskId,
        title: _recordingTask.value!.title,
        recordTime: studyTime,
        contents: '',
        date: today,
      );

      try {
        await _createRecordUseCase.execute(recordTime);
        await getRecords();
        _filterRecordsByDate(DateTime.now());  // 오늘 날짜로 필터링
        update();
        print('View model Record created successfully');
      } catch (e) {
        print('View model Failed to create record: $e');
      }
    } else {
      print('View model Recording task is null');
    }
  }

  Future<void> updateRecord(String id, String newContents) async {
    try {
      await _updateRecordUseCase.execute(id, newContents);

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
    final studyTime = _todayStudyTimes[taskId] ?? 0;
    return TimeFormatter.formatTime(studyTime);
  }

  void updateTaskTime(String taskId, int totalMilliseconds) {
    _todayStudyTimes[taskId] = totalMilliseconds;
    update();
  }

}