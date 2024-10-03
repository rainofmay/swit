import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/usecases/create_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/delete_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/get_task_use_case.dart';
import 'package:swit/features/record/domain/usecases/update_task_use_case.dart';
import 'package:swit/shared/constant/theme_color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

class RecordViewModel extends GetxController {
  final GetTaskUseCase _getTaskUseCase;
  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  RecordViewModel({
    required GetTaskUseCase getTaskUseCase,
    required CreateTaskUseCase createTaskUseCase,
    required UpdateTaskUseCase updateTaskUseCase,
    required DeleteTaskUseCase deleteTaskUseCase,
  })  : _getTaskUseCase = getTaskUseCase,
        _createTaskUseCase = createTaskUseCase,
        _updateTaskUseCase = updateTaskUseCase,
        _deleteTaskUseCase = deleteTaskUseCase;

  /* ------------------------------------------------------ */
  /* Calendar Fields -------------------------------------- */
  /* ------------------------------------------------------ */
  late final Rx<DateTime> _selectedDate;
  DateTime get selectedDate => _selectedDate.value;
  late final Rx<DateTime> _focusedDate;
  DateTime get focusedDate => _focusedDate.value;

  late final Rx<CalendarFormat> _calendarFormat;
  CalendarFormat get calendarFormat => _calendarFormat.value;

  /* ------------------------------------------------------ */
  /* Task Fields ------------------------------------------ */
  /* ------------------------------------------------------ */
  late final RxList<Task> _tasks = <Task>[].obs;
  List<Task> get tasks => _tasks;

  late final Rx<Task> _editingTask = createInitTask().obs;
  Task get editingTask => _editingTask.value;

  late final Rx<TextEditingController> _taskTitleController = TextEditingController().obs;
  TextEditingController get taskTitleController => _taskTitleController.value;

  late final RxBool _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  // 디폴트 task 삭제 여부 확인 위함.
  static const String _defaultTaskKey = 'default_task_deleted_';

  /* ------------------------------------------------------ */
  /* Timer Widget Fields ---------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isRunning = false.obs;
  bool get isRunning => _isRunning.value;

  late final RxString _result = "00:00:00".obs;
  String get result => _result.value;

  late final RxList<int> _records = <int>[].obs;
  List<int> get records => _records;

  late final RxInt _sum = 0.obs;
  int get sum => _sum.value;

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  /* ------------------------------------------------------ */
  /* Record Task Fields ----------------------------------- */
  /* ------------------------------------------------------ */


  late final RxInt _totalDailyStudyTime = 0.obs;
  int get totalDailyStudyTime => _totalDailyStudyTime.value;

  String get formattedTotalDailyStudyTime => formatTime(_totalDailyStudyTime.value);

  // 현재 측정 중인 과제
  late final Rx<Task?> _recordingTask = Rx<Task?>(null);
  Task? get recordingTask => _recordingTask.value;

