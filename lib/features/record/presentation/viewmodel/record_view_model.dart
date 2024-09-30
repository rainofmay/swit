import 'package:get/get.dart';
import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/study/schedule/presentation/widgets/color_section.dart';
import 'package:swit/shared/constant/schedule_color.dart';
import 'package:table_calendar/table_calendar.dart';

class RecordViewModel extends GetxController {

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

  Task createInitTask({Task? existingTask}) {
    final title = existingTask?.title ?? '';
    final color = existingTask?.color ?? ScheduleColor.colorList[0];
    return Task(
        title: title,
        color: color
    );
  }

  Future<void> addTask(String task) async {
    _tasks.add(task);
  }

  Future<void> removeTask(int index) async {
    _tasks.removeAt(index);
  }

}