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
  late final RxList<Task> _tasks = <Task>[].obs;
  List<Task> get tasks => _tasks;

  late final Rx<Task> _editingTask = createInitTask().obs;
  Task get editingTask => _editingTask.value;

  late final Rx<TextEditingController> _taskTitleController = TextEditingController().obs;
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


  Future<void> onSavePressed() async {
    if (isFormValid) {
      final taskToSave = Task(
        id: _editingTask.value.id,
        title: _taskTitleController.value.text,
        color: _editingTask.value.color,
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
      getTasks();
      update();

    } catch(e) {
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
        // _editingTask.update((val) {
        //   val?.title = _taskTitleController.value.text;
        // });

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
  /* Init & Dispose --------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();
    _taskTitleController.value.addListener(() {
      checkFormValidity();
    });

    getTasks();
  }

  @override
  void onClose() {
    _taskTitleController.value.dispose();
    super.onClose();
  }
}