import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;
  UpdateTaskUseCase(this.repository);

  Future execute(Task task) async {
    await repository.updateTask(task);
  }
}