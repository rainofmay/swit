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
  /* Record Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isRunning = false.obs;
  bool get isRunning => _isRunning.value;

  late final RxString _result = "00:00:00".obs;
  String get result => _result.value;

  late final RxList<int> _records = <int>[].obs;
  List<int> get records => _records;

  late final RxInt _sum = 0.obs;
  int get sum => _sum.value;

  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

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
    final defaultTaskDeleted = prefs.getBool(_defaultTaskKey) ?? false;

    if (!defaultTaskDeleted) {
      print('defaultTaskDeleted $defaultTaskDeleted');
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
    );
  }

  Future<void> onSavePressed() async {
    if (isFormValid) {
      final taskToSave = Task(
        id: _editingTask.value.id,
        title: _taskTitleController.value.text,
        color: _editingTask.value.color,
        isDefault: _editingTask.value.isDefault,
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
      final List<Task> data = await  _getTaskUseCase.execute();
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
  /* Record functions-------------------------------------- */
  /* ------------------------------------------------------ */
  void toggleTimer() {
    if (_isRunning.value) {
      pauseTimer();
    } else {
      startTimer();
    }
    _isRunning.toggle();
  }

  void startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      _result.value = formatTime(_stopwatch.elapsedMilliseconds);
    });
  }

  void pauseTimer() {
    _stopwatch.stop();
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
}