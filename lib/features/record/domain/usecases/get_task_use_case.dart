import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/repositories/task_repository.dart';

class GetTaskUseCase {
  final TaskRepository repository;
  GetTaskUseCase(this.repository);

  Future execute() async {
    await repository.getTasks();
  }
}