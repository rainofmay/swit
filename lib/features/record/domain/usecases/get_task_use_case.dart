import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/repositories/task_repository.dart';

class GetTaskUseCase {
  final TaskRepository repository;
  GetTaskUseCase(this.repository);

  Future<List<Task>> execute() async {
    return await repository.getTasks();
  }
}