import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  /* Record Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxList<String> _tasks = <String>[].obs;

  List<String> get tasks => _tasks;

  late final Rx<Task> _editingTask = createInitTask().obs;

  Task get editingTask => _editingTask.value;

  late final Rx<
      TextEditingController> _taskTitleController = TextEditingController().obs;

  TextEditingController get taskTitleController => _taskTitleController.value;

  late final RxBool _isFormValid = false.obs;

  bool get isFormValid => _isFormValid.value;

  Task createInitTask({Task? existingTask}) {
    final id = existingTask?.id ?? const Uuid().v4();
    final title = existingTask?.title ?? '';
    final color = existingTask?.color ?? ThemeColor.colorList[0];
    return Task(
        id: id,
        title: title,
        color: color,
    );
  }

  Future<void> addTask(String task) async {
    _tasks.add(task);
  }

  Future<void> removeTask(int index) async {
    _tasks.removeAt(index);
  }

  Future<void> onSavePressed() async {
    if (isFormValid) {
      await _createTaskUseCase.execute(_editingTask.value);
      update();
    }
  }

  void checkFormValidity() {
    bool validity = _taskTitleController.value.text.isNotEmpty &&
        _taskTitleController.value.text.length <= 60;
    _isFormValid.value = validity;
  }


/* ------------------------------------------------------ */
/* Init & Dispose --------------------------------------- */
/* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();
    // getSchedules().then((onValue) => updateSelectedDate(_selectedDate.value));
  }

  @override
  void onClose() {
    _taskTitleController.value.dispose();
    super.onClose();
  }
}