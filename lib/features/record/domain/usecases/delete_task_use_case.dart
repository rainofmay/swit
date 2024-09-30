import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;
  DeleteTaskUseCase(this.repository);

  Future execute(Task task) async {
    await repository.deleteTask(task);
  }
}