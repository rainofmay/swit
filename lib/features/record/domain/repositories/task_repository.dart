import 'package:swit/features/record/domain/entities/task.dart';

abstract class TaskRepository {
  Future getTasks();

  Future createTask(Task task);

  Future updateTask(Task task);

  Future deleteTask(Task task);
}