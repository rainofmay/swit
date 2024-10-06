import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/repositories/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository repository;
  CreateTaskUseCase(this.repository);

  Future execute(Task task) async {
    await repository.createTask(task);
  }
}