import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swit/features/record/data/models/task_dto.dart';

class TaskRemoteDataSource {
  TaskRemoteDataSource._internal();

  static final TaskRemoteDataSource _instance = TaskRemoteDataSource._internal();

  factory TaskRemoteDataSource() {
    return _instance;
  }

  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      final response = await _supabase
          .from('task')
          .select()
          .order('created_at', ascending: false);

      return response;
    } catch (e) {
      throw Exception('Remote DataSource Failed to get tasks: $e');
    }
  }

  Future<void> createTask(TaskDTO dto) async {
    try {
      await _supabase.from('task').insert({
        'title': dto.title,
        'color': dto.color,
      });
    } catch (e) {
      throw Exception('Remote DataSource Failed to create task: $e');
    }
  }

  Future<void> updateTask(TaskDTO dto) async {
    try {
      await _supabase
          .from('task')
          .update({
        'title': dto.title,
        'color': dto.color,
      })
          .eq('id', dto.id);
    } catch (e) {
      throw Exception('Remote DataSource Failed to update task: $e');
    }
  }

  Future<void> deleteTask(TaskDTO dto) async {
    try {
      await _supabase
          .from('task')
          .delete()
          .eq('id', dto.id);
    } catch (e) {
      throw Exception('Remote DataSource Failed to delete task: $e');
    }
  }
}