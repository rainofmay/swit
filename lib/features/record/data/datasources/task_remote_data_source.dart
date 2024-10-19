import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swit/core/data/base_remote_datasource.dart';
import 'package:swit/features/record/data/models/task_dto.dart';

class TaskRemoteDataSource extends BaseRemoteDataSource{


  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      final response = await supabase
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
      await supabase.from('task').insert({
        'title': dto.title,
        'color': dto.color,
      });
    } catch (e) {
      throw Exception('Remote DataSource Failed to create task: $e');
    }
  }

  Future<void> updateTask(TaskDTO dto) async {
    try {
      await supabase
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
      await supabase
          .from('task')
          .delete()
          .eq('id', dto.id);
    } catch (e) {
      throw Exception('Remote DataSource Failed to delete task: $e');
    }
  }
}