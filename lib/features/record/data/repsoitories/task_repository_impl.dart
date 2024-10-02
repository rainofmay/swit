import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:swit/core/utils/record/task_mapper.dart';
import 'package:swit/features/record/data/datasources/task_remote_data_source.dart';
import 'package:swit/features/record/data/models/task_dto.dart';
import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository{
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl(this.remoteDataSource);


  @override
  Future<List<Task>> getTasks() async {
    try {
      final rawData = await remoteDataSource.getTasks();
      // print('Repository Task Raw data: $rawData');
      return rawData.map((json) {
            final dto = TaskDTO.fromJson(json);
            return TaskMapper.toEntity(dto);
      }).toList();
    } catch (e) {
      throw Exception('RepositoryImpl Failed to get tasks: $e');
    }
  }

  @override
  Future<void> createTask(Task task) async {
    try {
      final dto = TaskMapper.toDTO(task);
      await remoteDataSource.createTask(dto);
    } catch (e) {
      throw Exception('RepositoryImpl Failed to create task: $e');
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    try {
      final dto = TaskMapper.toDTO(task);
      await remoteDataSource.updateTask(dto);
    } catch (e) {
      throw Exception('RepositoryImpl Failed to update task: $e');
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    try {
      final dto = TaskMapper.toDTO(task);
      await remoteDataSource.deleteTask(dto);
    } catch (e) {
      throw Exception('RepositoryImpl Failed to delete task: $e');
    }
  }
}