  // 현재 타이머 시간 저장
  late final RxString _currentTaskTime = "00:00:00".obs;
  String get currentTaskTime => _currentTaskTime.value;
  late final RxMap<String, Stopwatch> _taskStopwatches = <String, Stopwatch>{}.obs;
  Map<String, Stopwatch> get taskStopwatches => _taskStopwatches;

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
    _calendarFormat = CalendarFormat.month.obs;
  }

  @override
  void onClose() {
    _taskTitleController.value.dispose();
    _timer?.cancel();
    super.onClose();
  }

  /* ------------------------------------------------------ */
  /* Task functions --------------------------------------- */
  /* ------------------------------------------------------ */

  // 과제를 가져오는데, 없으면 디폴트과제 생성
  Future<void> _initializeTasks() async {
    await getTasks();
    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool(_defaultTaskKey) ?? false)) {
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
    final id = existingTask?.id ?? const Uuid().v4();
    final title = existingTask?.title ?? '';
    final color = existingTask?.color ?? ThemeColor.colorList[0];
    final isDefault = existingTask?.isDefault ?? false;
    return Task(
      id: id,
      title: title,
      color: color,
      isDefault: isDefault,
      dailyStudyTime: existingTask?.dailyStudyTime ?? 0,
    );
  }

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

  void checkFormValidity() {
    bool validity = _taskTitleController.value.text.isNotEmpty &&
        _taskTitleController.value.text.length <= 20;
    _isFormValid.value = validity;
  }

  void updateTaskTitle(String title) {
    _editingTask.update((val) {
      val?.title = title;
    });
  }

  void updateTaskColor(Color color) {
    _editingTask.update((val) {
      val?.color = color;
    });
  }

  // 수정 페이지로 진입할 때, 수정할 task 인식
  void updateEditingTask(Task? task) {
    _editingTask.value = createInitTask(existingTask: task);
    _taskTitleController.value.text = _editingTask.value.title;
  }

  Future<void> onUpdatePressed() async {
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

  /* ------------------------------------------------------ */
  /* Timer functions--------------------------------------- */
  /* ------------------------------------------------------ */
  void toggleTimer(String taskId) {
    if (_isRunning.value) {
      pauseTimer();
    } else {
      startTimer(taskId);
    }
  }

  void startTimer(String taskId) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    _recordingTask.value = task;
    _isRunning.value = true;

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _recordingTask.update((val) {
        if (val != null) {
          val = val.copyWith(dailyStudyTime: val.dailyStudyTime + 100);
        }
      });
      _updateTotalDailyStudyTime();
      update();
    });
  }

  void pauseTimer() {
    // _stopwatch.stop();
    _isRunning.value = false;
    _timer?.cancel();
  }

  void resetTimer() {
    _stopwatch.reset();
    _timer?.cancel();
    _result.value = "00:00:00";
    _isRunning.value = false;
  }

  void recordTime() {
    if (!_stopwatch.isRunning) {
      _records.add(_stopwatch.elapsedMilliseconds);
      _updateSum();
    }
  }

  void _updateSum() {
    _sum.value = _records.fold(0, (prev, curr) => prev + curr);
  }

  String formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }



  /* ------------------------------------------------------ */
  /* Record functions ------------------------------------- */
  /* ------------------------------------------------------ */

  void updateRecordingTask(Task? task) {
    _recordingTask.value = task;
  }

  void _updateTotalDailyStudyTime() {
    _totalDailyStudyTime.value = _tasks.fold(0, (sum, task) => sum + task.dailyStudyTime);
  }

  void startTaskTimer(String taskId) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    _recordingTask.value = task;

    if (!_taskStopwatches.containsKey(taskId)) {
      _taskStopwatches[taskId] = Stopwatch();
    }
    _taskStopwatches[taskId]!.start();
    _isRunning.value = true;

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      final elapsedMilliseconds = _taskStopwatches[taskId]!.elapsedMilliseconds;
      _currentTaskTime.value = formatTime(task.dailyStudyTime + elapsedMilliseconds);

      _recordingTask.update((val) {
        if (val != null) {
          val = val.copyWith(
              dailyStudyTime: val.dailyStudyTime + 100
          );
        }
      });
      _updateTotalDailyStudyTime();
      update();
    });
  }

  void pauseTaskTimer() {
    if (_recordingTask.value != null) {
      final taskId = _recordingTask.value!.id;
      if (_taskStopwatches.containsKey(taskId)) {
        _taskStopwatches[taskId]!.stop();
        _isRunning.value = false;
        _timer?.cancel();

        final elapsedMilliseconds = _taskStopwatches[taskId]!.elapsedMilliseconds;
        updateTaskTime(taskId, _recordingTask.value!.dailyStudyTime + elapsedMilliseconds);
        _recordingTask.value = null;
      }
    }
  }

  String getFormattedTaskTime(String taskId) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    return formatTime(task.dailyStudyTime);
  }

  void updateTaskTime(String taskId, int totalMilliseconds) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex] = _tasks[taskIndex].copyWith(dailyStudyTime: totalMilliseconds);
      _updateTotalDailyStudyTime();
      _updateTaskUseCase.execute(_tasks[taskIndex]);
      update();
    }
  }
}